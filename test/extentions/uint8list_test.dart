import 'dart:io';
import 'dart:typed_data';
import 'package:bw_utils/bw_utils.dart';
import 'package:bw_utils/shared/settings.dart';
import 'package:test/test.dart';

main() {
  test('test1', () {
    var list = Uint8List.fromList([127, 9, 0, 0]);
    expect(list.toInt32LE(), 2431);

    var listBe = Uint8List.fromList([127, 9, 0, 0].reversed.toList());
    expect(listBe.toInt32BE(), 2431);

    ByteData leonam = ByteData(4);
    leonam.setUint32(0, 10, Endian.big);
    print(leonam.buffer.asInt8List());

    ByteData value = ByteData.view(list.buffer);
    expect(value.getInt32(0, Endian.little), 2431);

    ByteData nval = ByteData(4);

    for (var i = 0; i < 256; i++) {
      nval.setInt32(0, i, Endian.big);
      final hex = nval.buffer.asUint16List().asHex();
      print(hex);
    }
  });

  test('description', () {
    ByteData nval = ByteData(4);

    nval.setUint32(0, 10, Endian.big);

    final File afile = File('${Directory.current.path}/temp.dat');
    afile.createSync();
    RandomAccessFile file = afile.openSync(mode: FileMode.write);

    file.writeFromSync([127, 9, 0, 0]);
    file.writeStringSync('shit!');
    //file.setPositionSync(3);
    // file.writeByteSync(0Xff);

    //   file.writeFromSync([0xff, 0xfe, 0xfd, 0xfc]);

    print(file.readSync(file.lengthSync()));
  });

  test('conversion List<int> to int', () {
    setEndian(Endian.big);

    String path = '${Directory.current.path}/temp.dat';
    // File(path).writeAsBytesSync([127, 9, 0, 0]);
    RandomAccessFile file = File(path).openSync();

    print(file.readUint32.toUint32List());

    //final int a = (file.readSync(4).buffer.asByteData()).getUint32(0, getEndian);

    //final b = (ByteData(4)..setInt32(0, a, getEndian)).buffer.asUint8List();

    //print(a);
    //print(b);
  });

  test('int ing Big And Litte Endian', () {
    setEndian(Endian.big);
    final value = ByteData(4);

    Endian end = getEndian;

    final a = (value..setUint32(0, 2431, end)).buffer.asUint8List();

    print(a);
  });

  test('int', () {
    int a = 2431;

    print(a);
  });
}
