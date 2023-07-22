import 'package:path/path.dart' as p;
import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/src/validation/validation_errors.dart';

class ConfigValidator {
  ConfigValidator._();

  //TODO add more path validations
  static void validateConfig(PigeonBuildConfig config) {
    final mainInput = config.mainInput;

    if (mainInput != null) {
      if (mainInput.input != null) {
        validateBasePath(mainInput.input, 'input');
      }

      if (mainInput.dart != null) {
        validateBasePath(mainInput.dart!.out.path, 'out', 'dart');
        validateBasePath(mainInput.dart!.testOut?.path, 'test-out', 'dart');
      }

      if (mainInput.ast != null) {
        validateBasePath(mainInput.ast!.out.path, 'out', 'ast');
      }

      if (mainInput.java != null) {
        validateBasePath(mainInput.java!.out.path, 'out', 'java');
        validateJavaOrKotlinPackage(mainInput.java!.package, 'java');
      }

      if (mainInput.kotlin != null) {
        validateBasePath(mainInput.kotlin!.out.path, 'out', 'kotlin');
        validateJavaOrKotlinPackage(mainInput.kotlin!.package, 'kotlin');
      }

      if (mainInput.objc != null) {
        validateBasePath(mainInput.objc!.headerOut.path, 'header-out', 'objc');
        validateBasePath(mainInput.objc!.sourceOut.path, 'source-out', 'objc');
      }

      if (mainInput.swift != null) {
        validateBasePath(mainInput.swift!.out.path, 'out', 'swift');
      }

      if (mainInput.cpp != null) {
        validateBasePath(mainInput.cpp!.headerOut.path, 'header-out', 'cpp');
        validateBasePath(mainInput.cpp!.sourceOut.path, 'source-out', 'cpp');
      }
    }

    for (var input in config.inputs) {
      if (input.java != null) {
        validateJavaOrKotlinPackage(
          input.java!.package,
          'java',
          mainInput?.java?.package,
        );
      }

      if (input.kotlin != null) {
        validateJavaOrKotlinPackage(
          input.kotlin!.package,
          'kotlin',
          mainInput?.java?.package,
        );
      }
    }
  }

  static void validateBasePath(
    String? path,
    String field, [
    String? generator,
  ]) {
    if (path != null && p.extension(path) != '') {
      throw BasePathIsNotDirectoryException(path, field, generator);
    }
  }

  static void validateJavaOrKotlinPackage(
    String? package,
    String generator, [
    String? basePackage,
  ]) {
    if (package == null) return;

    if (basePackage == null && package.startsWith('.')) {
      throw MissingJavaOrKotlinBasePackageException(
        package,
        'package',
        generator,
      );
    }
  }
}
