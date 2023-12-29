import 'dart:io';
import 'dart:typed_data';
import 'package:bw_utils/bw_utils.dart';

extension BWReadToNumber on RandomAccessFile {
  static Endian _endian = getEndian;

  int get readInt64 {
    return readSync(8).buffer.asByteData().getInt64(0, _endian);
  }

  int get readInt32 {
    return readSync(4).buffer.asByteData().getInt32(0, _endian);
  }

  int get readInt16 {
    return readSync(2).buffer.asByteData().getInt16(0, _endian);
  }

  int get readInt8 {
    return readSync(1).buffer.asByteData().getInt8(0);
  }

  int get readUint64 {
    return readSync(8).buffer.asByteData().getUint64(0, _endian);
  }

  int get readUint32 {
    return readSync(4).buffer.asByteData().getUint32(0, _endian);
  }

  int get readUint16 {
    return readSync(2).buffer.asByteData().getUint16(0, _endian);
  }

  int get readUint8 {
    return readSync(1).buffer.asByteData().getUint8(0);
  }

  double get readFloat32 {
    return readSync(4).buffer.asByteData().getFloat32(0, _endian);
  }

  double get readFloat64 {
    return readSync(8).buffer.asByteData().getFloat64(0, _endian);
  }
}
