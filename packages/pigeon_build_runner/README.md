![logo](https://raw.githubusercontent.com/rotorgames/pigeon_build_runner/main/assets/logo.png)

<div align="center">
  <a href="https://pub.dev/packages/pigeon_build_runner">
    <img alt="pub.dev" src="https://img.shields.io/pub/v/pigeon_build_runner"/>
  </a>
</div>

The `pigeon_build_runner` is a powerful Dart package that seamlessly integrates the `pigeon` package with the `build_runner` package, enhancing the efficiency and simplicity of code generation for Flutter projects. The package acts as a bridge between `pigeon` and `build_runner`, streamlining the communication process and automating the code generation workflow.

### Getting Started
To use pigeon_build_runner in your Flutter project, follow these steps:

#### 1. Install Dependencies
Add the following dependencies to your pubspec.yaml file:
```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  pigeon: ^<latest_pigeon_version>
  build_runner: ^<latest_build_runner_version>
  pigeon_build_runner: ^<latest_pigeon_build_runner_version>
```
Make sure to replace <latest_pigeon_version>, <latest_build_runner_version>, and <latest_pigeon_build_runner_version> with the most recent versions available. You can find the latest versions on [pub.dev](https://pub.dev).

#### 2. Include a pigeon folder
If you have your pigeon files placed outside the lib folder in your Dart project, you will need to create a `build.yaml` file to configure the build system properly. This step is necessary to generate the necessary code from your pigeon files.

**Note:** If you have all your pigeon files placed inside the lib folder, you can skip this step and proceed directly to Step 3.

Here's how you can do it:

1. In the root directory of your Dart project, create a new file named `build.yaml` if it doesn't already exist.

2. Open the `build.yaml` file in a text editor of your choice.

3. Add the following configuration to the `build.yaml` file:

```yaml
additional_public_assets:
    # Add the directories containing your pigeon files here, relative to the root directory
    - path/to/pigeons/directory/**
```

Replace `path/to/pigeons/directory` with the actual relative path to the directory where your pigeon files are located. Make sure to indent the lines properly as shown in the example.

#### 3. Configure your project

Open the pubspec.yaml file in your Flutter project.

Add the following configuration under the `pigeon` key.

It's not mandatory to include all the outputs mentioned below. Feel free to configure only the outputs that are necessary for your requirements.

**Note:** Replace paths with the essential paths for your project configuration.

```yaml
pigeon:
  # main-input defines default values and base paths or package names
  main-input:
    input: pigeons/
    dart:
      out: lib/src/pigeons/ 
      test-out: test/pigeons/
    ast:
      out: lib/src/pigeons_ast/
    objc:
      header-out: ios/Runner/
      source-out: ios/Runner/
      # Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
      prefix: PGN
    java:
      out: android/app/src/main/java/dev/flutter/pigeon_example_app
      package: your.package.name
    swift:
      out: ios/Runner/
    kotlin:
      out: android/app/src/main/kotlin/dev/flutter/pigeon_example_app
      package: your.package.name
    cpp:
      header-out: windows/runner
      source-out: windows/runner
      namespace: CppNamespace
  inputs:
    - input: my_pigeon.dart
      dart:
        out: my_pigeon.dart
        test-out: my_pigeon_test.dart
      ast:
        out: my_pigeon_ast.dart
      objc:
        header-out: my_pigeon.g.h
        source-out: my_pigeon.g.s
      java:
        out: MyPigeon.g.java
        # Adding `.` before a package will join a package name from main-input with the package belowe
        # Result: your.package.name.additional.package.name
        package: .additional.package.name
      kotlin:
        out: MyPigeon.g.kt
        # Adding `.` before a package will join a package name from main-input with the package belowe
        # Result: your.package.name.additional.package.name
        package: .additional.package.name
      swift:
        out: MyPigeon.g.swift
      cpp:
        header-out: my_pigeon.g.h
        source-out: my_pigeon.g.cpp
```

Using main-input is not absolutely mandatory, but it greatly aids in defining base paths for input/output folders and package names, effectively reducing boilerplate.

##### Path configuration

If the path begins with a forward slash `/`, the main package folder will be utilized.

```yaml
pigeon:
  main-input:
    input: pigeons/
    dart:
      out: lib/src/pigeons/ 
  inputs:
    - input: first_pigeon.dart
      dart:
        out: first_pigeon.dart # lib/src/pigeons/first_pigeon.dart
    - input: second_pigeon.dart
      dart:
        out: /lib/custom_folder/second_pigeon.dart # /lib/custom_folder/second_pigeon.dart
```

##### Package configuration

Also, if the package doesn't start with dot `.`, the package from `main-input` will not be used.

```yaml
pigeon:
  # main-input defines default values and base paths or package names
  main-input:
    input: pigeons/
    java:
      out: android/app/src/main/java/dev/flutter/pigeon_example_app
      package: your.package.name
  inputs:
    - input: first_pigeon.dart
      java:
        out: FirstPigeon.g.java
        package: .additional.package.name # your.package.name.additional.package.name
    - input: second_pigeon.dart
      java:
        out: SecondPigeon.g.java
        package: another.package.name # another.package.name
```

##### All available properties
Below is an overview of all the available properties for the pigeon_build_runner package. For more detailed information about each property, you can refer to the comprehensive [pigeon documentation](https://github.com/flutter/packages/tree/main/packages/pigeon). This documentation will provide you with valuable insights into the functionality and usage of each property
```yaml
pigeon:
  main-input:
    copyright-header: copyright.txt
    one-language: true
    debug-generators: true

    input: pigeons/

    ast:
      out: lib/src/pigeons_ast/
    objc:
      header-out: ios/Runner/
      source-out: ios/Runner/
      prefix: PGN
    java:
      out: android/app/src/main/java/dev/flutter/pigeon_example_app
      package: your.package.name
      use-generated-annotation: true
    swift:
      out: ios/Runner/
    kotlin:
      out: android/app/src/main/kotlin/dev/flutter/pigeon_example_app
      package: your.package.name
    cpp:
      header-out: windows/runner
      source-out: windows/runner
      namespace: CppNamespace
  inputs:
    - input: my_pigeon.dart
      
      copyright-header: custom_copyright.txt
      one-language: true
      debug-generators: true

      dart:
        out: my_pigeon.dart
        test-out: my_pigeon_test.dart
      ast:
        out: my_pigeon_ast.dart
      objc:
        header-out: my_pigeon.g.h
        source-out: my_pigeon.g.s
        prefix: CustomPrefix
      java:
        out: MyPigeon.g.java
        package: .additional.package.name
        use-generated-annotation: true
      kotlin:
        out: MyPigeon.g.kt
        package: .additional.package.name
      swift:
        out: MyPigeon.g.swift
      cpp:
        header-out: my_pigeon.g.h
        source-out: my_pigeon.g.cpp
```

### Created by Kirill Liubimov

* LinkedIn: [Kirill Liubimov](https://www.linkedin.com/in/kirill-lyubimov-06a68712b/)
* Twitter: [@kirillrg](https://twitter.com/kirillrg)
* Github: [rotorgames](https://github.com/rotorgames)

### License
MIT License

Copyright (c) 2023 Kirill Liubimov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.