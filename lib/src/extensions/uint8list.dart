import 'dart:convert';
import 'dart:typed_data';

extension BWExUint8List on Uint8List {
  int _toInt32BE(int p1, int p2, int p3, int p4) {
    return p4 + (p3 << 8) + (p2 << 16) + (p1 << 24);
  }

  int _toInt16BE(int p1, int p2) {
//    return p4 + (p3 << 8) + (p2 << 16) + (p1 << 24);
    return p2 + (p1 << 8);
  }

  int toInt16BE({
    int offset = 0,
  }) {
    final arr = getRange(offset, offset + 2).toList();
    return _toInt16BE(arr[0], arr[1]);
  }

  int toInt16LE({
    int offset = 0,
  }) {
    final arr = getRange(offset, offset + 2).toList().reversed.toList();
    return _toInt16BE(arr[0], arr[1]);
  }

  int toInt32BE({
    int offset = 0,
  }) {
    final arr = getRange(offset, offset + 4).toList();
    return _toInt32BE(arr[0], arr[1], arr[2], arr[3]);
  }

  int toInt32LE({
    int offset = 0,
  }) {
    final arr = getRange(offset, offset + 4).toList().reversed.toList();
    return _toInt32BE(arr[0], arr[1], arr[2], arr[3]);
  }

  String convertToStringUTF8() {
    return Utf8Decoder().convert(this);
  }

  String convertToStringLatin1() {
    return Latin1Decoder().convert(this);
  }

  List<int> read(int lentgth, {int startPos = 0}) {
    final value = skip(startPos).take(lentgth).toList();
    if (startPos > 0) {
      startPos += lentgth;
    }
    return value;
  }
}
