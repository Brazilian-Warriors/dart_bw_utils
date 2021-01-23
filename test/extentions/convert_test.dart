import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';
import 'package:test/test.dart';

main() {
  test('convert', () {
    // final num = 2431;
    final num = 16909060;
    expect(num.toUint8ListBE(), Uint32List.fromList([1, 2, 3, 4]));
    print(num.toUint8ListBE().toHex());
  });
}
