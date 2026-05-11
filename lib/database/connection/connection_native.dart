import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openDatabaseConnection() {
  return driftDatabase(
    name: 'car_rent.sqlite',
    native: const DriftNativeOptions(),
  );
}
