
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_data.dart';
import '../providers/items_provider.dart';
import '../themes/app_theme.dart';
import '../constants/ui_constants.dart';

class ItemDetailsSheet extends StatefulWidget {
  final ItemData item;

  const ItemDetailsSheet({
    super.key,
    required this.item,
  });

  @override
  State<ItemDetailsSheet> createState() => _ItemDetailsSheetState();
}

class _ItemDetailsSheetState extends State<ItemDetailsSheet>
    with SingleTickerProviderStateMixin {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _quantityController;
  late DateTime _selectedDate;
  late bool _isPackaged;
  bool _isEditing = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.item.name);
    _locationController = TextEditingController(text: widget.item.location);
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _selectedDate = widget.item.expiryDate;
    _isPackaged = widget.item.isPackaged;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _quantityController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              surface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveChanges(BuildContext context) async {
    try {
      final updatedItem = widget.item.copyWith(
        name: _nameController.text,
        location: _locationController.text,
        quantity:
            int.tryParse(_quantityController.text) ?? widget.item.quantity,
        expiryDate: _selectedDate,
        isPackaged: _isPackaged,
      );

      await Provider.of<ItemsProvider>(context, listen: false)
          .updateItem(updatedItem);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating item: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpired = widget.item.isExpired;

    return FadeTransition(
      opacity: _animation,
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: UIConstants.borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(theme, isExpired),
            Flexible(
              child: SingleChildScrollView(
                padding: UIConstants.contentPadding,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(
                      theme,
                      title: 'Basic Information',
                      icon: Icons.info_outline,
                      content: _buildBasicInfo(theme),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      theme,
                      title: 'Storage Details',
                      icon: Icons.inventory_2,
                      content: _buildStorageInfo(theme),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoCard(
                      theme,
                      title: 'Expiry Information',
                      icon: Icons.event,
                      isExpired: isExpired,
                      content: _buildExpiryInfo(theme),
                    ),
                    if (widget.item.isConsumed) ...[
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        theme,
                        title: 'Consumption Status',
                        icon: Icons.check_circle,
                        color: Colors.green,
                        content: _buildConsumptionInfo(theme),
                      ),
                    ],
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, bool isExpired) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _isEditing ? 'Edit Item' : 'Item Details',
            style: theme.textTheme.titleLarge,
          ),
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing
                ? () => _saveChanges(context)
                : () => setState(() => _isEditing = true),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    ThemeData theme, {
    required String title,
    required IconData icon,
    required Widget content,
    Color? color,
    bool isExpired = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.cardDecoration.copyWith(
        border: Border.all(
          color: isExpired ? Colors.red.withOpacity(0.5) : theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isExpired ? Colors.red : color ?? theme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isExpired ? Colors.red : null,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          icon: Icons.inventory,
          label: 'Name',
          controller: _nameController,
          enabled: _isEditing,
        ),
        const SizedBox(height: 12),
        _buildTextField(
          icon: Icons.location_on,
          label: 'Location',
          controller: _locationController,
          enabled: _isEditing,
        ),
      ],
    );
  }

  Widget _buildStorageInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          icon: Icons.numbers,
          label: 'Quantity',
          controller: _quantityController,
          enabled: _isEditing,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        _buildPackagedSwitch(),
      ],
    );
  }

  Widget _buildExpiryInfo(ThemeData theme) {
    final isExpired = widget.item.isExpired;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _isEditing ? () => _selectDate(context) : null,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(8),
              color: isExpired ? Colors.red.withOpacity(0.1) : null,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event,
                  color: isExpired ? Colors.red : theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry Date',
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      _formatDate(_selectedDate),
                      style: TextStyle(
                        color: isExpired ? Colors.red : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConsumptionInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.withOpacity(0.1),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Consumed On', style: theme.textTheme.bodySmall),
                  Text(
                    _formatDate(widget.item.consumedAt!),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled && _isEditing,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: !enabled || !_isEditing,
          fillColor:
              !enabled || !_isEditing ? Colors.grey.withOpacity(0.1) : null,
        ),
      ),
    );
  }

  Widget _buildPackagedSwitch() {
    return ListTile(
      leading: const Icon(Icons.inventory_2),
      title: const Text('Packaged Item'),
      contentPadding: EdgeInsets.zero,
      trailing: Switch(
        value: _isPackaged,
        onChanged:
            _isEditing ? (value) => setState(() => _isPackaged = value) : null,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
