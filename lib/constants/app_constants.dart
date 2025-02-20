class AppConstants {
  // App Information
  static const String appName = 'Food Tracker';
  static const String appVersion = '1.0.0';

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration snackBarDuration = Duration(seconds: 4);

  // API/Service Constants
  static const int serviceTimeout = 30; // seconds
  static const Duration mockDelay = Duration(milliseconds: 500);

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double cardElevation = 2.0;
  static const double iconSize = 24.0;
  static const double emptyStateIconSize = 48.0;

  // Storage Keys
  static const String themePreferenceKey = 'theme_preference';
  static const String userPreferencesKey = 'user_preferences';

  // Error Messages
  static const String defaultErrorMessage = 'Something went wrong';
  static const String networkErrorMessage = 'Network error occurred';
  static const String itemNotFoundError = 'Item not found';

  // Success Messages
  static const String itemUpdatedSuccess = 'Item updated successfully';
  static const String itemConsumedSuccess = 'Item marked as consumed';
  static const String itemRestoredSuccess = 'Item restored successfully';
} 