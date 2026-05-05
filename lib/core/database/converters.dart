import 'package:drift/drift.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/validation_status.dart';

class SyncStatusConverter extends TypeConverter<SyncStatus, int>
    with JsonTypeConverter2<SyncStatus, int, int> {
  const SyncStatusConverter();

  @override
  SyncStatus fromSql(int fromDb) => SyncStatus.values.firstWhere(
    (s) => s.value == fromDb,
    orElse: () => SyncStatus.draft,
  );

  @override
  int toSql(SyncStatus value) => value.value;

  @override
  SyncStatus fromJson(int json) => fromSql(json);

  @override
  int toJson(SyncStatus value) => toSql(value);
}

class SessionTypeConverter extends TypeConverter<SessionType, int>
    with JsonTypeConverter2<SessionType, int, int> {
  const SessionTypeConverter();

  @override
  SessionType fromSql(int fromDb) => SessionType.values.firstWhere(
    (s) => s.value == fromDb,
    orElse: () => SessionType.incidental,
  );

  @override
  int toSql(SessionType value) => value.value;

  @override
  SessionType fromJson(int json) => fromSql(json);

  @override
  int toJson(SessionType value) => toSql(value);
}

class ValidationStatusConverter extends TypeConverter<ValidationStatus, int>
    with JsonTypeConverter2<ValidationStatus, int, int> {
  const ValidationStatusConverter();

  @override
  ValidationStatus fromSql(int fromDb) => ValidationStatus.values.firstWhere(
    (s) => s.value == fromDb,
    orElse: () => ValidationStatus.pending,
  );

  @override
  int toSql(ValidationStatus value) => value.value;

  @override
  ValidationStatus fromJson(int json) => fromSql(json);

  @override
  int toJson(ValidationStatus value) => toSql(value);
}

class ContactTypeConverter extends TypeConverter<ContactType, int>
    with JsonTypeConverter2<ContactType, int, int> {
  const ContactTypeConverter();

  @override
  ContactType fromSql(int fromDb) => ContactType.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => ContactType.auditive,
  );

  @override
  int toSql(ContactType value) => value.value;

  @override
  ContactType fromJson(int json) => fromSql(json);

  @override
  int toJson(ContactType value) => toSql(value);
}
