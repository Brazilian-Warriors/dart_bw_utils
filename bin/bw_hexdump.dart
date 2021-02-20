import 'dart:io';
import 'package:bw_utils/hex_dump.dart';

main(List<String> args) {
  final data = File(args[0]).readAsBytesSync();
  hexDump(data);
}