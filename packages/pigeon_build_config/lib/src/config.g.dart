// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PigeonBuildOutputConfig _$PigeonBuildOutputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildOutputConfig',
      json,
      ($checkedConvert) {
        final val = PigeonBuildOutputConfig(
          path: $checkedConvert('path', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$PigeonBuildOutputConfigToJson(
        PigeonBuildOutputConfig instance) =>
    <String, dynamic>{
      'path': instance.path,
    };

PigeonBuildPubspecConfig _$PigeonBuildPubspecConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildPubspecConfig',
      json,
      ($checkedConvert) {
        final val = PigeonBuildPubspecConfig(
          pigeon: $checkedConvert('pigeon',
              (v) => v == null ? null : PigeonBuildConfig.fromJson(v as Map)),
        );
        return val;
      },
    );

Map<String, dynamic> _$PigeonBuildPubspecConfigToJson(
        PigeonBuildPubspecConfig instance) =>
    <String, dynamic>{
      'pigeon': instance.pigeon,
    };

PigeonBuildConfig _$PigeonBuildConfigFromJson(Map json) => $checkedCreate(
      'PigeonBuildConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['main-input', 'inputs'],
        );
        final val = PigeonBuildConfig(
          mainInput: $checkedConvert(
              'main-input',
              (v) =>
                  v == null ? null : PigeonBuildInputConfig.fromJson(v as Map)),
          inputs: $checkedConvert(
              'inputs',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => PigeonBuildInputConfig.fromJson(e as Map))
                      .toList() ??
                  const <PigeonBuildInputConfig>[]),
        );
        return val;
      },
      fieldKeyMap: const {'mainInput': 'main-input'},
    );

Map<String, dynamic> _$PigeonBuildConfigToJson(PigeonBuildConfig instance) =>
    <String, dynamic>{
      'main-input': instance.mainInput,
      'inputs': instance.inputs,
    };

