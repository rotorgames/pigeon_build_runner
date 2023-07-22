//test22222

import 'package:pigeon/pigeon.dart';

class Value {
  late int number;
  late int test;
}

@HostApi()
abstract class Api2Host {
  @async
  Value calculate(Value value);
}

@HostApi()
abstract class TestHost {
  void test();
  void megatest(double p, int see);
}
