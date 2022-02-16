extension BoolParsing on String {
  bool toBool([bool strict = false]) {
    if (strict == true) {
      return this == '1' || this == 'true';
    }
    return this != '0' && this != 'false' && this != '';
  }
}

extension NullableBoolParsing on String {
  bool? toNullableBool([bool strict = false]) {
    if (strict == true) {
      return this == '' ? null : this == '1' || this == 'true';
    }
    return this == '' ? null : this != '0' && this != 'false';
  }
}
