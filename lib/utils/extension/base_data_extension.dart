extension BaseStringExtension on String {
  String get toCurrency {
    return 'Rp. ${replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  String get capitalize {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
