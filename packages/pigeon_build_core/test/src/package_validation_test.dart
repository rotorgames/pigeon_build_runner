import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';
import 'package:test/test.dart';

void main() {
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
