import 'dart:convert';

extension BWExListInt on List<int> {
  String toStringUTF8() {
    return Utf8Decoder().convert(this);
  }
}
