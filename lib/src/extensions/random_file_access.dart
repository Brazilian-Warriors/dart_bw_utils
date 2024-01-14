import 'dart:io';
import 'dart:typed_data';
import 'package:bw_utils/bw_utils.dart';

extension BWReadToNumber on RandomAccessFile {
  static final Endian _endian = getEndian;

  int readInt64([Endian? endian]) {
    return _readByteData(8).getInt64(0, endian ?? _endian);
  }
  int readUint64([Endian? endian]) {
    return _readByteData(8).getUint64(0, endian ?? _endian);
  }


  int readInt32([Endian? endian]) {
    return _readByteData(4).getInt32(0, endian ??_endian);
  }
  int readUint32([Endian? endian]) {
    return _readByteData(4).getUint32(0, endian ??_endian);
  }


  int readInt16([Endian? endian]) {
    return _readByteData(2).getInt16(0, endian ?? _endian);
  }
  int readUint16([Endian? endian]) {
    return _readByteData(2).getUint16(0, endian ?? _endian);
  }



  int get readInt8 {
    return _readByteData(1).getInt8(0);
  }

  int get readUint8 {
    return _readByteData(1).getUint8(0);
  }




  double readFloat32([Endian? endian]) {
    return _readByteData(4).getFloat32(0, endian ?? _endian);
  }

  double readFloat64([Endian? endian]) {
    return _readByteData(4).getFloat64(0, endian ?? _endian);
  }



  ByteData _readByteData(int lengthOfBytes) {
    return readSync(lengthOfBytes).buffer.asByteData();
  }
}
