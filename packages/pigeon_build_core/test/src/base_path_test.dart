import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/src/validation/validation_errors.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final goodBasePath = 'pigeons/';
  final wrongBasePath = 'pigeons/folder/file.dart';
  final wrongBasePathOutput = PigeonBuildOutputConfig(
    path: wrongBasePath,
  );
  final goodBaseOut = PigeonBuildOutputConfig(
    path: goodBasePath,
  );

  group('throws if base path in main input is a file for', (() {
    test('input', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          input: wrongBasePath,
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('dart out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          dart: PigeonBuildDartInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('dart testOut', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          dart: PigeonBuildDartInputConfig(
            out: wrongBasePathOutput,
            testOut: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('ast out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          ast: PigeonBuildAstInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('java out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          java: PigeonBuildJavaInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('kotlin out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          kotlin: PigeonBuildKotlinInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('objc header-out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          objc: PigeonBuildObjcInputConfig(
            headerOut: wrongBasePathOutput,
            sourceOut: goodBaseOut,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('objc source-out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          objc: PigeonBuildObjcInputConfig(
            headerOut: goodBaseOut,
            sourceOut: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('swift out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          swift: PigeonBuildSwiftInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('cpp header-out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          cpp: PigeonBuildCppInputConfig(
            headerOut: wrongBasePathOutput,
            sourceOut: goodBaseOut,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('cpp source-out', () {
      expect(
        () => mainInputGenerator(PigeonBuildInputConfig(
          cpp: PigeonBuildCppInputConfig(
            headerOut: goodBaseOut,
            sourceOut: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });
  }));
  group(
      'throws if relative package is used with no base package in main input for',
      () {
    final wrongPackage = ".test.package";
    test('java', () {
      expect(
        () => defaultGenerator(PigeonBuildConfig(
          inputs: [
            PigeonBuildInputConfig(
              java: PigeonBuildJavaInputConfig(
                out: goodBaseOut,
                package: wrongPackage,
              ),
            ),
          ],
        )),
        throwsA(isA<MissingJavaOrKotlinBasePackageException>()),
      );
    });

    test('kotlin', () {
      expect(
        () => defaultGenerator(PigeonBuildConfig(
          inputs: [
            PigeonBuildInputConfig(
              kotlin: PigeonBuildKotlinInputConfig(
                out: goodBaseOut,
                package: wrongPackage,
              ),
            ),
          ],
        )),
        throwsA(isA<MissingJavaOrKotlinBasePackageException>()),
      );
    });
  });
}
