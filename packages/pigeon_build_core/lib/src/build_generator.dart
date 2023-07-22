import 'dart:io';

import 'package:pigeon/pigeon_lib.dart';
import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/src/abstractions/asset_cache.dart';
import 'package:pigeon_build_core/src/abstractions/generator.dart';
import 'package:pigeon_build_core/src/implementations/default_generator.dart';
import 'package:path/path.dart' as p;

import 'validation/config_validator.dart';

//TODO implement working with cache
class PigeonBuildGenerator {
  final PigeonBuildConfig config;
  final PigeonAssetCache assetCache;
  final PigeonGenerator generator;

  PigeonBuildGenerator(
    this.config,
    this.assetCache,
    this.generator,
  ) {
    ConfigValidator.validateConfig(config);
  }

  factory PigeonBuildGenerator.fromConfig(PigeonBuildConfig config) =>
      PigeonBuildGenerator(
        config,
        PigeonAssetCache(),
        DefaultPigeonGenerator(config),
      );

  Future<bool> generate(String inputPath) async {
    final options = generator.getPigeonOptions(inputPath);

    if (options == null) {
      return false;
    }

    //TODO to extension
    final outputs = [
      options.dartOut,
      options.dartTestOut,
      options.astOut,
      options.javaOut,
      options.kotlinOut,
      options.objcHeaderOut,
      options.objcSourceOut,
      options.swiftOut,
      options.cppHeaderOut,
      options.cppSourceOut,
    ];

    for (var output in outputs) {
      if (output == null) continue;

      final path = p.dirname(output);
      final directory = Directory(path);

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }

    //TODO add exceptions
    final result = await Pigeon.runWithOptions(options);

    return result == 0;
  }
}
