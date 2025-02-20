class ItemData {
  final String? id;
  final String name;
  final DateTime expiryDate;
  final String location;
  final int quantity;
  final bool isPackaged;
  final String? imagePath;
  final bool isExpiryAssumed;
  final bool isConsumed;
  final DateTime? consumedAt;

  const ItemData({
    this.id,
    required this.name,
    required this.expiryDate,
    required this.location,
    this.quantity = 1,
    this.isPackaged = false,
    this.imagePath,
    this.isExpiryAssumed = false,
    this.isConsumed = false,
    this.consumedAt,
  });

  ItemData copyWith({
    String? id,
    String? name,
    DateTime? expiryDate,
    String? location,
    int? quantity,
    bool? isPackaged,
    String? imagePath,
    bool? isExpiryAssumed,
    bool? isConsumed,
    DateTime? consumedAt,
  }) {
    return ItemData(
      id: id ?? this.id,
      name: name ?? this.name,
      expiryDate: expiryDate ?? this.expiryDate,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
      isPackaged: isPackaged ?? this.isPackaged,
      imagePath: imagePath ?? this.imagePath,
      isExpiryAssumed: isExpiryAssumed ?? this.isExpiryAssumed,
      isConsumed: isConsumed ?? this.isConsumed,
      consumedAt: consumedAt ?? this.consumedAt,
    );
  }

  factory ItemData.fromMap(Map<String, dynamic> map) {
    return ItemData(
      id: map['id'] as String?,
      name: map['name'] as String,
      expiryDate: DateTime.parse(map['expiryDate'] as String),
      location: map['location'] as String,
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      isPackaged: map['isPackaged'] as bool? ?? false,
      imagePath: map['imagePath'] as String?,
      isExpiryAssumed: map['isExpiryAssumed'] as bool? ?? false,
      isConsumed: map['isConsumed'] as bool? ?? false,
      consumedAt: map['consumedAt'] != null
          ? DateTime.parse(map['consumedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'expiryDate': expiryDate.toIso8601String(),
      'location': location,
      'quantity': quantity,
      'isPackaged': isPackaged,
      if (imagePath != null) 'imagePath': imagePath,
      'isExpiryAssumed': isExpiryAssumed,
      'isConsumed': isConsumed,
      if (consumedAt != null) 'consumedAt': consumedAt!.toIso8601String(),
    };
  }

  int get daysUntilExpiry {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryEndOfDay = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
      23,
      59,
      59,
    );
    return expiryEndOfDay.difference(todayStart).inDays;
  }

  bool get isExpired {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final expiryStart = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
    );
    return expiryStart.isBefore(todayStart);
  }
}
