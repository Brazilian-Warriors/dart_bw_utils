import 'dart:typed_data';

extension BWExInt on int {

  List<int> toInt32LE() {
    final num = this;
    final p1 = num & 0xFF;
    final p2 = num >> 8 & 0xFF;
    final p3 = num >> 16 & 0xFF;
    final p4 = num >> 24 & 0xFF;
    return [p1, p2, p3, p4];
  }

  Uint8List toUint8ListLE() {
    return Uint8List.fromList(toInt32LE());
  }

  Uint8List toUint8ListBE() {
    final num = this;
    final p1 = num & 0xFF;
    final p2 = num >> 8 & 0xFF;
    final p3 = num >> 16 & 0xFF;
    final p4 = num >> 24 & 0xFF;
    return Uint8List.fromList([p4, p3, p2, p1]);
  }
}
