import 'dart:convert';
import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';
import 'package:bw_utils/shared/settings.dart';

extension BWExListInt on List<int> {
  static Endian _endian = getEndian;
  int get toInt8 => _byteData.getInt8(0);
  int get toUint8 => _byteData.getUint8(0);
  int get toInt16 => _byteData.getInt16(0, _endian);
  int get toUint16 => _byteData.getUint16(0, _endian);
  int get toInt32 => _byteData.getInt32(0, _endian);
  int get toUint32 => _byteData.getUint32(0, _endian);
  int get toInt64 => _byteData.getInt64(0, _endian);
  int get toUint64 => _byteData.getUint64(0, _endian);

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
