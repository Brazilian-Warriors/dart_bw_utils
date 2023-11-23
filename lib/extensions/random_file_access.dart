import 'dart:io';
import 'dart:typed_data';

extension BWReadToNumber on RandomAccessFile {
  static Endian endian = Endian.big;
  void setEndian(Endian value) => endian = value;

  int get readInt64 {
    return readSync(8).buffer.asByteData().getInt64(0, endian);
  }

  int get readInt32 {
    return readSync(4).buffer.asByteData().getInt32(0, endian);
  }

  int get readInt16 {
    return readSync(2).buffer.asByteData().getInt16(0, endian);
  }

  int get readInt8 {
    return readSync(1).buffer.asByteData().getInt8(0);
  }

  int get readUint64 {
    return readSync(8).buffer.asByteData().getUint64(0, endian);
  }

  int get readUInt32 {
    return readSync(4).buffer.asByteData().getUint32(0, endian);
  }

  int get readUInt16 {
    return readSync(2).buffer.asByteData().getUint16(0, endian);
  }

  int get readUInt8 {
    return readSync(1).buffer.asByteData().getUint8(0);
  }

  double get readFloat32 {
    return readSync(4).buffer.asByteData().getFloat32(0, endian);
  }

  double get readFloat64 {
    return readSync(8).buffer.asByteData().getFloat64(0, endian);
  }
}
