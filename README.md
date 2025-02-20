# Food Expiry Tracker

A modern Flutter application for tracking food items and their expiry dates. Built with Material Design 3 and clean architecture principles.

## Features

### Item Management

- Track available food items with expiry dates
- Monitor expired items in a separate tab
- Keep history of consumed items
- Undo/Redo support for item actions
- Multi-location storage tracking (Fridge, Freezer, Pantry, Counter)
- Quantity tracking for packaged items
- Smart expiry date handling with assumed dates

### Smart UI Components

- Custom animated bottom navigation bar with floating design
- Responsive item cards with expiry indicators and status colors
- Interactive item details sheet with edit capabilities
- Confirmation dialogs for expired item consumption
- Snackbar notifications with undo actions
- Loading states and error handling

### Design & UX

- Material Design 3 implementation
- Custom theme with DM Sans font
- Consistent elevation and shadows
- Smooth animations and transitions
- Color-coded status indicators
- Intuitive navigation system
- Responsive layout with MediaQuery
- Dynamic sizing for different screen sizes
- Adaptive UI elements and typography
- Consistent spacing and proportions

## Technical Details

### Responsive Design

```dart
class Responsive {
  // Screen dimensions
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  // Dynamic sizing
  static double defaultPadding(BuildContext context) => screenWidth(context) * 0.04;
  static double titleSize(BuildContext context) => screenWidth(context) * 0.055;
  static double cardHeight(BuildContext context) => screenHeight(context) * 0.12;
}
```

### Architecture

```
lib/
├── constants/
│   ├── app_constants.dart    // App-wide constants
│   ├── responsive_constants.dart  // Responsive sizing
│   └── ui_constants.dart     // UI-specific values
├── models/
│   └── item_data.dart       // Data models
├── providers/
│   └── items_provider.dart  // State management
├── screens/
│   ├── items_screen.dart    // Main screen
│   └── tabs/               // Tab views
├── services/
│   └── mock_firestore_service.dart  // Data layer
├── themes/
│   └── app_theme.dart       // Theme configuration
└── widgets/
    ├── navigation/
    │   └── custom_bottom_nav_bar.dart
    └── item_card.dart
```

### Key Components

#### State Management

```dart
class ItemsProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  List<ItemData> _items = [];
  // Reactive state management with error handling
}
```

#### Custom Bottom Navigation

```dart
class CustomBottomNavBar extends StatelessWidget {
  // Animated container with Material Design 3
  // Dynamic icon sizing and transitions
}
```

#### Theme System

```dart
class AppTheme {
  static const Color iconGrey = Color(0xFF757575);
  static const Color textGrey = Color(0xFF616161);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // Comprehensive theming system
  );
}
```

## Getting Started

1. **Prerequisites**

   - Flutter SDK >=3.0.0
   - Dart SDK >=3.0.0

2. **Installation**

   ```bash
   git clone [repository-url]
   cd food-tracker
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1 # State management

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

## Development Features

- **State Management**: Provider pattern with ChangeNotifier
- **Mock Services**: Simulated backend with realistic delays
- **Error Handling**: Comprehensive error states and user feedback
- **Animations**: Custom transitions and loading states
- **Theme System**: Material Design 3 with custom components
- **Responsive Design**: MediaQuery implementation

## Best Practices

- Clean Architecture principles
- Separation of concerns
- Reactive state management
- Widget composition and reusability
- Type safety throughout
- Performance optimization
- Responsive design patterns
- Error boundary implementation
- Consistent code formatting
- Comprehensive error handling

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Design Decisions

### Architecture & State Management

- **Provider Pattern**: Chosen for its simplicity and efficiency in managing app-wide state without unnecessary complexity
- **Clean Architecture**: Separated concerns into models, providers, services, and UI layers for better maintainability
- **Mock Service Layer**: Implemented to simulate real-world API delays and error scenarios

### UI/UX Decisions

- **Bottom Navigation**: Custom floating design for better visual hierarchy and modern feel
- **Card-based Layout**: Used for consistent item presentation and clear visual separation
- **Color Coding**:
  - Grey for normal items
  - Red for expired items
  - Green for consumed items
  - Subtle backgrounds for better contrast

### Feature Implementation

1. **Expiry Tracking**:

   - Maintains expiry dates even after consumption
   - Shows warning dialogs for expired items
   - Allows past date selection for accurate tracking

2. **Item States**:

   - Available: Active items in inventory
   - Consumed: Items marked as used
   - Expired: Items past their expiry date
   - Each state has distinct UI treatment

3. **Undo/Redo Support**:

   - Implemented for critical actions
   - Snackbar notifications with undo option
   - State preservation during undo operations

4. **Error Handling**:
   - Comprehensive error states
   - User-friendly error messages
   - Graceful fallbacks for edge cases

### Performance Considerations

- Optimized list rendering
- Minimal rebuilds using `Consumer`
- Efficient state updates
- Smooth animations with hardware acceleration

These decisions focus on creating a maintainable, user-friendly, and performant application while following Flutter best practices.

### Responsive Features

1. **Dynamic Sizing**

   - Screen-aware dimensions
   - Proportional spacing
   - Flexible layouts

2. **Adaptive Components**

   - Responsive text sizing
   - Dynamic card heights
   - Flexible navigation bar

3. **Layout Considerations**
   - Safe area handling
   - Notch compatibility
   - Keyboard adjustments
