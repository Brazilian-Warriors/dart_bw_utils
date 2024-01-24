import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

interface class RamdomAccessStream extends _RamdomAccessStream {
  RamdomAccessStream({required super.bytes});
}

abstract interface class _RamdomAccessStreamInterface {
  int getPositionSync();
  void setPositionSync([int position = 0]);
  bool contains(Uint8List value);
  Uint8List readSync(int lentgth);
  void writeSync(Uint8List value);
  void writeByteSync(int value);
  void flushSync();
  List<int> findAllSublistInitialPosition(Uint8List subListToFind,
      {bool findOnyFirst = false, int start = 0, int end = 0});
  int findFirstSublistInitialPosition(Uint8List subListToFind,
      {int start = 0, int end = 0});
}

interface class _RamdomAccessStream implements _RamdomAccessStreamInterface {
  int _offset = 0;
  // ignore: prefer_final_fields
  Uint8List _listOfBytes;

  _RamdomAccessStream({required Uint8List bytes})
      : _listOfBytes = bytes;

  @override
  int getPositionSync() => _offset;

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
  Uint8List readSync([int lentgth = 0]) {
    if (lentgth == 0) lentgth = _listOfBytes.length;

    if (lentgth + _offset > _listOfBytes.length) {
      lentgth = _listOfBytes.length - _offset;
    }

    final Uint8List value = _listOfBytes.sublist(_offset, _offset + lentgth);
    _offset += lentgth;
    return value;
  }

  @override
  void writeSync(Uint8List value) {
    _listOfBytes.addAll(value);
  }

  @override
  void flushSync() {
    _listOfBytes.clear();
  }

  @override
  void writeByteSync(int value) {
    _listOfBytes.add(value);
  }

  @override
  bool contains(List<int> value) {
    return _listOfBytes.findFirstPositionWhere(value) != -1;
  }

  @override
  List<int> findAllSublistInitialPosition(Uint8List subListToFind,
      {bool findOnyFirst = false, int start = 0, int end = 0}) {
    return _listOfBytes.findAllPositionWhere(subListToFind,
        findOnlyFirst: findOnyFirst, start: start, end: end);
  }

  @override
  int findFirstSublistInitialPosition(Uint8List subListToFind,
      {int start = 0, int end = 0}) {
    return _listOfBytes.findFirstPositionWhere(subListToFind,
        start: start, end: end);
  }
}
