/// allows for parsing list of json objects to preferred type.
/// takes care of handling null list and converts it to empty list
List<T> asList<T>(
  Map<String, dynamic> json,
  String key,
  T Function(Map<String, dynamic> json) itemMapper,
) {
  //ignore: strict_raw_type
  return asT<List>(json, key)
      .cast<Map<String, dynamic>>() //
      .map(itemMapper)
      .toList();
}

List<T> asListPrimitive<T>(
  Map<String, dynamic> json,
  String key,
) {
  //ignore: strict_raw_type
  return asT<List>(json, key)
      .cast<T>() //
      .toList();
}

T asT<T>(
  Map<String, dynamic>? json,
  String key, {
  T? defaultValue,
}) {
  if (json == null || !json.containsKey(key)) {
    if (defaultValue != null) {
      return defaultValue;
    }
    if (0 is T) {
      return 0 as T;
    }
    if (0.0 is T) {
      return 0.0 as T;
    }
    if ('' is T) {
      return '' as T;
    }
    if (false is T) {
      return false as T;
    }
    if ([] is T) {
      return [] as T;
    }
    if (<String, dynamic>{} is T) {
      return <String, dynamic>{} as T;
    }
    return '' as T;
  }
  final dynamic value = json[key];
  if (value is T) {
    return value;
  }

  return _handlePrimitives(value, defaultValue);
}

T _handlePrimitives<T>(dynamic value, T? defaultValue) {
  if (0 is T) {
    return _handleInt(value, defaultValue);
  } else if (0.0 is T) {
    return _handleDouble(value, defaultValue);
  } else if ('' is T) {
    return _handleString(value, defaultValue);
  } else if (false is T) {
    return _handleBool(value, defaultValue);
  } else if ([] is T) {
    return _handleArray(value, defaultValue);
  } else if (<String, dynamic>{} is T) {
    return _handleMap(value, defaultValue);
  }
  return '' as T;
}

T _handleDouble<T>(dynamic value, T? defaultValue) {
  final defaultVal = defaultValue ?? 0.0 as T;
  if (value is int) {
    return value.toDouble() as T;
  } else if (value is bool) {
    return (value ? 1.0 : 0.0) as T;
  } else if (value is String) {
    return double.tryParse(value) as T ?? defaultVal;
  } else {
    return defaultVal!;
  }
}

T _handleInt<T>(dynamic value, T? defaultValue) {
  final defaultVal = defaultValue ?? 0 as T;
  if (value is double) {
    return value.toInt() as T;
  } else if (value is bool) {
    return (value ? 1 : 0) as T;
  } else if (value is String) {
    return (int.tryParse(value) ?? double.tryParse(value)?.toInt() ?? defaultVal) as T;
  } else {
    return defaultVal;
  }
}

T _handleString<T>(dynamic value, T? defaultValue) {
  final defaultVal = defaultValue ?? '' as T;
  if (value is int || value is double) {
    return value.toString() as T;
  } else if (value is bool) {
    return (value ? 'true' : 'false') as T;
  } else {
    return defaultVal;
  }
}

T _handleBool<T>(dynamic value, T? defaultValue) {
  final defaultVal = defaultValue ?? false as T;
  final valueS = value.toString();
  if (valueS == '1' || valueS == '1.0' || valueS.toLowerCase() == 'true') {
    return true as T;
  }
  return defaultVal;
}

T _handleArray<T>(dynamic value, T? defaultValue) {
  return defaultValue ?? [] as T;
}

T _handleMap<T>(dynamic value, T? defaultValue) {
  return defaultValue ?? <String, dynamic>{} as T;
}
