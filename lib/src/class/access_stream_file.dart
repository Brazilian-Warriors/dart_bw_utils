import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

class RamdomAccessStreamFile extends _RamdomAccessStream {
  RamdomAccessStreamFile({required super.bytes});
}

abstract interface class _RamdomAccessStreamInterface {
  int getPositionSync();
  void setPositionSync([int position = 0]);
  bool contains(Uint8List value);
  Uint8List readSync(int lentgth);
  void writeSync(Uint8List value);
  void replace(int start, Uint8List value);
  void flushSync();
  List<int> findAllSublistInitialPosition(Uint8List subListToFind,
      {bool findOnyFirst = false, int start = 0, int end = 0});
  int findFirstSublistInitialPosition(Uint8List subListToFind,
      {int start = 0, int end = 0});
}

class _RamdomAccessStream implements _RamdomAccessStreamInterface {
  int _offset = 0;
  List<int> _tempList = [];
  Uint8List _listOfBytes;

  _RamdomAccessStream({required Uint8List bytes}) : _listOfBytes = bytes;

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
    _tempList = _listOfBytes;
    _tempList.addAll(value);

    _listOfBytes = _toUint8List(_tempList);

    _tempList.clear();
  }

  @override
  void flushSync() {
    _listOfBytes = Uint8List(0);
    _offset = 0;
  }

  @override
  bool contains(List<int> value) {
    return _listOfBytes.findFirstSublistPositionWhere(value) != -1;
  }

  @override
  List<int> findAllSublistInitialPosition(Uint8List subListToFind,
      {bool findOnyFirst = false, int start = 0, int end = 0}) {
    return _listOfBytes.findAllSublistPositionWhere(subListToFind,
        findOnlyFirst: findOnyFirst, start: start, end: end);
  }

  @override
  int findFirstSublistInitialPosition(Uint8List subListToFind,
      {int start = 0, int end = 0}) {
    return _listOfBytes.findFirstSublistPositionWhere(subListToFind,
        start: start, end: end);
  }

  Uint8List _toUint8List(List<int> list) {
    return Uint8List.fromList(list);
  }

  @override
  void replace(int start, Uint8List value) {
    _tempList = _listOfBytes;
    _tempList.replaceRange(start, start + value.length, value);
    _listOfBytes = _toUint8List(_tempList);
    _tempList.clear();
  }
}
