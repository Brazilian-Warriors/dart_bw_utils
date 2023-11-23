import 'dart:typed_data';
import 'package:bw_utils/extensions/uint8list.dart';
import 'package:test/test.dart';

main() {
  test('test1', () {
    var list = Uint8List.fromList([127, 9, 0, 0]);
    expect(list.toInt32LE(), 2431);

    var listBe = Uint8List.fromList([127, 9, 0, 0].reversed.toList());
    expect(listBe.toInt32BE(), 2431);

    ByteData value = ByteData.view(list.buffer);
    expect(value.getInt32(0, Endian.little), 2431);
  });
}
