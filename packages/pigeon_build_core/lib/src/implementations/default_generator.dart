import 'package:pigeon/ast.dart';
import 'package:pigeon_build_core/src/abstractions/generator.dart';
import 'package:path/path.dart' as p;
import 'package:pigeon/pigeon.dart';

import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:recase/recase.dart';

//TODO rename to handler or something like this
class DefaultPigeonGenerator extends PigeonGenerator {
  final PigeonBuildConfig config;

  DefaultPigeonGenerator(this.config);

  //TODO make it more extandable for overrides (add more methods)
  @override
  PigeonOptions? getPigeonOptions(String inputPath) {
    final nInputPath = p.normalize(inputPath);
    final inputDir = p.dirname(nInputPath);
    final inputFileName = p.basenameWithoutExtension(inputPath);

    if (p.extension(nInputPath) != ".dart") {
      throw ArgumentError("Input path could be .dart file only", "inputPath");
    }

    final inputs = [
      ...config.inputs,
      if (config.mainInput != null) config.mainInput!
    ];

    String? dartInput;
    String? dartOut;
    String? dartTestOut;
    String? objcHeaderOut;
    String? objcSourceOut;
    ObjcOptions? objcOptions;
    String? javaOut;
    JavaOptions? javaOptions;
    String? swiftOut;
    String? kotlinOut;
    KotlinOptions? kotlinOptions;
    String? cppHeaderOut;
    String? cppSourceOut;
    CppOptions? cppOptions;
    String? copyrightHeader;
    bool? oneLanguage;
    String? astOut;
    bool? debugGenerators;

    for (var input in inputs) {
      if (input.input == null) {
        continue;
      }

      final mainInput = input != config.mainInput ? config.mainInput : null;

      final isFile = p.extension(input.input!) != '';
      final currentDartInput = getPath(input.input, mainInput?.input);

      if (isFile && currentDartInput != nInputPath) {
        continue;
      }

      if (!isFile && currentDartInput != inputDir) {
        continue;
      }

      dartInput = nInputPath;
      copyrightHeader = input.copyrightHeader ?? mainInput?.copyrightHeader;
      oneLanguage = input.oneLanguage;
      debugGenerators = input.debugGenerators;

      astOut = getOutFilePath(
        fileName: inputFileName,
        out: input.ast?.out,
        baseOut: mainInput?.ast?.out,
        defaultExtension: '.dart',
      );

      if (input.dart != null) {
        dartOut = getOutFilePath(
          fileName: inputFileName,
          out: input.dart!.out,
          baseOut: mainInput?.dart?.out,
          defaultExtension: '.dart',
        );
        dartTestOut = getOutFilePath(
          fileName: inputFileName,
          out: input.dart!.testOut,
          baseOut: mainInput?.dart?.testOut,
          defaultExtension: '.dart',
        );
      }

      if (input.objc != null) {
        if (input.objc!.prefix != null) {
          objcOptions = ObjcOptions(
            prefix: input.objc!.prefix,
          );
        }
        objcHeaderOut = getOutFilePath(
          fileName: inputFileName,
          out: input.objc!.headerOut,
          baseOut: mainInput?.objc?.headerOut,
          defaultExtension: '.h',
          defaultCase: PigeonBuildFileCase.pascale,
        );
        objcSourceOut = getOutFilePath(
          fileName: inputFileName,
          out: input.objc!.sourceOut,
          baseOut: mainInput?.objc?.sourceOut,
          defaultExtension: '.m',
          defaultCase: PigeonBuildFileCase.pascale,
        );
      }

      if (input.java != null) {
        javaOptions = JavaOptions(
          package: getPackage(
            input.java!.package,
            mainInput?.java?.package,
          ),
          useGeneratedAnnotation: input.java!.useGeneratedAnnotation,
        );
        javaOut = getOutFilePath(
          fileName: inputFileName,
          out: input.java!.out,
          baseOut: mainInput?.java?.out,
          defaultExtension: '.java',
          defaultCase: PigeonBuildFileCase.pascale,
        );
      }

      if (input.kotlin != null) {
        kotlinOptions = KotlinOptions(
          package: getPackage(
            input.kotlin!.package,
            mainInput?.kotlin?.package,
          ),
        );
        kotlinOut = getOutFilePath(
          fileName: inputFileName,
          out: input.kotlin!.out,
          baseOut: mainInput?.kotlin?.out,
          defaultExtension: '.kt',
          defaultCase: PigeonBuildFileCase.pascale,
        );
      }

      if (input.swift != null) {
        swiftOut = getOutFilePath(
          fileName: inputFileName,
          out: input.swift!.out,
          baseOut: mainInput?.swift?.out,
          defaultExtension: '.swift',
          defaultCase: PigeonBuildFileCase.pascale,
        );
      }

      if (input.cpp != null) {
        cppOptions = CppOptions(
          namespace: input.cpp!.namespace,
        );
        cppHeaderOut = getOutFilePath(
          fileName: inputFileName,
          out: input.cpp!.headerOut,
          baseOut: mainInput?.cpp?.headerOut,
          defaultExtension: '.h',
        );
        cppSourceOut = getOutFilePath(
          fileName: inputFileName,
          out: input.cpp!.sourceOut,
          baseOut: mainInput?.cpp?.sourceOut,
          defaultExtension: '.cpp',
        );
      }

      break;
    }

    if (dartInput == null) return null;

    return PigeonOptions(
      input: dartInput,
      copyrightHeader: copyrightHeader,
      oneLanguage: oneLanguage,
      debugGenerators: debugGenerators,
      dartOut: dartOut,
      dartTestOut: dartTestOut,
      astOut: astOut,
      objcHeaderOut: objcHeaderOut,
      objcSourceOut: objcSourceOut,
      objcOptions: objcOptions,
      javaOut: javaOut,
      javaOptions: javaOptions,
      kotlinOut: kotlinOut,
      kotlinOptions: kotlinOptions,
      swiftOut: swiftOut,
      cppHeaderOut: cppHeaderOut,
      cppSourceOut: cppSourceOut,
      cppOptions: cppOptions,
    );
  }

