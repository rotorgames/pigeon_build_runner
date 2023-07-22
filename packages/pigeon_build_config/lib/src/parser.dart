import 'dart:io';

import 'package:checked_yaml/checked_yaml.dart';
import 'package:pigeon_build_config/src/config.dart';

class PigeonBuildPubspecParser {
  PigeonBuildPubspecParser._();

  static Future<PigeonBuildConfig?> parsePubspecFile(File file) async {
    final fileContent = await file.readAsString();

    return parsePubspec(fileContent, file.uri);
  }

  static PigeonBuildConfig? parsePubspecFileSync(File file) {
    final fileContent = file.readAsStringSync();

    return parsePubspec(fileContent, file.uri);
  }

  static PigeonBuildConfig? parsePubspec(String content, Uri path) {
    final config = checkedYamlDecode(
      content,
      (m) => PigeonBuildPubspecConfig.fromJson(m!),
      sourceUrl: path,
    );

    return config.pigeon;
  }
}
