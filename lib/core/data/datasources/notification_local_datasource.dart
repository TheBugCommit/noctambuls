import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';
import 'package:noctambuls/core/domain/entities/in_app_notification.dart';

abstract class NotificationLocalDataSource {
  Stream<List<InAppNotification>> watchAll();

  Future<void> add(InAppNotification notification);

  Future<void> delete(String id);

  Future<void> clear();
}

class NotificationLocalDataSourceImpl implements NotificationLocalDataSource {
  NotificationLocalDataSourceImpl({required this.db});

  final AppDatabase db;

  @override
  Stream<List<InAppNotification>> watchAll() {
    return (db.select(
      db.notificationsTable,
    )..orderBy([(t) => OrderingTerm.desc(t.receivedAt)])).watch().map(
      (rows) => rows
          .map(
            (r) => InAppNotification(
              id: r.id,
              title: r.title,
              body: r.body,
              receivedAt: r.receivedAt,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> add(InAppNotification notification) async {
    await db
        .into(db.notificationsTable)
        .insertOnConflictUpdate(
          NotificationsTableCompanion.insert(
            id: notification.id,
            title: notification.title,
            body: notification.body,
            receivedAt: notification.receivedAt,
          ),
        );
  }

  @override
  Future<void> delete(String id) async {
    await (db.delete(
      db.notificationsTable,
    )..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> clear() async {
    await db.delete(db.notificationsTable).go();
  }
}
