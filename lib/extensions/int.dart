import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';
import 'package:bw_utils/shared/settings.dart';

extension BWExInt on int {
  static ByteData valueOf64Bit = ByteData(8);
  static ByteData valueOf32Bit = ByteData(4);
  static ByteData valueOf16Bit = ByteData(2);
  static ByteData valueOf8Bit = ByteData(1);
  static Endian _endian = getEndian;

  List<int> toUint8List() {
    return (valueOf8Bit..setUint8(0, this)).buffer.asUint8List();
  }

  List<int> toInt8List() {
    return (valueOf8Bit..setInt8(0, this)).buffer.asInt8List();
  }

  List<int> toUint16List() {
    return (valueOf16Bit..setUint16(0, this, _endian)).buffer.asUint8List();
  }

  List<int> toInt16List() {
    return (valueOf16Bit..setInt16(0, this, _endian)).buffer.asInt8List();
  }

  List<int> toUint32List() {
    return (valueOf32Bit..setUint32(0, this, _endian)).buffer.asUint8List();
  }

  List<int> toInt32List() {
    return (valueOf32Bit..setInt32(0, this, _endian)).buffer.asInt8List();
  }

  List<int> toUint64List() {
    return (valueOf64Bit..setUint64(0, this, _endian)).buffer.asUint8List();
  }

  List<int> toInt64List() {
    return (valueOf32Bit..setInt64(0, this, _endian)).buffer.asInt8List();
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
