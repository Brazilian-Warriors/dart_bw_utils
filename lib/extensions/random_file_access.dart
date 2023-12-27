import 'dart:io';
import 'dart:typed_data';
import 'package:bw_utils/shared/settings.dart';

extension BWReadToNumber on RandomAccessFile {
  int get readInt64 {
    return readSync(8).buffer.asByteData().getInt64(0, getEndian);
  }

  int get readInt32 {
    return readSync(4).buffer.asByteData().getInt32(0, getEndian);
  }

  int get readInt16 {
    return readSync(2).buffer.asByteData().getInt16(0, getEndian);
  }

  int get readInt8 {
    return readSync(1).buffer.asByteData().getInt8(0);
  }

  int get readUint64 {
    return readSync(8).buffer.asByteData().getUint64(0, getEndian);
  }

  int get readUint32 {
    getEndian == Endian.big ? print('BIG') : print('Litte');

    return readSync(4).buffer.asByteData().getUint32(0, getEndian);
  }

  int get readUint16 {
    return readSync(2).buffer.asByteData().getUint16(0, getEndian);
  }

  int get readUint8 {
    return readSync(1).buffer.asByteData().getUint8(0);
  }

  double get readFloat32 {
    return readSync(4).buffer.asByteData().getFloat32(0, getEndian);
  }

  double get readFloat64 {
    return readSync(8).buffer.asByteData().getFloat64(0, getEndian);
  }
}
