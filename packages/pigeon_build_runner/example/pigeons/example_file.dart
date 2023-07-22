import 'package:pigeon/pigeon.dart';

class TestModel {
  late int test;
}

@HostApi()
abstract class Api2Host {
  @async
  TestModel test(TestModel value);
}
