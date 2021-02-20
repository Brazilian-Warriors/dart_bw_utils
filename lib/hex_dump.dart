import 'dart:typed_data';

extension on int {
  String toHex([padLength = 2]) {
    return toRadixString(16).padLeft(padLength, '0').toUpperCase();
  }
}

hexDump(Uint8List data) {
  final width = 16;

  var header = '          ';
  for (var row = 0; row < width; row++) {
    header += row.toHex() + ' ';
  }
  print(header);

  for (var col = 0; col * width < data.length; col++) {
    //header
    var line = '';
    line += (col.toHex(8));
    line += '  ';

    //data
    for (var row = 0; row < width; row++) {
      var index = (col * width) + row;
      if (index < data.length) {
        line += (data[index].toHex() + ' ');
      } else {
        line += ('   ');
      }
    }

    line += '|';
    for (var row = 0; row < width; row++) {
      var index = (col * width) + row;
      if (index < data.length) {
        var charCode = data[index];
        if (charCode >= 0x20) {
          line += String.fromCharCode(charCode);
        } else {
          line += '.';
        }
      } else {
        line += (' ');
      }
    }
    line += '|';

    print(line);
  }
}
