import 'dart:convert';
import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

extension SortBy<T> on List<T> {
  /// ```dart
  ///
  /// // declaration List of Person
  ///  final List<Person> persons = [
  ///    Person(name: 'John Doe', age: 32),
  ///    Person(name: 'Mary Jane', age: 45)
  ///    ];
  ///
  /// // sort persons by name
  ///  persons.sortBy((person) => person.name);
  ///
  /// // sort persons by age descending.
  ///  persons.sortBy((person) => person.age, asc: false);
  ///
  /// // simple list
  ///  final List<int> numbers = [3, 7, 1, 6, 4, 9, 5, 8, 0, 2];
  ///
  ///  numbers.sortBy((value) => value);
  ///
  ///  print(numbers);
  ///
  /// // sort descending
  ///  numbers.sortBy((value) => value, asc: false);
  ///
  ///  print(numbers);
  ///
  /// ```
  List<T> sortBy(Comparable Function(T value) compare, {bool asc = true}) {
    sort((a, b) {
      final aValue = compare(a);
      final bValue = compare(b);
      return asc
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    return this;
  }
}

extension BWExListInt on List<int> {
  static final Endian _endian = getEndian;
  int get toInt8 => _byteData.getInt8(0);
  int get toUint8 => _byteData.getUint8(0);
  int toInt16([Endian? endian]) => _byteData.getInt16(0, endian ?? _endian);
  int toUint16([Endian? endian]) => _byteData.getUint16(0, endian ?? _endian);
  int toInt32([Endian? endian]) => _byteData.getInt32(0, endian ?? _endian);
  int toUint32([Endian? endian]) => _byteData.getUint32(0, endian ?? _endian);
  int toInt64([Endian? endian]) => _byteData.getInt64(0, endian ?? _endian);
  int toUint64([Endian? endian]) => _byteData.getUint64(0, endian ?? _endian);

  String toStringUTF8() {
    return Utf8Decoder().convert(this);
  }

  List<String> asHex() {
    return map((e) => e.toHex()).toList();
  }

  ByteData get _byteData {
    return ByteData.sublistView(Uint8List.fromList(this));
  }

  List<int> findAllPosSync(
    List<int> valueToFind, {
    bool findOnlyFirst = false,
    int start = 0,
    int end = 0,
  }) {
    return _findPositionInList(this, valueToFind, findOnlyFirst, start, end);
  }

  int findFirstPosSync(
    List<int> valueToFind, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInList(this, valueToFind, true, start, end);
    return value.isEmpty ? -1 : value.first;
  }

  bool containsSublistSync(
    List<int> subList, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInList(this, subList, true, start, end);

    return value.isNotEmpty;
  }
}

List<int> _findPositionInList(
  List<int> originalList,
  List<int> valueToFind, [
  bool findOnlyFirst = false,
  int start = 0,
  int end = 0,
]) {
  if ((originalList.isEmpty) || (originalList.length < valueToFind.length)) {
    return [];
  }

  if ((start >= originalList.length) ||
      ((start + valueToFind.length) > originalList.length)) {
    return [];
  }

  if (start < 0) {
    start = 0;
  }

  int subListEnd = valueToFind.length + start;

  if ((end == 0) || (end > originalList.length)) {
    end = originalList.length;
  }

  if (((end - start) < subListEnd) || (end <= start)) {
    end = subListEnd;
  }

  if (end < originalList.length) {
    end++;
  }

  List<int> position = [];
  List<int> subList = List.filled(valueToFind.length, 0);
  bool equalValue = false;
  int startPos = 0;

  do {
    startPos = start;
    subList = originalList.sublist(start, subListEnd);

    for (var i = 0; i < subList.length; i++) {
      equalValue = subList[i] == valueToFind[i];

      start++;
      subListEnd++;

      if (equalValue == false) {
        break;
      }
    }

    if (equalValue) {
      position.add(startPos);

      if (findOnlyFirst) {
        break;
      }
    }
  } while (subListEnd <= end);
  return position;
}
