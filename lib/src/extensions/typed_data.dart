import 'dart:typed_data';

import 'package:bw_utils/bw_utils.dart';

extension BWxTypedDataUtils on TypedData {
  List<String> toHex() {
    return buffer.asUint8List(0, buffer.lengthInBytes).asHex();
  }
}
