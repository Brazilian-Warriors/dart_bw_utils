import 'dart:typed_data';
import 'package:bw_utils/bw_utils.dart';
part 'access_stream_file_impl.dart';

abstract interface class RandomAccessStreamFile {
  factory RandomAccessStreamFile() =>
      _RandomAccessStreamFile(bytes: Uint8List(0));
  factory RandomAccessStreamFile.from({required Uint8List bytes}) =>
      _RandomAccessStreamFile(bytes: bytes);

  int get length;
  bool get isEmpty;
  bool get isNotEmpty;
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
  int findFirstPos(Uint8List subListToFind, {int start = 0, int end = 0});

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
