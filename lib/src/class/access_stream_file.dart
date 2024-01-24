import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

class RamdomAccessStreamFile extends _RamdomAccessStream {
  RamdomAccessStreamFile({required super.bytes});
}

abstract interface class _RamdomAccessStreamInterface {
  int get length;
  int getPositionSync();
  void setPositionSync([int position = 0]);
  bool contains(Uint8List value);
  Uint8List readSync(int lentgth);
  void writeSync(Uint8List value);
  void replace(int start, Uint8List value);
  void insert(int start, Uint8List value);
  void flushSync();
  List<int> findAllSublistInitialPosition(Uint8List subListToFind,
      {bool findOnyFirst = false, int start = 0, int end = 0});
  int findFirstSublistInitialPosition(Uint8List subListToFind,
      {int start = 0, int end = 0});
}

class _RamdomAccessStream implements _RamdomAccessStreamInterface {
  int _offset = 0;
  Uint8List _listOfBytes;

  _RamdomAccessStream({required Uint8List bytes}) : _listOfBytes = bytes;

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
    List<int> tempList = [];
    tempList.addAll(_listOfBytes);

    switch (type) {
      case ChangeList.insert:
        tempList.insertAll(start, value);
        break;
      case ChangeList.replace:
        tempList.replaceRange(start, start + value.length, value);
        break;
      case ChangeList.add:
        tempList.addAll(value);
        break;
    }

    _listOfBytes = Uint8List.fromList(tempList);
    tempList.clear();
  }
}

enum ChangeList {
  insert,
  replace,
  add,
}
