import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/src/implementations/default_generator.dart';
import 'package:test/test.dart';

void main() {
  group('returns right pigion options for', () {
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

      final generator = DefaultPigeonGenerator(config);

      final options = generator.getPigeonOptions(
        'test/file_for_example.dart',
      );
      expect(options, isNull);
    });
    test('main input only', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
      );
      final generator = DefaultPigeonGenerator(config);

      final options =
          generator.getPigeonOptions('pigeon/file_for_example.dart');
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

    test('nested input only', () {
      final config = PigeonBuildConfig(
        inputs: [
          PigeonBuildInputConfig(
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
          ),
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options =
          generator.getPigeonOptions('pigeon/file_for_example.dart');
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

    test('main input and one nested relative input with relative outputs', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              package: '.nested.package',
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              package: '.nested.package',
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              prefix: 'objcprefix',
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              namespace: 'testnamespace',
            ),
          )
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options = generator
          .getPigeonOptions('pigeon/nested_folder/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/nested_folder/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/nested_folder/file_for_example.dart');
      expect(options.dartTestOut,
          'test/pigeon/nested_folder/file_for_example.dart');
      expect(options.astOut, 'ast/nested_folder/file_for_example.dart');
      expect(options.javaOut, 'java/nested_folder/FileForExample.java');
      expect(options.javaOptions, isNotNull);
      expect(options.javaOptions!.package, 'test.java.nested.package');
      expect(options.kotlinOut, 'kotlin/nested_folder/FileForExample.kt');
      expect(options.kotlinOptions, isNotNull);
      expect(options.kotlinOptions?.package, 'test.kotlin.nested.package');
      expect(
          options.objcHeaderOut, 'objc/headers/nested_folder/FileForExample.h');
      expect(
          options.objcSourceOut, 'objc/sources/nested_folder/FileForExample.m');
      expect(options.objcOptions, isNotNull);
      expect(options.objcOptions!.prefix, 'objcprefix');
      expect(options.swiftOut, 'swift/nested_folder/FileForExample.swift');
      expect(options.swiftOptions, isNull);
      expect(
          options.cppHeaderOut, 'cpp/headers/nested_folder/file_for_example.h');
      expect(options.cppSourceOut,
          'cpp/sources/nested_folder/file_for_example.cpp');
      expect(options.cppOptions, isNotNull);
      expect(options.cppOptions!.namespace, 'testnamespace');
    });

    test('main input and one nested relative file input with relative outputs',
        () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/file_for_example.dart',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              package: '.nested.package',
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              package: '.nested.package',
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              prefix: 'objcprefix',
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder/',
              ),
              namespace: 'testnamespace',
            ),
          ),
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options = generator
          .getPigeonOptions('pigeon/nested_folder/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/nested_folder/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/nested_folder/file_for_example.dart');
      expect(options.dartTestOut,
          'test/pigeon/nested_folder/file_for_example.dart');
      expect(options.astOut, 'ast/nested_folder/file_for_example.dart');
      expect(options.javaOut, 'java/nested_folder/FileForExample.java');
      expect(options.javaOptions, isNotNull);
      expect(options.javaOptions!.package, 'test.java.nested.package');
      expect(options.kotlinOut, 'kotlin/nested_folder/FileForExample.kt');
      expect(options.kotlinOptions, isNotNull);
      expect(options.kotlinOptions?.package, 'test.kotlin.nested.package');
      expect(
          options.objcHeaderOut, 'objc/headers/nested_folder/FileForExample.h');
      expect(
          options.objcSourceOut, 'objc/sources/nested_folder/FileForExample.m');
      expect(options.objcOptions, isNotNull);
      expect(options.objcOptions!.prefix, 'objcprefix');
      expect(options.swiftOut, 'swift/nested_folder/FileForExample.swift');
      expect(options.swiftOptions, isNull);
      expect(
          options.cppHeaderOut, 'cpp/headers/nested_folder/file_for_example.h');
      expect(options.cppSourceOut,
          'cpp/sources/nested_folder/file_for_example.cpp');
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
      final generator = DefaultPigeonGenerator(config);

      final options = generator.getPigeonOptions(
          'pigeon/nested_folder/custom_file_for_example.dart');
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

    test('main input and one nested input with absolute outputs', () {
      final config = PigeonBuildConfig(
        mainInput: defaultSimpleMainConfig,
        inputs: [
          PigeonBuildInputConfig(
            input: '/pigeon/',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/src/pigeon',
              ),
              testOut: PigeonBuildOutputConfig(
                path: '/test/pigeon/',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/ast/',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/java/',
              ),
              package: 'test.java',
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/kotlin/',
              ),
              package: 'test.kotlin',
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: '/objc/headers/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: '/objc/sources/',
              ),
              prefix: 'objcprefix',
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: '/swift/',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: '/cpp/headers/',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: '/cpp/sources/',
              ),
              namespace: 'testnamespace',
            ),
          ),
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options =
          generator.getPigeonOptions('pigeon/file_for_example.dart');
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

    test('main input with custom extensions', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
        ),
      );
      final generator = DefaultPigeonGenerator(config);

      final options = generator.getPigeonOptions('test/file_for_example.dart');
      expect(options, isNull);
    });
    test('main input only with custom extension', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
          dart: PigeonBuildDartInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'src/pigeon',
              extension: '.test',
            ),
            testOut: PigeonBuildOutputConfig(
              path: 'test/pigeon/',
              extension: '.test',
            ),
          ),
          ast: PigeonBuildAstInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'ast/',
              extension: '.test',
            ),
          ),
          java: PigeonBuildJavaInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'java/',
              extension: '.test',
            ),
          ),
          kotlin: PigeonBuildKotlinInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'kotlin/',
              extension: '.test',
            ),
          ),
          objc: PigeonBuildObjcInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'objc/headers/',
              extension: '.test',
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'objc/sources/',
              extension: '.test',
            ),
          ),
          swift: PigeonBuildSwiftInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'swift/',
              extension: '.test',
            ),
          ),
          cpp: PigeonBuildCppInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'cpp/headers/',
              extension: '.test',
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'cpp/sources/',
              extension: '.test',
            ),
          ),
        ),
      );
      final generator = DefaultPigeonGenerator(config);

      final options =
          generator.getPigeonOptions('pigeon/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/file_for_example.test');
      expect(options.dartTestOut, 'test/pigeon/file_for_example.test');
      expect(options.astOut, 'ast/file_for_example.test');
      expect(options.javaOut, 'java/FileForExample.test');
      expect(options.kotlinOut, 'kotlin/FileForExample.test');
      expect(options.objcHeaderOut, 'objc/headers/FileForExample.test');
      expect(options.objcSourceOut, 'objc/sources/FileForExample.test');
      expect(options.swiftOut, 'swift/FileForExample.test');
      expect(options.cppHeaderOut, 'cpp/headers/file_for_example.test');
      expect(options.cppSourceOut, 'cpp/sources/file_for_example.test');
    });

    test('main input and nested with custom extension', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
          dart: PigeonBuildDartInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'src/pigeon',
              extension: '.test',
            ),
            testOut: PigeonBuildOutputConfig(
              path: 'test/pigeon/',
              extension: '.test',
            ),
          ),
          ast: PigeonBuildAstInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'ast/',
              extension: '.test',
            ),
          ),
          java: PigeonBuildJavaInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'java/',
              extension: '.test',
            ),
          ),
          kotlin: PigeonBuildKotlinInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'kotlin/',
              extension: '.test',
            ),
          ),
          objc: PigeonBuildObjcInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'objc/headers/',
              extension: '.test',
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'objc/sources/',
              extension: '.test',
            ),
          ),
          swift: PigeonBuildSwiftInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'swift/',
              extension: '.test',
            ),
          ),
          cpp: PigeonBuildCppInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'cpp/headers/',
              extension: '.test',
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'cpp/sources/',
              extension: '.test',
            ),
          ),
        ),
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                extension: '.nested',
              ),
            ),
          ),
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options = generator
          .getPigeonOptions('pigeon/nested_folder/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/nested_folder/file_for_example.dart');
      expect(
          options.dartOut, 'src/pigeon/nested_folder/file_for_example.nested');
      expect(options.dartTestOut,
          'test/pigeon/nested_folder/file_for_example.nested');
      expect(options.astOut, 'ast/nested_folder/file_for_example.nested');
      expect(options.javaOut, 'java/nested_folder/FileForExample.nested');
      expect(options.kotlinOut, 'kotlin/nested_folder/FileForExample.nested');
      expect(options.objcHeaderOut,
          'objc/headers/nested_folder/FileForExample.nested');
      expect(options.objcSourceOut,
          'objc/sources/nested_folder/FileForExample.nested');
      expect(options.swiftOut, 'swift/nested_folder/FileForExample.nested');
      expect(options.cppHeaderOut,
          'cpp/headers/nested_folder/file_for_example.nested');
      expect(options.cppSourceOut,
          'cpp/sources/nested_folder/file_for_example.nested');
    });

    test('main input only with custom case', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
          dart: PigeonBuildDartInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'src/pigeon',
              nameCase: PigeonBuildFileCase.camel,
            ),
            testOut: PigeonBuildOutputConfig(
              path: 'test/pigeon/',
              nameCase: PigeonBuildFileCase.header,
            ),
          ),
          ast: PigeonBuildAstInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'ast/',
              nameCase: PigeonBuildFileCase.param,
            ),
          ),
          java: PigeonBuildJavaInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'java/',
              nameCase: PigeonBuildFileCase.pascale,
            ),
          ),
          kotlin: PigeonBuildKotlinInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'kotlin/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          objc: PigeonBuildObjcInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'objc/headers/',
              nameCase: PigeonBuildFileCase.snake,
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'objc/sources/',
              nameCase: PigeonBuildFileCase.title,
            ),
          ),
          swift: PigeonBuildSwiftInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'swift/',
              nameCase: PigeonBuildFileCase.title,
            ),
          ),
          cpp: PigeonBuildCppInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'cpp/headers/',
              nameCase: PigeonBuildFileCase.title,
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'cpp/sources/',
              nameCase: PigeonBuildFileCase.title,
            ),
          ),
        ),
      );
      final generator = DefaultPigeonGenerator(config);

      final options =
          generator.getPigeonOptions('pigeon/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/fileForExample.dart');
      expect(options.dartTestOut, 'test/pigeon/File-For-Example.dart');
      expect(options.astOut, 'ast/file-for-example.dart');
      expect(options.javaOut, 'java/FileForExample.java');
      expect(options.kotlinOut, 'kotlin/File for example.kt');
      expect(options.objcHeaderOut, 'objc/headers/file_for_example.h');
      expect(options.objcSourceOut, 'objc/sources/File For Example.m');
      expect(options.swiftOut, 'swift/File For Example.swift');
      expect(options.cppHeaderOut, 'cpp/headers/File For Example.h');
      expect(options.cppSourceOut, 'cpp/sources/File For Example.cpp');
    });

    test('main input and nested with custom case', () {
      final config = PigeonBuildConfig(
        mainInput: PigeonBuildInputConfig(
          input: 'pigeon/',
          dart: PigeonBuildDartInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'src/pigeon',
              nameCase: PigeonBuildFileCase.sentence,
            ),
            testOut: PigeonBuildOutputConfig(
              path: 'test/pigeon/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          ast: PigeonBuildAstInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'ast/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          java: PigeonBuildJavaInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'java/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          kotlin: PigeonBuildKotlinInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'kotlin/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          objc: PigeonBuildObjcInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'objc/headers/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'objc/sources/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          swift: PigeonBuildSwiftInputConfig(
            out: PigeonBuildOutputConfig(
              path: 'swift/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
          cpp: PigeonBuildCppInputConfig(
            headerOut: PigeonBuildOutputConfig(
              path: 'cpp/headers/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
            sourceOut: PigeonBuildOutputConfig(
              path: 'cpp/sources/',
              nameCase: PigeonBuildFileCase.sentence,
            ),
          ),
        ),
        inputs: [
          PigeonBuildInputConfig(
            input: 'nested_folder/',
            dart: PigeonBuildDartInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.camel,
              ),
              testOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.header,
              ),
            ),
            ast: PigeonBuildAstInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.param,
              ),
            ),
            java: PigeonBuildJavaInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.pascale,
              ),
            ),
            kotlin: PigeonBuildKotlinInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.sentence,
              ),
            ),
            objc: PigeonBuildObjcInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.snake,
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.title,
              ),
            ),
            swift: PigeonBuildSwiftInputConfig(
              out: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.title,
              ),
            ),
            cpp: PigeonBuildCppInputConfig(
              headerOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.title,
              ),
              sourceOut: PigeonBuildOutputConfig(
                path: 'nested_folder',
                nameCase: PigeonBuildFileCase.title,
              ),
            ),
          ),
        ],
      );
      final generator = DefaultPigeonGenerator(config);

      final options = generator
          .getPigeonOptions('pigeon/nested_folder/file_for_example.dart');
      expect(options, isNotNull);
      expect(options!.input, 'pigeon/nested_folder/file_for_example.dart');
      expect(options.dartOut, 'src/pigeon/nested_folder/fileForExample.dart');
      expect(options.dartTestOut,
          'test/pigeon/nested_folder/File-For-Example.dart');
      expect(options.astOut, 'ast/nested_folder/file-for-example.dart');
      expect(options.javaOut, 'java/nested_folder/FileForExample.java');
      expect(options.kotlinOut, 'kotlin/nested_folder/File for example.kt');
      expect(options.objcHeaderOut,
          'objc/headers/nested_folder/file_for_example.h');
      expect(options.objcSourceOut,
          'objc/sources/nested_folder/File For Example.m');
      expect(options.swiftOut, 'swift/nested_folder/File For Example.swift');
      expect(
          options.cppHeaderOut, 'cpp/headers/nested_folder/File For Example.h');
      expect(options.cppSourceOut,
          'cpp/sources/nested_folder/File For Example.cpp');
    });
  });
}
