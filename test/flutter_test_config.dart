// flutter_test_config.dart
//
// Auto-discovered by `flutter test`. Runs ONCE before any test in the
// `test/` directory.  Here we:
//   • load real Material/icon fonts (required so golden snapshots render
//     glyphs instead of empty boxes), and
//   • route every test through golden_toolkit's configured zone so
//     baseline PNGs land under a `goldens/` subdirectory.

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
      fileNameFactory: (name) => 'goldens/$name.png',
    ),
  );
}
