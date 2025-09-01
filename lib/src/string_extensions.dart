extension StringExtension on String {
  String capitalizeFirstLetter() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }

  String orEmpty() {
    return trim().isNotEmpty ? trim() : '';
  }

  String cleanUp() {
    return trim().toLowerCase();
  }

  String removeTrailingZeros() {
    double val = double.parse(this);
    String splitVal = val.toString().split('.').last;
    return int.parse(splitVal) > 0 ? val.toString() : val.toStringAsFixed(0);
  }

  String getFileName() {
    if (contains('/')) {
      return split('/').last;
    } else {
      return this;
    }
  }
}

extension DoubleExtensions on double {
  String removeTrailingZeros() {
    double val = this;
    String splitVal = val.toString().split('.').last;
    return int.parse(splitVal) > 0 ? val.toString() : val.toStringAsFixed(0);
  }
}

extension NullableStringExtension on String? {
  String orEmpty() {
    return this?.orEmpty() ?? '';
  }
}

extension ObjectExtension on Object {
  String orEmpty() {
    return toString().orEmpty();
  }

  String orNullString() {
    return toString().toLowerCase() == "null" ? '' : toString();
  }
}

extension NullableObjectExtension on Object? {
  String orEmpty() {
    return this?.toString() ?? '';
  }
}
