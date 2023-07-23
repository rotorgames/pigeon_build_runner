import 'package:pigeon/pigeon.dart';
import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';
import 'package:test/test.dart';

void main() {
  final handler = PigeonBuildHandler();

  group('handleInput returns right pigion options for', () {
    final defaultSimpleMainConfig = PigeonBuildInputConfig(
      input: 'pigeon/',
      dart: PigeonBuildDartInputConfig(
        out: PigeonBuildOutputConfig(
          path: 'src/pigeon',
        ),
        testOut: PigeonBuildOutputConfig(
          path: 'test/pigeon/',
        ),
      ),
      ast: PigeonBuildAstInputConfig(
        out: PigeonBuildOutputConfig(
          path: 'ast/',
        ),
      ),
      java: PigeonBuildJavaInputConfig(
        out: PigeonBuildOutputConfig(
          path: 'java/',
        ),
        package: 'test.java',
      ),
      kotlin: PigeonBuildKotlinInputConfig(
        out: PigeonBuildOutputConfig(
          path: 'kotlin/',
        ),
        package: 'test.kotlin',
      ),
      objc: PigeonBuildObjcInputConfig(
        headerOut: PigeonBuildOutputConfig(
          path: 'objc/headers/',
        ),
        sourceOut: PigeonBuildOutputConfig(
          path: 'objc/sources/',
        ),
        prefix: 'objcprefix',
      ),
      swift: PigeonBuildSwiftInputConfig(
        out: PigeonBuildOutputConfig(
          path: 'swift/',
        ),
      ),
      cpp: PigeonBuildCppInputConfig(
        headerOut: PigeonBuildOutputConfig(
          path: 'cpp/headers/',
        ),
        sourceOut: PigeonBuildOutputConfig(
          path: 'cpp/sources/',
        ),
        namespace: 'testnamespace',
      ),
    );

    test('incorrect file path', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
        ),
      );

      final result = handler.handleInput(
        config,
        'test/file_for_example.dart',
      );
      expect(result.input, isNull);
      expect(result.options, isNull);
    });
    test('main input only', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
      );

      final result =
          handler.handleInput(config, 'pigeon/file_for_example.dart');

      expect(result.input, isNull);
      expect(result.options, isNull);
    });

    test('nested file input only', () {
      final config = PigeonBuildConfig(
        inputs: [
          PigeonBuildInputConfig(
            input: 'pigeon/file_for_example.dart',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'src/pigeon/file_for_example.dart',
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'test/pigeon/file_for_example.dart',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'ast/file_for_example.dart',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'java/FileForExample.java',
              ),
              package: 'test.java',
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'kotlin/FileForExample.kt',
              ),
              package: 'test.kotlin',
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'objc/headers/FileForExample.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'objc/sources/FileForExample.m',
              ),
              prefix: 'objcprefix',
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'swift/FileForExample.swift',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'cpp/headers/file_for_example.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'cpp/sources/file_for_example.cpp',
              ),
              namespace: 'testnamespace',
            ),
          ),
        ],
      );

      final result =
          handler.handleInput(config, 'pigeon/file_for_example.dart');
      final options = result.options;

      expect(options, isNotNull);
      expect(options!.input, 'pigeon/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/file_for_example.dart');
      expect(options.dartTestOut, 'test/pigeon/file_for_example.dart');
      expect(options.astOut, 'ast/file_for_example.dart');
      expect(options.javaOut, 'java/FileForExample.java');
      expect(options.javaOptions, isNotNull);
      expect(options.javaOptions!.package, 'test.java');
      expect(options.kotlinOut, 'kotlin/FileForExample.kt');
      expect(options.kotlinOptions, isNotNull);
      expect(options.kotlinOptions?.package, 'test.kotlin');
      expect(options.objcHeaderOut, 'objc/headers/FileForExample.h');
      expect(options.objcSourceOut, 'objc/sources/FileForExample.m');
      expect(options.objcOptions, isNotNull);
      expect(options.objcOptions!.prefix, 'objcprefix');
      expect(options.swiftOut, 'swift/FileForExample.swift');
      expect(options.swiftOptions, isNull);
      expect(options.cppHeaderOut, 'cpp/headers/file_for_example.h');
      expect(options.cppSourceOut, 'cpp/sources/file_for_example.cpp');
      expect(options.cppOptions, isNotNull);
      expect(options.cppOptions!.namespace, 'testnamespace');
    });

    test(
        'main input and one nested relative file input with relative file output',
        () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/custom_file_for_example.dart',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.dart',
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.dart',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.dart',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.java',
              ),
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.kt',
              ),
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.m',
              ),
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.swift',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.cpp',
              ),
            ),
          )
        ],
      );

      final result = handler.handleInput(
        config,
        'pigeon/nested_folder/custom_file_for_example.dart',
      );
      final options = result.options;
      expect(result.input, config.inputs.first);
      expect(options, isNotNull);
      expect(
          options!.input, 'pigeon/nested_folder/custom_file_for_example.dart');
      expect(options.dartOut,
          'src/pigeon/nested_folder/custom_file_for_example.dart');
      expect(options.dartTestOut,
          'test/pigeon/nested_folder/custom_file_for_example.dart');
      expect(options.astOut, 'ast/nested_folder/custom_file_for_example.dart');
      expect(options.javaOut, 'java/nested_folder/CustomFileForExample.java');
      expect(options.kotlinOut, 'kotlin/nested_folder/CustomFileForExample.kt');
      expect(options.objcHeaderOut,
          'objc/headers/nested_folder/CustomFileForExample.h');
      expect(options.objcSourceOut,
          'objc/sources/nested_folder/CustomFileForExample.m');
      expect(
          options.swiftOut, 'swift/nested_folder/CustomFileForExample.swift');
      expect(options.swiftOptions, isNull);
      expect(options.cppHeaderOut,
          'cpp/headers/nested_folder/custom_file_for_example.h');
      expect(options.cppSourceOut,
          'cpp/sources/nested_folder/custom_file_for_example.cpp');
    });

    test('main input and one nested input with absolute file outputs', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: '/input/custom_folder/custom_file_for_example.dart',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/dart/custom_folder/custom_file_for_example.dart',
              ),
              testOut: PigeonBuildOutputConfig(
                path: '/dart-test/custom_folder/custom_file_for_example.dart',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/ast/custom_folder/custom_file_for_example.dart',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/java/custom_folder/CustomFileForExample.java',
              ),
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/kotlin/custom_folder/CustomFileForExample.kt',
              ),
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: '/objc/headers/custom_folder/CustomFileForExample.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: '/objc/sources/custom_folder/CustomFileForExample.m',
              ),
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/swift/custom_folder/CustomFileForExample.swift',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: '/cpp/headers/custom_folder/custom_file_for_example.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: '/cpp/sources/custom_folder/custom_file_for_example.cpp',
              ),
            ),
          )
        ],
      );

      final result = handler.handleInput(
        config,
        'input/custom_folder/custom_file_for_example.dart',
      );
      final options = result.options;

      expect(result.input, config.inputs.first);
      expect(options, isNotNull);
      expect(
          options!.input, 'input/custom_folder/custom_file_for_example.dart');
      expect(
          options.dartOut, 'dart/custom_folder/custom_file_for_example.dart');
      expect(options.dartTestOut,
          'dart-test/custom_folder/custom_file_for_example.dart');
      expect(options.astOut, 'ast/custom_folder/custom_file_for_example.dart');
      expect(options.javaOut, 'java/custom_folder/CustomFileForExample.java');
      expect(options.kotlinOut, 'kotlin/custom_folder/CustomFileForExample.kt');
      expect(options.objcHeaderOut,
          'objc/headers/custom_folder/CustomFileForExample.h');
      expect(options.objcSourceOut,
          'objc/sources/custom_folder/CustomFileForExample.m');
      expect(
          options.swiftOut, 'swift/custom_folder/CustomFileForExample.swift');
      expect(options.swiftOptions, isNull);
      expect(options.cppHeaderOut,
          'cpp/headers/custom_folder/custom_file_for_example.h');
      expect(options.cppSourceOut,
          'cpp/sources/custom_folder/custom_file_for_example.cpp');
    });

    test('main input and one nested relative file input without package', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/custom_file_for_example.dart',
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.java',
              ),
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.kt',
              ),
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/CustomFileForExample.m',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.h',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/custom_file_for_example.cpp',
              ),
            ),
          )
        ],
      );

      final result = handler.handleInput(
        config,
        'pigeon/nested_folder/custom_file_for_example.dart',
      );
      final options = result.options;
      expect(result.input, config.inputs.first);
      expect(options, isNotNull);
      expect(
          options!.javaOptions?.package, defaultSimpleMainConfig.java!.package);
      expect(options.kotlinOptions?.package,
          defaultSimpleMainConfig.kotlin!.package);
      expect(options.objcOptions?.prefix, defaultSimpleMainConfig.objc!.prefix);
      expect(options.cppOptions?.namespace,
          defaultSimpleMainConfig.cpp!.namespace);
    });
  });

  group('pigeon options', () {
    test('getAllOutputs contains all outputs', () async {
      final options = PigeonOptions(
        astOut: "ast",
        dartOut: "dart",
        javaOut: "java",
        kotlinOut: "kotlin",
        swiftOut: "swift",
        objcHeaderOut: "objc-header",
        objcSourceOut: "objc-source",
        cppHeaderOut: "cpp-header",
        cppSourceOut: "cpp-source",
      );

      final expectedOutputs = [
        options.astOut,
        options.dartOut,
        options.javaOut,
        options.kotlinOut,
        options.swiftOut,
        options.objcHeaderOut,
        options.objcSourceOut,
        options.cppHeaderOut,
        options.cppSourceOut,
      ];

      expect(options.getAllOutputs(), unorderedEquals(expectedOutputs));
    });
  });
}
