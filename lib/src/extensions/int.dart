import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

extension BWExInt on int {
  static final ByteData _valueOf64Bit = ByteData(8);
  static final ByteData _valueOf32Bit = ByteData(4);
  static final ByteData _valueOf16Bit = ByteData(2);
  static final ByteData _valueOf8Bit = ByteData(1);
  static final Endian _endian = getEndian;

  Uint8List toUint8List() {
    return (_valueOf8Bit..setUint8(0, this)).buffer.asUint8List();
  }

  Int8List toInt8List() {
    return (_valueOf8Bit..setInt8(0, this)).buffer.asInt8List();
  }

  Uint8List toUint16List([Endian? endian]) {
    return (_valueOf16Bit..setUint16(0, this, endian ?? _endian)).buffer.asUint8List();
  }

  Int8List toInt16List([Endian? endian]) {
    return (_valueOf16Bit..setInt16(0, this, endian ?? _endian)).buffer.asInt8List();
  }

  Uint8List toUint32List([Endian? endian]) {
    return (_valueOf32Bit..setUint32(0, this, endian ?? _endian)).buffer.asUint8List();
  }

  Int8List toInt32List([Endian? endian]) {
    return (_valueOf32Bit..setInt32(0, this, endian ?? _endian)).buffer.asInt8List();
  }

  Uint8List toUint64List([Endian? endian]) {
    return (_valueOf64Bit..setUint64(0, this, endian ?? _endian)).buffer.asUint8List();
  }

  Int8List toInt64List([Endian? endian]) {
    return (_valueOf32Bit..setInt64(0, this, endian ?? _endian)).buffer.asInt8List();
  }

  List<int> toInt32LE() {
    final num = this;
    final p1 = num & 0xFF;
    final p2 = num >> 8 & 0xFF;
    final p3 = num >> 16 & 0xFF;
    final p4 = num >> 24 & 0xFF;
    return [p1, p2, p3, p4];
  }

  Uint8List toUint8ListLE() {
    return Uint8List.fromList(toInt32LE());
  }

  Uint8List toUint8ListBE() {
    final num = this;
    final p1 = num & 0xFF;
    final p2 = num >> 8 & 0xFF;
    final p3 = num >> 16 & 0xFF;
    final p4 = num >> 24 & 0xFF;
    return Uint8List.fromList([p4, p3, p2, p1]);
  }

  String toHex() {
    return toRadixString(16).padLeft(2, '0');
  }
}
