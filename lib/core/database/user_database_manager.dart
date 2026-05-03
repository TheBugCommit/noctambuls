import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UserDatabaseManager {
  UserDatabaseManager(this.logger);

  final IAppLogger logger;

  UserDatabase? _database;

  Future<void> initDatabase(String userId) async {
    if (_database != null) {
      await closeDatabase();
    }

    _database = UserDatabase(_openConnection(userId));
  }

  UserDatabase get database {
    if (_database == null) {
      final failure = const DatabaseFailure().withDebug(
        'Try to access DB before initialization',
        StackTrace.current,
      );
      logger.failure(failure);
      throw StateError(failure.debugMessage);
    }

    return _database!;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  QueryExecutor _openConnection(String userId) {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(
        p.join(dbFolder.path, 'noctambuls_db_user_$userId.sqlite'),
      );

      return NativeDatabase.createInBackground(file);
    });
  }
}
