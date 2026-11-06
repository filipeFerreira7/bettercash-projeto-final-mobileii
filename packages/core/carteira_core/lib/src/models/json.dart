/// Alias for JSON map objects.
typedef Json = Map<String, Object?>;

/// Helper extensions for type-safe JSON extraction.
extension JsonExtract on Json {
  String getString(String key, {String defaultValue = ''}) {
    final value = this[key];
    return value is String ? value : defaultValue;
  }

  double getDouble(String key, {double defaultValue = 0.0}) {
    final value = this[key];
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  int getInt(String key, {int defaultValue = 0}) {
    final value = this[key];
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  DateTime? getDateTime(String key) {
    final value = this[key];
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
