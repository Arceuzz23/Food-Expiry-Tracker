import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/item_data.dart';
import '../services/mock_firestore_service.dart';

class ItemsProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  List<ItemData> _items = [];
  String? _error;
  bool _loading = false;
  String? _processingItemId;

  ItemsProvider({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? MockFirestoreService();

  List<ItemData> get items => _items.where((item) => !item.isConsumed).toList()
    ..sort((a, b) => a.expiryDate.compareTo(b.expiryDate));

  List<ItemData> get consumedItems =>
      _items.where((item) => item.isConsumed).toList()
        ..sort((a, b) => b.expiryDate.compareTo(a.expiryDate));

  List<ItemData> get expiredItems =>
      items.where((item) => item.isExpired).toList();

  bool get hasExpiredItems => expiredItems.isNotEmpty;
  String? get error => _error;
  bool get loading => _loading;
  String? get processingItemId => _processingItemId;

  Future<Function()?> consumeItem(String itemId) async {
    _processingItemId = itemId;
    _setLoading(true);
    try {
      final index = _items.indexWhere((item) => item.id == itemId);
      if (index == -1) {
        throw Exception('Item not found');
      }

      final previousState = _items[index];
      final updatedItem = _items[index].copyWith(
        isConsumed: true,
        consumedAt: DateTime.now(),
      );
      _items[index] = updatedItem;

      await _firestoreService.updateItem(updatedItem.id!, {
        'isConsumed': true,
        'consumedAt': DateTime.now().toIso8601String(),
      });

      _error = null;
      notifyListeners();

      return () async {
        _items[index] = previousState;
        await _firestoreService.updateItem(previousState.id!, {
          'isConsumed': false,
          'consumedAt': null,
        });
        notifyListeners();
      };
    } catch (e) {
      _error = e.toString();
      debugPrint('Error consuming item: $e');
      return null;
    } finally {
      _processingItemId = null;
      _setLoading(false);
    }
  }

  Future<void> loadItems() async {
    if (_loading) return;

    _setLoading(true);
    try {
      final items = await _firestoreService.getItems();
      debugPrint('Loaded ${items.length} items');
      _items = items.map((itemMap) => ItemData.fromMap(itemMap)).toList();
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading items: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<List<ItemData>> addItems(List<Map<String, dynamic>> items) async {
    _setLoading(true);
    _error = null;
    final List<ItemData> addedItems = [];

    try {
      final newItems = await _firestoreService.batchCreateItems(items);
      addedItems.addAll(newItems.map((itemMap) => ItemData.fromMap(itemMap)));

      _items.addAll(addedItems);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error adding items: $e');
    } finally {
      _setLoading(false);
    }

    return addedItems;
  }

  Future<void> updateItem(ItemData item) async {
    _setLoading(true);
    try {
      await _firestoreService.updateItem(item.id!, item.toMap());
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = item;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      debugPrint('Error updating item: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
