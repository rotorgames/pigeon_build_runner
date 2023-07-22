import 'package:meta/meta.dart';

import '../exceptions/exception_base.dart';

abstract class GeneratorExceptionBase extends PigeonExceptionBase {
  final String field;
  final String? generator;

  GeneratorExceptionBase(this.field, [this.generator]);

  @override
  @mustCallSuper
  void setErrorProperties(Map<String, String> properties) {
    super.setErrorProperties(properties);

    properties['field'] = field;

    if (generator != null) {
      properties['generator'] = generator!;
    }
  }
}

abstract class PathExceptionBase extends GeneratorExceptionBase {
  final String path;

  PathExceptionBase(this.path, super.field, [super.generator]);

  @override
  void setErrorProperties(Map<String, String> properties) {
    super.setErrorProperties(properties);

    properties['path'] = path;
  }
}

class BasePathIsNotDirectoryException extends PathExceptionBase {
  BasePathIsNotDirectoryException(super.path, super.field, super.generator);

  @override
  String getErrorText() => 'All paths in main input should be a directory';
}

class InputPathIsNotFileException extends PathExceptionBase {
  InputPathIsNotFileException(super.path, super.field, [super.generator]);

  @override
  String getErrorText() => 'Input path should be a file';
}

class OutputPathIsNotFileException extends PathExceptionBase {
  OutputPathIsNotFileException(super.path, super.field, [super.generator]);

  @override
  String getErrorText() => 'Output path should be a file';
}

class MissingJavaOrKotlinBasePackageException extends GeneratorExceptionBase {
  final String package;

  MissingJavaOrKotlinBasePackageException(
    this.package,
    super.field, [
    super.generator,
  ]);

  @override
  String getErrorText() =>
      'Relative package can not be used if the base package in the main input is not defined';

  @override
  void setErrorProperties(Map<String, String> properties) {
    super.setErrorProperties(properties);

    properties['package'] = package;
  }
}
