import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';

// PigeonBuildGenerator mainInputGenerator(
//   PigeonBuildInputConfig defaultInputConfig,
// ) {
//   final buildConfig = PigeonBuildConfig(
//     mainInput: defaultInputConfig,
//   );
//   return defaultGenerator(buildConfig);
// }

// PigeonBuildGenerator mainWithOneInputGenerator(
//   PigeonBuildInputConfig mainInputConfig,
//   PigeonBuildInputConfig input,
// ) {
//   final buildConfig = PigeonBuildConfig(
//     mainInput: mainInputConfig,
//     inputs: [
//       input,
//     ],
//   );
//   return defaultGenerator(buildConfig);
// }

// PigeonBuildGenerator singleInputGenerator(
//   PigeonBuildInputConfig input,
// ) {
//   final buildConfig = PigeonBuildConfig(
//     inputs: [
//       input,
//     ],
//   );
//   return defaultGenerator(buildConfig);
// }

// PigeonBuildGenerator defaultGenerator(PigeonBuildConfig config) {
//   return PigeonBuildGenerator(config);
// }

PigeonBuildConfig singleInputConfig(PigeonBuildInputConfig input) {
  final buildConfig = PigeonBuildConfig(
    inputs: [
      input,
    ],
  );
  return buildConfig;
}

PigeonBuildConfig mainInputConfig(PigeonBuildInputConfig input) {
  final buildConfig = PigeonBuildConfig(
    mainInput: input,
  );
  return buildConfig;
}

validateSingleInputConfig(PigeonBuildInputConfig input) {
  PigeonBuildConfigValidator.validateConfig(singleInputConfig(input));
}

validateMainInputConfig(PigeonBuildInputConfig input) {
  PigeonBuildConfigValidator.validateConfig(mainInputConfig(input));
}
