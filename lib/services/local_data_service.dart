import '../database/app_database.dart';
import '../repositories/local_data_repository.dart';

final AppDatabase appDatabase = AppDatabase();
final LocalDataRepository localDataRepository = LocalDataRepository(appDatabase);
