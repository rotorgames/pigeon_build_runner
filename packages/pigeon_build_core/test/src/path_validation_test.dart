import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final goodBasePath = 'pigeons/';
  final wrongBasePath = 'pigeons/folder/file.dart';
  final wrongOutputPath = PigeonBuildOutputConfig(
    path: 'pigeons',
  );
  final goodOutputPath = PigeonBuildOutputConfig(
    path: 'pigeons/file.test',
  );
  final wrongBasePathOutput = PigeonBuildOutputConfig(
    path: wrongBasePath,
  );
  final goodBaseOut = PigeonBuildOutputConfig(
    path: goodBasePath,
  );

  group('throws if base path in main input is a file for', (() {
    test('input', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
          input: wrongBasePath,
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('dart out', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
          dart: PigeonBuildDartInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('dart testOut', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
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
        () => validateMainInputConfig(PigeonBuildInputConfig(
          ast: PigeonBuildAstInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('java out', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
          java: PigeonBuildJavaInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('kotlin out', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
          kotlin: PigeonBuildKotlinInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('objc header-out', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
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
        () => validateMainInputConfig(PigeonBuildInputConfig(
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
        () => validateMainInputConfig(PigeonBuildInputConfig(
          swift: PigeonBuildSwiftInputConfig(
            out: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });

    test('cpp header-out', () {
      expect(
        () => validateMainInputConfig(PigeonBuildInputConfig(
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
        () => validateMainInputConfig(PigeonBuildInputConfig(
          cpp: PigeonBuildCppInputConfig(
            headerOut: goodBaseOut,
            sourceOut: wrongBasePathOutput,
          ),
        )),
        throwsA(isA<BasePathIsNotDirectoryException>()),
      );
    });
  }));

  group('throws if a path is not a file for', (() {
    test('input', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          input: wrongOutputPath.path,
        )),
        throwsA(isA<InputPathIsNotFileException>()),
      );
    });

    test('dart out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          dart: PigeonBuildDartInputConfig(
            out: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('dart testOut', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          dart: PigeonBuildDartInputConfig(
            out: goodOutputPath,
            testOut: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('ast out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          ast: PigeonBuildAstInputConfig(
            out: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('java out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          java: PigeonBuildJavaInputConfig(
            out: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('kotlin out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          kotlin: PigeonBuildKotlinInputConfig(
            out: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('objc header-out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          objc: PigeonBuildObjcInputConfig(
            headerOut: wrongOutputPath,
            sourceOut: goodOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('objc source-out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          objc: PigeonBuildObjcInputConfig(
            headerOut: goodOutputPath,
            sourceOut: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('swift out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          swift: PigeonBuildSwiftInputConfig(
            out: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('cpp header-out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          cpp: PigeonBuildCppInputConfig(
            headerOut: wrongOutputPath,
            sourceOut: goodOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });

    test('cpp source-out', () {
      expect(
        () => validateSingleInputConfig(PigeonBuildInputConfig(
          cpp: PigeonBuildCppInputConfig(
            headerOut: goodOutputPath,
            sourceOut: wrongOutputPath,
          ),
        )),
        throwsA(isA<OutputPathIsNotFileException>()),
      );
    });
  }));

  group(
      'throws if relative package is used with no base package in main input for',
      () {
    final wrongPackage = ".test.package";
    test('java', () {
      expect(
        () => PigeonBuildConfigValidator.validateConfig(PigeonBuildConfig(
          inputs: [
            PigeonBuildInputConfig(
              java: PigeonBuildJavaInputConfig(
                out: PigeonBuildOutputConfig(path: 'Test.java'),
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
        () => PigeonBuildConfigValidator.validateConfig(PigeonBuildConfig(
          inputs: [
            PigeonBuildInputConfig(
              kotlin: PigeonBuildKotlinInputConfig(
                out: PigeonBuildOutputConfig(path: 'Test.java'),
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
