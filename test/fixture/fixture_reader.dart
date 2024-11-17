import 'dart:io';

String fixture(String fileName){
  return File('test/fixture/user.json').readAsStringSync();
}