PigeonBuildInputConfig _$PigeonBuildInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'copyright-header',
            'one-language',
            'debug-generators',
            'input',
            'dart',
            'ast',
            'objc',
            'java',
            'kotlin',
            'swift',
            'cpp'
          ],
          requiredKeys: const ['input'],
        );
        final val = PigeonBuildInputConfig(
          copyrightHeader:
              $checkedConvert('copyright-header', (v) => v as String?),
          oneLanguage: $checkedConvert('one-language', (v) => v as bool?),
          ast: $checkedConvert(
              'ast',
              (v) => v == null
                  ? null
                  : PigeonBuildAstInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          debugGenerators:
              $checkedConvert('debug-generators', (v) => v as bool?),
          input: $checkedConvert('input', (v) => v as String?),
          dart: $checkedConvert(
              'dart',
              (v) => v == null
                  ? null
                  : PigeonBuildDartInputConfig.fromJson(v as Map)),
          objc: $checkedConvert(
              'objc',
              (v) => v == null
                  ? null
                  : PigeonBuildObjcInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          java: $checkedConvert(
              'java',
              (v) => v == null
                  ? null
                  : PigeonBuildJavaInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          kotlin: $checkedConvert(
              'kotlin',
              (v) => v == null
                  ? null
                  : PigeonBuildKotlinInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          swift: $checkedConvert(
              'swift',
              (v) => v == null
                  ? null
                  : PigeonBuildSwiftInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
          cpp: $checkedConvert(
              'cpp',
              (v) => v == null
                  ? null
                  : PigeonBuildCppInputConfig.fromJson(
                      Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
      fieldKeyMap: const {
        'copyrightHeader': 'copyright-header',
        'oneLanguage': 'one-language',
        'debugGenerators': 'debug-generators'
      },
    );

Map<String, dynamic> _$PigeonBuildInputConfigToJson(
        PigeonBuildInputConfig instance) =>
    <String, dynamic>{
      'copyright-header': instance.copyrightHeader,
      'one-language': instance.oneLanguage,
      'debug-generators': instance.debugGenerators,
      'input': instance.input,
      'dart': instance.dart,
      'ast': instance.ast,
      'objc': instance.objc,
      'java': instance.java,
      'kotlin': instance.kotlin,
      'swift': instance.swift,
      'cpp': instance.cpp,
    };

PigeonBuildDartInputConfig _$PigeonBuildDartInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildDartInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['out', 'test-out'],
        );
        final val = PigeonBuildDartInputConfig(
          out: $checkedConvert(
              'out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          testOut: $checkedConvert('test-out',
              (v) => v == null ? null : PigeonBuildOutputConfig.fromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {'testOut': 'test-out'},
    );

Map<String, dynamic> _$PigeonBuildDartInputConfigToJson(
        PigeonBuildDartInputConfig instance) =>
    <String, dynamic>{
      'out': instance.out,
      'test-out': instance.testOut,
    };

PigeonBuildAstInputConfig _$PigeonBuildAstInputConfigFromJson(
        Map<String, dynamic> json) =>
    PigeonBuildAstInputConfig(
      out: PigeonBuildOutputConfig.fromJson(json['out']),
    );

Map<String, dynamic> _$PigeonBuildAstInputConfigToJson(
        PigeonBuildAstInputConfig instance) =>
    <String, dynamic>{
      'out': instance.out,
    };

PigeonBuildObjcInputConfig _$PigeonBuildObjcInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildObjcInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['header-out', 'source-out', 'prefix'],
        );
        final val = PigeonBuildObjcInputConfig(
          headerOut: $checkedConvert(
              'header-out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          sourceOut: $checkedConvert(
              'source-out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          prefix: $checkedConvert('prefix', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'headerOut': 'header-out', 'sourceOut': 'source-out'},
    );

Map<String, dynamic> _$PigeonBuildObjcInputConfigToJson(
        PigeonBuildObjcInputConfig instance) =>
    <String, dynamic>{
      'header-out': instance.headerOut,
      'source-out': instance.sourceOut,
      'prefix': instance.prefix,
    };

PigeonBuildJavaInputConfig _$PigeonBuildJavaInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildJavaInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['out', 'package', 'use-generated-annotation'],
        );
        final val = PigeonBuildJavaInputConfig(
          out: $checkedConvert(
              'out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          package: $checkedConvert('package', (v) => v as String?),
          useGeneratedAnnotation:
              $checkedConvert('use-generated-annotation', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {'useGeneratedAnnotation': 'use-generated-annotation'},
    );

Map<String, dynamic> _$PigeonBuildJavaInputConfigToJson(
        PigeonBuildJavaInputConfig instance) =>
    <String, dynamic>{
      'out': instance.out,
      'package': instance.package,
      'use-generated-annotation': instance.useGeneratedAnnotation,
    };

PigeonBuildSwiftInputConfig _$PigeonBuildSwiftInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildSwiftInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['out'],
        );
        final val = PigeonBuildSwiftInputConfig(
          out: $checkedConvert(
              'out', (v) => PigeonBuildOutputConfig.fromJson(v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$PigeonBuildSwiftInputConfigToJson(
        PigeonBuildSwiftInputConfig instance) =>
    <String, dynamic>{
      'out': instance.out,
    };

PigeonBuildKotlinInputConfig _$PigeonBuildKotlinInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildKotlinInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['out', 'package'],
        );
        final val = PigeonBuildKotlinInputConfig(
          out: $checkedConvert(
              'out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          package: $checkedConvert('package', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PigeonBuildKotlinInputConfigToJson(
        PigeonBuildKotlinInputConfig instance) =>
    <String, dynamic>{
      'out': instance.out,
      'package': instance.package,
    };

PigeonBuildCppInputConfig _$PigeonBuildCppInputConfigFromJson(Map json) =>
    $checkedCreate(
      'PigeonBuildCppInputConfig',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['header-out', 'source-out', 'namespace'],
        );
        final val = PigeonBuildCppInputConfig(
          headerOut: $checkedConvert(
              'header-out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          sourceOut: $checkedConvert(
              'source-out', (v) => PigeonBuildOutputConfig.fromJson(v)),
          namespace: $checkedConvert('namespace', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'headerOut': 'header-out', 'sourceOut': 'source-out'},
    );

Map<String, dynamic> _$PigeonBuildCppInputConfigToJson(
        PigeonBuildCppInputConfig instance) =>
    <String, dynamic>{
      'header-out': instance.headerOut,
      'source-out': instance.sourceOut,
      'namespace': instance.namespace,
    };
