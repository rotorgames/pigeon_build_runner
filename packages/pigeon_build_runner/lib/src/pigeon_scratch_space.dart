import 'dart:io';

import 'package:build/build.dart';
import 'package:scratch_space/scratch_space.dart';
import 'package:path/path.dart' as p;

class PigeonScratchSpace extends ScratchSpace {
  @override
  File fileFor(AssetId id) {
    final packagePath = p.url.join('package', id.package, id.path);

    final file = File(p.join(tempDir.path, p.normalize(packagePath)));

    return file;
  }
}
