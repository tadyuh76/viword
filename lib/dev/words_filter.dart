import 'dart:convert';
import 'dart:io';

import 'package:viword/resources/words.dart';

List<String> filter() {
  return words.sublist(1900, 2000).where((w) {
    print('$w - remove it ? (y)');
    bool? remove = stdin.readLineSync() == 'y';
    return !remove;
  }).toList();
}

void main(List<String> args) {
  final newList = filter();
  print(jsonEncode(newList));
}
