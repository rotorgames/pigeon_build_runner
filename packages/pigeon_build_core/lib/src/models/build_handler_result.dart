import 'package:pigeon/pigeon_lib.dart';
import 'package:pigeon_build_config/pigeon_build_config.dart';

class BuildHandlerResult {
  final PigeonBuildConfig config;
  final PigeonBuildInputConfig? input;
  final PigeonOptions? options;

  BuildHandlerResult({
    required this.config,
    this.input,
    this.options,
  });
}
