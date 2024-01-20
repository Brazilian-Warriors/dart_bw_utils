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
    return ByteData.sublistView(Uint8List.fromList(this));
  }

  List<int> findAllSublistPositionWhere(
    List<int> valueToFind, {
    bool findOnlyFirst = false,
    int start = 0,
    int end = 0,
  }) {
    return _findPositionInListWhere(
        this, valueToFind, findOnlyFirst, start, end);
  }

  int findFirstSublistPositionWhere(
    List<int> valueToFind, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInListWhere(this, valueToFind, true, start, end);

    return value.isEmpty ? -1 : value.first;
  }
}

List<int> _findPositionInListWhere(
  List<int> originalList,
  List<int> valueToFind, [
  bool findOnlyFirst = false,
  int start = 0,
  int endList = 0,
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

  int subListLength = valueToFind.length + start;

  if ((endList == 0) || (endList > originalList.length)) {
    endList = originalList.length;
  }

  if (((endList - start) < subListLength) || (endList <= start)) {
    endList = subListLength;
  }

  if (endList < originalList.length) {
    endList++;
  }

  List<int> position = [];
  bool equalValue = false;

  do {
    final subList = originalList.sublist(start, subListLength);
    equalValue = false;
    final int startPos = start;
    for (var i = 0; i < subList.length; i++) {
      equalValue = subList[i] == valueToFind[i];

      start++;
      subListLength++;

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
  } while (subListLength <= endList);
  return position;
}
