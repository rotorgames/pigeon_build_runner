import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/src/validation/validation_errors.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final goodBasePath = 'pigeons/';
  final goodBaseOut = PigeonBuildOutputConfig(
    path: goodBasePath,
  );

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
