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

  List<int> findAllPositionWhere(
    List<int> valueToFind, {
    bool findOnlyFirst = false,
    int start = 0,
    int end = 0,
  }) {
    return _findPositionInListWhere(valueToFind, findOnlyFirst, start, end);
  }

  int findFirstPositionWhere(
    List<int> valueToFind, {
    int start = 0,
    int end = 0,
  }) {
    final value = _findPositionInListWhere(valueToFind, true, start, end);

    return value.isEmpty ? -1 : value.first;
  }

  List<int> _findPositionInListWhere(
    List<int> valueToFind, [
    bool findOnlyFirst = false,
    int start = 0,
    int endList = 0,
  ]) {

    if ((length == 0) || (length < valueToFind.length)) {
      return [];
    }

    if ((start >= length) || ((start + valueToFind.length) > length)) {
      return [];
    }

    if (start < 0) {
      start = 0;
    }

    int subListLength = valueToFind.length + start;

    if ((endList == 0) || (endList > length)) {
      endList = length;
    }

    if (((endList - start) < subListLength) || (endList <= start)) {
      endList = subListLength;
    }

    if (endList < length) {
      endList++;
    }

    List<int> position = [];
    bool equalValue = false;

    do {
      final subList = sublist(start, subListLength);
      equalValue = false;
      for (var i = 0; i < subList.length; i++) {
        equalValue = subList[i] == valueToFind[i];

        if (equalValue == false) {
          break;
        }
      }

      if (equalValue) {
        position.add(start);

        if (findOnlyFirst) {
          break;
        }
      }

      start++;
      subListLength++;
    } while (subListLength <= endList);
    return position;
  }
}
