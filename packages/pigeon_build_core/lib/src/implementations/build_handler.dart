import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pigeon/pigeon.dart';

import 'package:pigeon_build_config/pigeon_build_config.dart';

import '../../pigeon_build_core.dart';

class PigeonBuildHandler {
  final p.Context pathContext =
      p.Context(style: Platform.isWindows ? p.Style.posix : p.Style.platform);

  BuildHandlerResult handleInput(PigeonBuildConfig config, String inputPath) {
    final nInputPath = pathContext.normalize(inputPath);
    final mainInput = config.mainInput;

    if (p.extension(nInputPath) != ".dart") {
      throw ArgumentError("Input path could be .dart file only", "inputPath");
    }

    PigeonBuildInputConfig? outInput;
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

    for (var input in config.inputs) {
      if (input.input == null) {
        continue;
      }

      final currentInputPath = combinePath(input.input, mainInput?.input);

      if (currentInputPath != nInputPath) {
        continue;
      }

      outInput = input;
      dartInput = nInputPath;
      copyrightHeader = input.copyrightHeader ?? mainInput?.copyrightHeader;
      oneLanguage = input.oneLanguage;
      debugGenerators = input.debugGenerators;

      astOut = combineOutFilePath(
        out: input.ast?.out,
        baseOut: mainInput?.ast?.out,
      );

      if (input.dart != null) {
        dartOut = combineOutFilePath(
          out: input.dart!.out,
          baseOut: mainInput?.dart?.out,
        );
        dartTestOut = combineOutFilePath(
          out: input.dart!.testOut,
          baseOut: mainInput?.dart?.testOut,
        );
      }

      if (input.objc != null) {
        if (mainInput?.objc?.prefix != null || input.objc!.prefix != null) {
          objcOptions = ObjcOptions(
            prefix: input.objc?.prefix ?? mainInput!.objc!.prefix,
          );
        } else {
          objcOptions =
              ObjcOptions(); //TODO: Remove when this PR is merged https://github.com/flutter/packages/pull/4756
        }
        objcHeaderOut = combineOutFilePath(
          out: input.objc!.headerOut,
          baseOut: mainInput?.objc?.headerOut,
        );
        objcSourceOut = combineOutFilePath(
          out: input.objc!.sourceOut,
          baseOut: mainInput?.objc?.sourceOut,
        );
      }

      if (input.java != null) {
        javaOptions = JavaOptions(
          package: combinePackage(
            input.java!.package,
            mainInput?.java?.package,
          ),
          useGeneratedAnnotation: input.java!.useGeneratedAnnotation,
        );
        javaOut = combineOutFilePath(
          out: input.java!.out,
          baseOut: mainInput?.java?.out,
        );
      }

      if (input.kotlin != null) {
        kotlinOptions = KotlinOptions(
          package: combinePackage(
            input.kotlin!.package,
            mainInput?.kotlin?.package,
          ),
        );
        kotlinOut = combineOutFilePath(
          out: input.kotlin!.out,
          baseOut: mainInput?.kotlin?.out,
        );
      }

      if (input.swift != null) {
        swiftOut = combineOutFilePath(
          out: input.swift!.out,
          baseOut: mainInput?.swift?.out,
        );
      }

      if (input.cpp != null) {
        if (mainInput?.cpp?.namespace != null || input.cpp!.namespace != null) {
          cppOptions = CppOptions(
            namespace: input.cpp?.namespace ?? mainInput!.cpp!.namespace,
          );
        } else {
          cppOptions =
              CppOptions(); //TODO: Remove when this PR is merged https://github.com/flutter/packages/pull/4756
        }
        cppHeaderOut = combineOutFilePath(
          out: input.cpp!.headerOut,
          baseOut: mainInput?.cpp?.headerOut,
        );
        cppSourceOut = combineOutFilePath(
          out: input.cpp!.sourceOut,
          baseOut: mainInput?.cpp?.sourceOut,
        );
      }

      break;
    }

    if (outInput == null) {
      return createBuildHandlerResult(
        config: config,
      );
    }

    final pigeonOptions = PigeonOptions(
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

    return createBuildHandlerResult(
      config: config,
      input: outInput,
      options: pigeonOptions,
    );
  }

  BuildHandlerResult createBuildHandlerResult({
    required PigeonBuildConfig config,
    PigeonBuildInputConfig? input,
    PigeonOptions? options,
  }) {
    return BuildHandlerResult(
      config: config,
      input: input,
      options: options,
    );
  }

  List<String> getAllInputs(PigeonBuildConfig config) {
    return config.inputs
        .map((input) => combinePath(input.input, config.mainInput?.input))
        .where((inputPath) => inputPath != null)
        .cast<String>()
        .toList();
  }

  String? combineOutFilePath({
    PigeonBuildOutputConfig? out,
    PigeonBuildOutputConfig? baseOut,
  }) {
    if (out == null) {
      return null;
    }

    return combinePath(out.path, baseOut?.path);
  }

  String? combinePath(String? path, String? basePath) {
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
      result = pathContext.join(basePath, path);
    }

    return pathContext.normalize(result);
  }

  String? combinePackage(String? package, String? basePackage) {
    if (package == null) {
      return basePackage;
    }

    if (package.startsWith('.') && basePackage != null) {
      return basePackage + package;
    }

    return package;
  }
}
