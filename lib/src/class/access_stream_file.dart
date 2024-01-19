import 'package:bw_utils/bw_utils.dart';

interface class RamdomAccessStream extends _RamdomAccessStream {
  RamdomAccessStream({required super.bytes});
}

abstract interface class _RamdomAccessStreamInterface {
  int getPositionSync();
  void setPositionSync([int position = 0]);
  bool contains(List<int> value);
  List<int> readSync(int lentgth);
  void writeSync(List<int> value);
  void writeByteSync(int value);
  void flushSync();
}

interface class _RamdomAccessStream implements _RamdomAccessStreamInterface {
  int _offset = 0;
  // ignore: prefer_final_fields
  List<int> _listOfBytes = [];

  _RamdomAccessStream({required List<int> bytes}) : _listOfBytes = bytes;

  @override
  int getPositionSync() => _offset;

  @override
  void setPositionSync([int position = 0]) =>
      position < 0 ? _offset = 0 : _offset = position;

  @override
  List<int> readSync([int lentgth = 0]) {
    if (lentgth == 0) lentgth = _listOfBytes.length;

    if (lentgth + _offset > _listOfBytes.length) {
      lentgth = _listOfBytes.length;
    }

    final value = _listOfBytes.skip(_offset).take(lentgth).toList();
    _offset += lentgth;
    return value;
  }

  @override
  void writeSync(List<int> value) {
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
}
