import 'dart:convert';
import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

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
    return ByteData.sublistView(_toUint8List(this));
  }

  List<int> findAllSublistPositionWhere(
    List<int> valueToFind, {
    bool findOnlyFirst = false,
    int start = 0,
    int end = 0,
  }) {
    return _findPositionInListWhere(_toUint8List(this),
        _toUint8List(valueToFind), findOnlyFirst, start, end);
  }

  int findFirstSublistPositionWhere(
    List<int> valueToFind, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInListWhere(
        _toUint8List(this), _toUint8List(valueToFind), true, start, end);

    return value.isEmpty ? -1 : value.first;
  }

  bool containsSublist(
    List<int> subList, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInListWhere(
        _toUint8List(this), _toUint8List(subList), true, start, end);

    return value.isNotEmpty;
  }
}

Uint8List _toUint8List(List<int> value) =>
    (value is Uint8List) ? value : Uint8List.fromList(value);

List<int> _findPositionInListWhere(
  Uint8List originalList,
  Uint8List valueToFind, [
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
  Uint8List subList = Uint8List(valueToFind.length);
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
