import 'dart:math';

extension SdListV5X on List<dynamic>? {
  bool get isNullOrEmpty {
    return this == null || (this?.isEmpty ?? true);
  }

  bool get isNotNullAndNotEmpty {
    return !isNullOrEmpty;
  }
}

extension SdRandomItemV5X<T> on List<T> {
  T getRandomItem() {
    if (isEmpty) {
      throw StateError('Cannot get random item from an empty list');
    }
    final random = Random();
    return this[random.nextInt(length)];
  }
}