  String? getOutFilePath({
    required String fileName,
    required String defaultExtension,
    PigeonBuildFileCase? defaultCase,
    PigeonBuildOutputConfig? out,
    PigeonBuildOutputConfig? baseOut,
  }) {
    final path = getPath(out?.path, baseOut?.path);
    if (path == null || p.extension(path) != '') {
      return path;
    }

    final extension = out?.extension ?? baseOut?.extension ?? defaultExtension;
    final nameCase = out?.nameCase ?? baseOut?.nameCase ?? defaultCase;

    var fullFileName = fileName;

    if (nameCase != null) {
      switch (nameCase) {
        case PigeonBuildFileCase.camel:
          fullFileName = fileName.camelCase;
          break;
        case PigeonBuildFileCase.header:
          fullFileName = fileName.headerCase;
          break;
        case PigeonBuildFileCase.param:
          fullFileName = fileName.paramCase;
          break;
        case PigeonBuildFileCase.pascale:
          fullFileName = fileName.pascalCase;
          break;
        case PigeonBuildFileCase.sentence:
          fullFileName = fileName.sentenceCase;
          break;
        case PigeonBuildFileCase.snake:
          fullFileName = fileName.snakeCase;
          break;
        case PigeonBuildFileCase.title:
          fullFileName = fileName.titleCase;
          break;
      }
    }

    return p.join(path, fullFileName + extension);
  }

  String? getPath(String? path, String? basePath) {
    final String result;
    final isBase = path?.startsWith('/') ?? false;

    if (isBase) {
      path = path!.substring(1);
    }

    if (path == null) {
      return null;
    } else if (isBase || basePath == null) {
      result = path;
    } else {
      result = p.join(basePath, path);
    }

    return p.normalize(result);
  }

  String? getPackage(String? package, String? basePackage) {
    if (package == null) return null;

    if (package.startsWith('.') && basePackage != null) {
      return basePackage + package;
    }

    return package;
  }
}
