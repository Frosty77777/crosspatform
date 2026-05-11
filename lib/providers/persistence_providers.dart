import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../repositories/local_data_repository.dart';
import '../services/local_data_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return appDatabase;
});

final localDataRepositoryProvider = Provider<LocalDataRepository>((ref) {
  return localDataRepository;
});
