import 'dart:async';
import 'dart:io';

import 'package:build/build.dart';
import 'package:pigeon/pigeon_lib.dart';
import 'package:pigeon_build_config/pigeon_build_config.dart';
import 'package:pigeon_build_core/pigeon_build_core.dart';
import 'package:scratch_space/scratch_space.dart';

import 'pigeon_scratch_space.dart';

class PigeonBuilder extends Builder {
  static const String _pubspecFileName = 'pubspec.yaml';

  late final _scratchSpace = createScratchSpace();
  late final _handler = createHandler();
  late final _pigeonConfig = getPigeonConfig();

  late final _scratchSpaceResource = Resource(
    () => _scratchSpace,
    beforeExit: () => _scratchSpace.delete(),
  );

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final space = await buildStep.fetchResource(_scratchSpaceResource);

    await buildStep.canRead(buildStep.inputId);

    if (buildStep.inputId.extension == '.yaml') {
      return;
    }

    if (_pigeonConfig == null) {
      return;
    }

    final config = _pigeonConfig!;
    final handlerResult = _handler.handleInput(config, buildStep.inputId.path);

    if (handlerResult.options == null) {
      return;
    }

    await space.ensureAssets(
      [
        AssetId(buildStep.inputId.package, _pubspecFileName),
      ],
      buildStep,
    );
    final pigeonOptions = getPigeonOptionsForScratchSpace(
      handlerResult.options!,
      buildStep.allowedOutputs,
      space,
    );

    final allScratchOutputs = pigeonOptions.getAllOutputs();

    for (var scratchOutput in allScratchOutputs) {
      final file = File(scratchOutput);

      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }
    }

    await Pigeon.runWithOptions(pigeonOptions);

    for (var outAssetId in buildStep.allowedOutputs) {
      final scratchFile = space.fileFor(outAssetId);

      if (await scratchFile.exists()) {
        await space.copyOutput(outAssetId, buildStep);
      }
    }
  }

  @override
  Map<String, List<String>> get buildExtensions {
    final result = <String, List<String>>{
      'pubspec.yaml': ['.pigeon.yaml'], // .pigeon.yaml is a fake output
    };

    if (_pigeonConfig == null) {
      return result;
    }

    final allInputs = _handler.getAllInputs(_pigeonConfig!);

    for (var inputPath in allInputs) {
      final handlerResult = _handler.handleInput(_pigeonConfig!, inputPath);

      if (handlerResult.options == null) {
        continue;
      }

      result[inputPath] = handlerResult.options!.getAllOutputs();
    }

    return result;
  }

  PigeonBuildHandler createHandler() => PigeonBuildHandler();

  ScratchSpace createScratchSpace() => PigeonScratchSpace();

  PigeonOptions getPigeonOptionsForScratchSpace(
    PigeonOptions options,
    Iterable<AssetId> allowedOutputs,
    ScratchSpace space,
  ) {
    final newOptions = PigeonOptions(
      input: options.input,
      dartOut: pathToScratchSpacePath(options.dartOut, allowedOutputs, space),
      dartTestOut:
          pathToScratchSpacePath(options.dartTestOut, allowedOutputs, space),
      astOut: pathToScratchSpacePath(options.astOut, allowedOutputs, space),
      javaOut: pathToScratchSpacePath(options.javaOut, allowedOutputs, space),
      kotlinOut:
          pathToScratchSpacePath(options.kotlinOut, allowedOutputs, space),
      objcHeaderOut:
          pathToScratchSpacePath(options.objcHeaderOut, allowedOutputs, space),
      objcSourceOut:
          pathToScratchSpacePath(options.objcSourceOut, allowedOutputs, space),
      swiftOut: pathToScratchSpacePath(options.swiftOut, allowedOutputs, space),
      cppHeaderOut:
          pathToScratchSpacePath(options.cppHeaderOut, allowedOutputs, space),
      cppSourceOut:
          pathToScratchSpacePath(options.cppSourceOut, allowedOutputs, space),
    );

    return options.merge(newOptions);
  }

  String? pathToScratchSpacePath(
      String? path, Iterable<AssetId> allowedOutputs, ScratchSpace space) {
    if (path == null) {
      return null;
    }

    final assetId = allowedOutputs.firstWhere((a) => a.path == path);

    return space.fileFor(assetId).path;
  }

  PigeonBuildConfig? getPigeonConfig() {
    final config = PigeonBuildPubspecParser.parsePubspecFileSync(
      File("pubspec.yaml"),
    );

    if (config != null) {
      PigeonBuildConfigValidator.validateConfig(config);
    }

    return config;
  }
}
