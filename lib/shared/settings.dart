import 'dart:typed_data';
Endian _endian = Endian.big;
void setEndian(Endian endian) => _endian = endian;
Endian get getEndian => _endian;