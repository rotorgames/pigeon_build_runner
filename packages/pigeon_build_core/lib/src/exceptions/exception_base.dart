import 'package:meta/meta.dart';

abstract class PigeonExceptionBase implements Exception {
  @override
  String toString() {
    final errorText = getErrorText();
    final errorProperties = <String, String>{};

    setErrorProperties(errorProperties);

    var message = errorText;

    for (var errorProperty in errorProperties.entries) {
      message += "\n${errorProperty.key}: ${errorProperty.value}";
    }

    return message;
  }

  String getErrorText();

  @mustCallSuper
  void setErrorProperties(Map<String, String> properties) {}
}
