import 'package:flutter/foundation.dart';
import 'package:parsing_util/parsing_util.dart';

class ParsingUtil {
  static String toSafeString(Object? object, {String defaultValue = '', String? modelName}) {
    return isEmptyValue(object?.orEmpty().orNullString()) ? defaultValue : object.toString();
  }

  static int toSafeInt(Object? object, {int defaultValue = -1, String? modelName}) {
    if (object == null) return defaultValue;
    if (object is int) return object;
    if (object is double) return object.toInt();
    if (object is String) {
      int? parsedInt = int.tryParse(object);
      if (parsedInt != null) return parsedInt;
      double? parsedDouble = double.tryParse(object);
      if (parsedDouble != null) return parsedDouble.toInt();
    }
    return defaultValue;
  }

  static double toSafeDouble(Object? object, {double defaultValue = 0.0, String? modelName}) {
    if (object == null) return defaultValue;
    if (object is double) return object;
    if (object is int) return object.toDouble();
    if (object is String) return double.tryParse(object) ?? defaultValue;
    return defaultValue;
  }

  static bool toSafeBoolean(Object? object, {bool defaultValue = false, String? modelName}) {
    if (object == null) return defaultValue;
    if (object is bool) return object;
    if (object is int) return object == 1;
    if (object is String) {
      var lowerCaseValue = object.toLowerCase();
      return lowerCaseValue == 'true' || lowerCaseValue == '1';
    }
    return defaultValue;
  }

  static String toSafeAddress(String? address, {String defaultValue = '', String? modelName}) {
    try {
      String decodedAddress = Uri.decodeFull(toSafeString(address, modelName: modelName));
      return decodedAddress.replaceAll('+', ' ');
    } catch (e) {
      return toSafeString(address, defaultValue: defaultValue, modelName: modelName);
    }
  }

  static DateTime? toSafeDateTime(dynamic value, {String? modelName}) {
    if (value == null) return null;

    if (value is DateTime) return value;

    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        if (kDebugMode) {
          debugPrint('ParsingUtil ($modelName): Error parsing DateTime "$value": $e');
        }
        return null;
      }
    }

    if (kDebugMode) {
      debugPrint('ParsingUtil ($modelName): Could not parse "$value" (${value.runtimeType}) as DateTime');
    }
    return null;
  }

  static List<T> toSafeList<T>(dynamic listData, T Function(dynamic) parser, {String? modelName}) {
    if (listData is List) {
      final List<T> result = [];
      for (final item in listData) {
        try {
          final parsedItem = parser(item);
          if (parsedItem != null) {
            result.add(parsedItem);
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('ParsingUtil ($modelName): Error parsing item "$item" (${item.runtimeType}) in list: $e');
          }
        }
      }
      return result;
    }

    if (listData != null && kDebugMode) {
      debugPrint('ParsingUtil ($modelName): Expected a List but got ${listData.runtimeType}');
    }
    return [];
  }

  static int toValidId(Object? id, {String? modelName}) {
    if (id == null) {
      throw ArgumentError("ParsingUtil ($modelName): ID cannot be null.");
    }
    if (id is int && id > 0) {
      return id;
    }
    if (id is String) {
      final parsedId = int.tryParse(id);
      if (parsedId != null && parsedId > 0) {
        return parsedId;
      }
    }
    throw ArgumentError("ParsingUtil ($modelName): Invalid ID: $id. Must be a valid and positive integer.");
  }

  static bool isEmptyValue(Object? object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) return true;
    if (object is Iterable && object.isEmpty) return true;
    if (object is Map && object.isEmpty) return true;
    return false;
  }

  static bool isNotEmptyValue(Object? object) {
    return !isEmptyValue(object);
  }

  static bool isOfType<T>(Object? object) {
    return object is T;
  }

  static T? asType<T>(Object? object) {
    if (isOfType<T>(object)) {
      return object as T;
    }
    return null;
  }
}
