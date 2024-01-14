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
}
