// flutter_test_config.dart
//
// Auto-discovered by `flutter test`. It runs ONCE before any test in the
// `test/` directory.  Here we use it to:
//   • load real Material/icon fonts (required so golden snapshots render
//     glyphs instead of empty boxes), and
//   • route every test through golden_toolkit's configured zone.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      // Use the default file-name builder so goldens land next to the
      // test file under a `goldens/` subdirectory.
      fileNameFactory: (name) => 'goldens/$name.png',
    ),
  );
}
