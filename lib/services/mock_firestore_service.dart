import 'dart:math';


abstract class FirestoreService {
  Future<List<Map<String, dynamic>>> getItems();
  Future<void> updateItem(String id, Map<String, dynamic> data);
  Future<void> consumeItem(String id);
  Future<List<Map<String, dynamic>>> batchCreateItems(
      List<Map<String, dynamic>> items);
}

class MockFirestoreService implements FirestoreService {
  // Simulate data storage
  final List<Map<String, dynamic>> _items = [
    {
      'id': '1',
      'name': 'Milk',
      'expiryDate':
          DateTime.now().add(const Duration(days: 7)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 9,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '2',
      'name': 'Fresh Chicken',
      'expiryDate': DateTime(2024, 2, 18).toIso8601String(),
      'location': 'Fridge',
      'quantity': 1,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '3',
      'name': 'Spinach',
      'expiryDate': DateTime(2024, 2, 19).toIso8601String(),
      'location': 'Fridge',
      'quantity': 2,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '4',
      'name': 'Tomatoes',
      'expiryDate':
          DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      'location': 'Counter',
      'quantity': 6,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '5',
      'name': 'Yogurt',
      'expiryDate':
          DateTime.now().add(const Duration(days: 10)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 4,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '6',
      'name': 'Bread',
      'expiryDate':
          DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      'location': 'Pantry',
      'quantity': 2,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '7',
      'name': 'Eggs',
      'expiryDate':
          DateTime.now().add(const Duration(days: 14)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 12,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '8',
      'name': 'Ground Beef',
      'expiryDate':
          DateTime.now().add(const Duration(days: 3)).toIso8601String(),
      'location': 'Freezer',
      'quantity': 2,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '9',
      'name': 'Bell Peppers',
      'expiryDate':
          DateTime.now().add(const Duration(days: 6)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 3,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '10',
      'name': 'Rice',
      'expiryDate':
          DateTime.now().add(const Duration(days: 180)).toIso8601String(),
      'location': 'Pantry',
      'quantity': 1,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '11',
      'name': 'Salmon Fillet',
      'expiryDate':
          DateTime.now().add(const Duration(days: 2)).toIso8601String(),
      'location': 'Freezer',
      'quantity': 4,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '12',
      'name': 'Avocados',
      'expiryDate': DateTime(2024, 2, 17).toIso8601String(),
      'location': 'Counter',
      'quantity': 3,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': true,
      'isConsumed': false,
    },
    {
      'id': '13',
      'name': 'Pasta Sauce',
      'expiryDate':
          DateTime.now().add(const Duration(days: 90)).toIso8601String(),
      'location': 'Pantry',
      'quantity': 2,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '14',
      'name': 'Greek Yogurt',
      'expiryDate':
          DateTime.now().add(const Duration(days: 12)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 3,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '15',
      'name': 'Mushrooms',
      'expiryDate': DateTime(2024, 2, 19).toIso8601String(),
      'location': 'Fridge',
      'quantity': 1,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '16',
      'name': 'Orange Juice',
      'expiryDate':
          DateTime.now().add(const Duration(days: 8)).toIso8601String(),
      'location': 'Fridge',
      'quantity': 1,
      'isPackaged': true,
      'imagePath': null,
      'isExpiryAssumed': false,
      'isConsumed': false,
    },
    {
      'id': '17',
      'name': 'Bananas',
      'expiryDate':
          DateTime.now().add(const Duration(days: 5)).toIso8601String(),
      'location': 'Counter',
      'quantity': 6,
      'isPackaged': false,
      'imagePath': null,
      'isExpiryAssumed': true,
      'isConsumed': false,
    },
  ];
  final _random = Random();

  String _generateId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(20, (index) => chars[_random.nextInt(chars.length)])
        .join();
  }

  @override
  Future<List<Map<String, dynamic>>> getItems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _items;
  }

  @override
  Future<void> updateItem(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _items[index] = {
        ..._items[index],
        ...data,
      };
    }
  }

  @override
  Future<List<Map<String, dynamic>>> batchCreateItems(
      List<Map<String, dynamic>> items) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final newItems = items.map((item) {
      final newItem = {
        ...item,
        'id': _generateId(), // Ensure each item has an ID
        'createdAt': DateTime.now().toIso8601String(),
      };
      _items.add(newItem);
      return newItem;
    }).toList();

    return newItems;
  }

  @override
  Future<void> consumeItem(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final index = _items.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _items[index]['isConsumed'] = true;
    }
  }
}
