import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';

class PigeonBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // final pubspecAsset = await buildStep.findAssets(Glob('pubspec.yaml')).first;

    await buildStep.digest(buildStep.inputId);

    final config =
        await PigeonBuildPubspecParser.parsePubspecFile(File('pubspec.yaml'));

    if (config != null && buildStep.inputId.extension == '.dart') {
      final generator = PigeonBuildGenerator.fromConfig(config);
      await generator.generate(buildStep.inputId.path);
    }

    var pes = "";
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        'pubspec.yaml': ['.\$pigeonyaml'],
        '.dart': [".\$pigeon"]
      };
}
