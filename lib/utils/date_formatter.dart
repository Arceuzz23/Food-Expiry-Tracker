class DateFormatter {
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String getExpiryStatus(int daysUntilExpiry) {
    if (daysUntilExpiry < 0) {
      return 'Expired ${daysUntilExpiry.abs()} days ago';
    }
    return 'Expires in $daysUntilExpiry days';
  }
} 