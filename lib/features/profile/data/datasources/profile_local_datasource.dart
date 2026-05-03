import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/user_database.dart';
import 'package:noctambuls/core/database/user_database_manager.dart';
import 'package:noctambuls/features/profile/data/models/user_profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveProfile(UserProfileModel model);
  Future<UserProfileModel?> getProfile(String userId);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  const ProfileLocalDataSourceImpl({required this.dbManager});

  final UserDatabaseManager dbManager;

  UserDatabase get _db => dbManager.database;

  @override
  Future<void> saveProfile(UserProfileModel model) async {
    await _db.into(_db.userProfileTable).insertOnConflictUpdate(
      UserProfileTableCompanion(
        id: Value(model.id),
        name: Value(model.name),
        phone: Value(model.phone),
        ornithologistCode: Value(model.ornithologistCode),
        createdAt: Value(model.createdAt),
      ),
    );
  }

  @override
  Future<UserProfileModel?> getProfile(String userId) async {
    final row = await (_db.select(_db.userProfileTable)
          ..where((tbl) => tbl.id.equals(userId)))
        .getSingleOrNull();

    if (row == null) return null;

    return UserProfileModel(
      id: row.id,
      name: row.name,
      phone: row.phone,
      ornithologistCode: row.ornithologistCode,
      createdAt: row.createdAt,
    );
  }
}
