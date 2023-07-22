import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';
import 'package:pigeon_build_core/src/abstractions/asset_cache.dart';
import 'package:pigeon_build_core/src/implementations/default_generator.dart';

PigeonBuildGenerator mainInputGenerator(
    PigeonBuildInputConfig defaultInputConfig) {
  final buildConfig = PigeonBuildConfig(
    mainInput: defaultInputConfig,
  );
  return defaultGenerator(buildConfig);
}

PigeonBuildGenerator defaultGenerator(PigeonBuildConfig config) {
  return PigeonBuildGenerator(
    config,
    PigeonAssetCache(),
    DefaultPigeonGenerator(config),
  );
}
