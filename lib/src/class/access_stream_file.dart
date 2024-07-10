import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

abstract interface class RandomAccessStreamFile {
  factory RandomAccessStreamFile() => _RandomAccessStreamFile(bytes: Uint8List(0));
  factory RandomAccessStreamFile.from({required Uint8List bytes}) => _RandomAccessStreamFile(bytes: bytes);

  int get length;
  int getPositionSync();
  void setPositionSync([int position = 0]);
  Uint8List readSync([int length = 0]);
  bool contains(Uint8List value);
  void writeSync(Uint8List value);
  void replace(int start, Uint8List value);
  void insert(int start, Uint8List value);
  void flushSync();
  List<int> findAllPos(Uint8List subListToFind,
      {bool findOnlyFirst = false, int start = 0, int end = 0});
  int findFirstPos(Uint8List subListToFind,
      {int start = 0, int end = 0});

  int get readInt8;

  int get readUint8;

  int readInt16([Endian? endian]);

  int readUint16([Endian? endian]);

  int readInt32([Endian? endian]);

  int readUint32([Endian? endian]);

  int readInt64([Endian? endian]);

  int readUint64([Endian? endian]);

  double readFloat32([Endian? endian]);

  double readFloat64([Endian? endian]);
}

class _RandomAccessStreamFile implements RandomAccessStreamFile {
  int _offset = 0;
  Uint8List _listOfBytes;
  static final Endian _endian = getEndian;

  _RandomAccessStreamFile({required Uint8List bytes}) : _listOfBytes = bytes;

  @override
  int getPositionSync() => _offset;

  @override
  int get length => _listOfBytes.length;

  @override
  void setPositionSync([int position = 0]) {
    if (position < 0) {
      position = 0;
    }

    if (position > _listOfBytes.length) {
      position = _listOfBytes.length;
    }

    _offset = position;
  }

  @override
  Uint8List readSync([int length = 0]) {
    if (length == 0) length = _listOfBytes.length;

    if (length + _offset > _listOfBytes.length) {
      length = _listOfBytes.length - _offset;
    }

    final Uint8List value = _listOfBytes.sublist(_offset, _offset + length);
    _offset += length;
    return value;
  }

  @override
  void flushSync() {
    _listOfBytes = Uint8List(0);
    _offset = 0;
  }

  @override
  bool contains(List<int> value) {
    return _listOfBytes.findFirstPos(value) != -1;
  }

  @override
  List<int> findAllPos(Uint8List subListToFind,
      {bool findOnlyFirst = false, int start = 0, int end = 0}) {
    return _listOfBytes.findAllPos(subListToFind,
        findOnlyFirst: findOnlyFirst, start: start, end: end);
  }

  @override
  int findFirstPos(Uint8List subListToFind,
      {int start = 0, int end = 0}) {
    return _listOfBytes.findFirstPos(subListToFind,
        start: start, end: end);
  }

  @override
  void replace(int start, Uint8List value) =>
      _changeListOfBytes(value, start, ChangeList.replace);

  @override
  void insert(int start, Uint8List value) =>
      _changeListOfBytes(value, start, ChangeList.insert);

  @override
  void writeSync(Uint8List value) =>
      _changeListOfBytes(value, 0, ChangeList.add);

  void _changeListOfBytes(Uint8List value, int start, ChangeList type) {
    switch (type) {
      case ChangeList.insert:
        var byteData = BytesBuilder();
        byteData.add(_listOfBytes.sublist(0, start));
        byteData.add(value);
        byteData.add(_listOfBytes.sublist(start));

        _listOfBytes = byteData.takeBytes();

        break;
      case ChangeList.replace:
        _listOfBytes.setRange(start, start + value.length, value);
        break;
      case ChangeList.add:
        _listOfBytes = (BytesBuilder()
              ..add(_listOfBytes)
              ..add(value))
            .takeBytes();
        break;
    }
  }

  @override
  int readInt64([Endian? endian]) {
    return _readByteData(8).getInt64(0, endian ?? _endian);
  }

  @override
  int readUint64([Endian? endian]) {
    return _readByteData(8).getUint64(0, endian ?? _endian);
  }

  @override
  int readInt32([Endian? endian]) {
    return _readByteData(4).getInt32(0, endian ?? _endian);
  }

  @override
  int readUint32([Endian? endian]) {
    return _readByteData(4).getUint32(0, endian ?? _endian);
  }

  @override
  int readInt16([Endian? endian]) {
    return _readByteData(2).getInt16(0, endian ?? _endian);
  }

  @override
  int readUint16([Endian? endian]) {
    return _readByteData(2).getUint16(0, endian ?? _endian);
  }

  @override
  int get readInt8 {
    return _readByteData(1).getInt8(0);
  }

  @override
  int get readUint8 {
    return _readByteData(1).getUint8(0);
  }

  @override
  double readFloat32([Endian? endian]) {
    return _readByteData(4).getFloat32(0, endian ?? _endian);
  }

  @override
  double readFloat64([Endian? endian]) {
    return _readByteData(4).getFloat64(0, endian ?? _endian);
  }

  ByteData _readByteData(int lengthOfBytes) {
    return readSync(lengthOfBytes).buffer.asByteData();
  }
}

enum ChangeList {
  insert,
  replace,
  add,
}
