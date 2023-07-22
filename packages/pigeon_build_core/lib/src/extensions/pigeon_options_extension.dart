import 'package:pigeon/pigeon_lib.dart';

extension PigeonOptionsExtension on PigeonOptions {
  List<String> getAllOutputs() {
    final outputs = [
      dartOut,
      dartTestOut,
      astOut,
      javaOut,
      kotlinOut,
      objcHeaderOut,
      objcSourceOut,
      swiftOut,
      cppHeaderOut,
      cppSourceOut,
    ];

    return outputs.where((o) => o != null).cast<String>().toList();
  }
}
