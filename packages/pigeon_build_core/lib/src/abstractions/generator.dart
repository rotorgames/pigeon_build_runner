import 'package:pigeon/pigeon_lib.dart';

abstract class PigeonGenerator {
  PigeonOptions? getPigeonOptions(String inputPath);
}
