import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

enum PigeonBuildFileCase {
  snake,
  param,
  pascale,
  header,
  title,
  camel,
  sentence,
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: false,
)
class PigeonBuildOutputConfig {
  @JsonKey(name: 'path')
  final String path;
  @JsonKey(name: 'name-case')
  final PigeonBuildFileCase? nameCase;
  @JsonKey(name: 'extension')
  final String? extension;

  PigeonBuildOutputConfig({
    required this.path,
    this.nameCase,
    this.extension,
  });

  factory PigeonBuildOutputConfig.fromJson(dynamic json) {
    if (json is String) {
      return PigeonBuildOutputConfig(
        path: json,
      );
    }

    return _$PigeonBuildOutputConfigFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PigeonBuildOutputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: false,
)
class PigeonBuildPubspecConfig {
  @JsonKey(name: 'pigeon')
  final PigeonBuildConfig? pigeon;

  PigeonBuildPubspecConfig({
    this.pigeon,
  });

  factory PigeonBuildPubspecConfig.fromJson(Map json) =>
      _$PigeonBuildPubspecConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildPubspecConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildConfig {
  @JsonKey(name: 'enabled')
  final bool enabled;
  @JsonKey(name: 'main-input')
  final PigeonBuildInputConfig? mainInput;
  @JsonKey(name: 'inputs')
  final List<PigeonBuildInputConfig> inputs;

  PigeonBuildConfig({
    this.enabled = false,
    this.mainInput,
    this.inputs = const <PigeonBuildInputConfig>[],
  });

  factory PigeonBuildConfig.fromJson(Map json) =>
      _$PigeonBuildConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildInputConfig {
  @JsonKey(name: 'copyright-header')
  final String? copyrightHeader;

  @JsonKey(name: 'one-language')
  final bool? oneLanguage;

  @JsonKey(name: 'debug-generators')
  final bool? debugGenerators;

  @JsonKey(name: 'input', required: true)
  final String? input;

  @JsonKey(name: 'dart')
  final PigeonBuildDartInputConfig? dart;

  @JsonKey(name: 'ast')
  final PigeonBuildAstInputConfig? ast;

  @JsonKey(name: 'objc')
  final PigeonBuildObjcInputConfig? objc;

  @JsonKey(name: 'java')
  final PigeonBuildJavaInputConfig? java;

  @JsonKey(name: 'kotlin')
  final PigeonBuildKotlinInputConfig? kotlin;

  @JsonKey(name: 'swift')
  final PigeonBuildSwiftInputConfig? swift;

  @JsonKey(name: 'cpp')
  final PigeonBuildCppInputConfig? cpp;

  const PigeonBuildInputConfig({
    this.copyrightHeader,
    this.oneLanguage,
    this.ast,
    this.debugGenerators,
    this.input,
    this.dart,
    this.objc,
    this.java,
    this.kotlin,
    this.swift,
    this.cpp,
  });

  factory PigeonBuildInputConfig.fromJson(Map json) =>
      _$PigeonBuildInputConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PigeonBuildInputConfigToJson(this);
}

PigeonBuildOutputConfig? parseOut(dynamic source) {
  return null;
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildDartInputConfig {
  @JsonKey(name: 'out')
  final PigeonBuildOutputConfig out;
  @JsonKey(name: 'test-out')
  final PigeonBuildOutputConfig? testOut;

  PigeonBuildDartInputConfig({
    required this.out,
    this.testOut,
  });

  factory PigeonBuildDartInputConfig.fromJson(Map json) =>
      _$PigeonBuildDartInputConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PigeonBuildDartInputConfigToJson(this);
}

@JsonSerializable()
class PigeonBuildAstInputConfig {
  @JsonKey(name: 'out')
  final PigeonBuildOutputConfig out;

  PigeonBuildAstInputConfig({
    required this.out,
  });

  factory PigeonBuildAstInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildAstInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildAstInputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildObjcInputConfig {
  @JsonKey(name: 'header-out')
  final PigeonBuildOutputConfig headerOut;
  @JsonKey(name: 'source-out')
  final PigeonBuildOutputConfig sourceOut;
  @JsonKey(name: 'prefix')
  final String? prefix;

  PigeonBuildObjcInputConfig({
    required this.headerOut,
    required this.sourceOut,
    this.prefix,
  });

  factory PigeonBuildObjcInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildObjcInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildObjcInputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildJavaInputConfig {
  @JsonKey(name: 'out')
  final PigeonBuildOutputConfig out;
  @JsonKey(name: 'package')
  final String? package;
  @JsonKey(name: 'use-generated-annotation')
  final bool? useGeneratedAnnotation;

  PigeonBuildJavaInputConfig({
    required this.out,
    this.package,
    this.useGeneratedAnnotation,
  });

  factory PigeonBuildJavaInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildJavaInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildJavaInputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildSwiftInputConfig {
  @JsonKey(name: 'out')
  final PigeonBuildOutputConfig out;

  PigeonBuildSwiftInputConfig({
    required this.out,
  });

  factory PigeonBuildSwiftInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildSwiftInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildSwiftInputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildKotlinInputConfig {
  @JsonKey(name: 'out')
  final PigeonBuildOutputConfig out;
  @JsonKey(name: 'package')
  final String? package;

  PigeonBuildKotlinInputConfig({
    required this.out,
    this.package,
  });

  factory PigeonBuildKotlinInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildKotlinInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildKotlinInputConfigToJson(this);
}

@JsonSerializable(
  checked: true,
  anyMap: true,
  disallowUnrecognizedKeys: true,
)
class PigeonBuildCppInputConfig {
  @JsonKey(name: 'header-out')
  final PigeonBuildOutputConfig headerOut;
  @JsonKey(name: 'source-out')
  final PigeonBuildOutputConfig sourceOut;
  @JsonKey(name: 'namespace')
  final String? namespace;

  PigeonBuildCppInputConfig({
    required this.headerOut,
    required this.sourceOut,
    this.namespace,
  });

  factory PigeonBuildCppInputConfig.fromJson(Map<String, dynamic> json) =>
      _$PigeonBuildCppInputConfigFromJson(json);
  Map<String, dynamic> toJson() => _$PigeonBuildCppInputConfigToJson(this);
}
