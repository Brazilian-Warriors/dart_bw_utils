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
    return _readByteData(4).getInt32(0, endian ?? _endian);
  }

  int readUint32([Endian? endian]) {
    return _readByteData(4).getUint32(0, endian ?? _endian);
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
    return _readByteData(8).getFloat64(0, endian ?? _endian);
  }

  ByteData _readByteData(int lengthOfBytes) {
    return readSync(lengthOfBytes).buffer.asByteData();
  }

  List<int> indexOf(Uint8List subList,
      {int? start = 0, int? end, bool findOnlyFirst = false}) {
    final int actualPost = positionSync();

    List<int> result = _getPos(
        subList, start ?? positionSync(), end ?? lengthSync(),
        findOnlyFirst: findOnlyFirst);
    setPositionSync(actualPost);

    return result;
  }

// WIP
  List<int> _getPos(Uint8List valueToFind, int start, int end,
      {bool findOnlyFirst = false}) {
    Uint8List subList = Uint8List(valueToFind.length);
    List<int> position = [];
    bool equalValue = false;
    int subListEnd = valueToFind.length;
    int startPos = 0;

    if (start < 0) {
      start = 0;
    }

    if ((start >= lengthSync()) ||
        ((start + valueToFind.length) > lengthSync())) {
      start = lengthSync() - valueToFind.length;
    }

    setPositionSync(start);
    do {
      startPos = start;
      readIntoSync(subList, start, subListEnd);

      for (var i = 0; i < subList.length; i++) {
        equalValue = subList[i] == valueToFind[i];

        start++;
        subListEnd++;

        if (equalValue == false) {
          break;
        }
      }

      if (equalValue) {
        position.add(startPos);

        if (findOnlyFirst) {
          break;
        }
      }
    } while (subListEnd <= end);
    return position;
  }
}
