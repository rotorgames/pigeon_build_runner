import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:test/test.dart';
import 'dart:io';

const pubspecPath = "example/pubspec.yaml";
const emptyPubspecPath = "example/empty_pubspec.yaml";
const nullablePubspecPath = "example/nullable_pubspec.yaml";

void main() {
  test(
      'pubspec file with no pigeon_build config should generate valid pigion build config',
      () async {
    final config =
        await PigeonBuildPubspecParser.parsePubspecFile(File(emptyPubspecPath));

    expect(config, isNull);
  });

  test('config with nullable fields should be parsed fine with nullable values',
      () async {
    await PigeonBuildPubspecParser.parsePubspecFile(File(nullablePubspecPath));
  });

  test('all fields should be filled in config', () async {
    final config =
        await PigeonBuildPubspecParser.parsePubspecFile(File(pubspecPath));

    expect(config, isNotNull);
    expect(config!.mainInput, isNotNull);

    final inputs = <PigeonBuildInputConfig>[
      config.mainInput!,
      ...config.inputs,
    ];

    for (var input in inputs) {
      expect(input.oneLanguage, isTrue);
      expect(input.debugGenerators, isTrue);
      expect(input.copyrightHeader, isNotNull);
      expect(input.ast?.out, isNotNull);

      expect(input.input, isNotNull);
      expect(input.dart?.out, isNotNull);
      expect(input.dart?.testOut, isNotNull);
      expect(input.objc?.headerOut, isNotNull);
      expect(input.objc?.sourceOut, isNotNull);
      expect(input.objc?.prefix, isNotNull);
      expect(input.java?.out, isNotNull);
      expect(input.java?.package, isNotNull);
      expect(input.java?.useGeneratedAnnotation, isTrue);
      expect(input.swift?.out, isNotNull);
      expect(input.kotlin?.out, isNotNull);
      expect(input.kotlin?.package, isNotNull);
      expect(input.cpp?.headerOut, isNotNull);
      expect(input.cpp?.sourceOut, isNotNull);
      expect(input.cpp?.namespace, isNotNull);
    }
  });
}
