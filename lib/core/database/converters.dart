import 'package:drift/drift.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';

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

class SyncErrorTypeConverter extends TypeConverter<SyncErrorType, int>
    with JsonTypeConverter2<SyncErrorType, int, int> {
  const SyncErrorTypeConverter();

  @override
  SyncErrorType fromSql(int fromDb) => SyncErrorType.values.firstWhere(
    (s) => s.value == fromDb,
    orElse: () => SyncErrorType.unknown,
  );

  @override
  int toSql(SyncErrorType value) => value.value;

  @override
  SyncErrorType fromJson(int json) => fromSql(json);

  @override
  int toJson(SyncErrorType value) => toSql(value);
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

class TemperatureRangeConverter extends TypeConverter<TemperatureRange, int>
    with JsonTypeConverter2<TemperatureRange, int, int> {
  const TemperatureRangeConverter();

  @override
  TemperatureRange fromSql(int fromDb) => TemperatureRange.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => TemperatureRange.values.first,
  );

  @override
  int toSql(TemperatureRange value) => value.value;

  @override
  TemperatureRange fromJson(int json) => fromSql(json);

  @override
  int toJson(TemperatureRange value) => toSql(value);
}

class WindLevelConverter extends TypeConverter<WindLevel, int>
    with JsonTypeConverter2<WindLevel, int, int> {
  const WindLevelConverter();

  @override
  WindLevel fromSql(int fromDb) => WindLevel.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => WindLevel.values.first,
  );

  @override
  int toSql(WindLevel value) => value.value;

  @override
  WindLevel fromJson(int json) => fromSql(json);

  @override
  int toJson(WindLevel value) => toSql(value);
}

class SkyConditionConverter extends TypeConverter<SkyCondition, int>
    with JsonTypeConverter2<SkyCondition, int, int> {
  const SkyConditionConverter();

  @override
  SkyCondition fromSql(int fromDb) => SkyCondition.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => SkyCondition.values.first,
  );

  @override
  int toSql(SkyCondition value) => value.value;

  @override
  SkyCondition fromJson(int json) => fromSql(json);

  @override
  int toJson(SkyCondition value) => toSql(value);
}

class RainLevelConverter extends TypeConverter<RainLevel, int>
    with JsonTypeConverter2<RainLevel, int, int> {
  const RainLevelConverter();

  @override
  RainLevel fromSql(int fromDb) => RainLevel.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => RainLevel.values.first,
  );

  @override
  int toSql(RainLevel value) => value.value;

  @override
  RainLevel fromJson(int json) => fromSql(json);

  @override
  int toJson(RainLevel value) => toSql(value);
}

class VisibilityLevelConverter extends TypeConverter<VisibilityLevel, int>
    with JsonTypeConverter2<VisibilityLevel, int, int> {
  const VisibilityLevelConverter();

  @override
  VisibilityLevel fromSql(int fromDb) => VisibilityLevel.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => VisibilityLevel.values.first,
  );

  @override
  int toSql(VisibilityLevel value) => value.value;

  @override
  VisibilityLevel fromJson(int json) => fromSql(json);

  @override
  int toJson(VisibilityLevel value) => toSql(value);
}

class MoonPresenceConverter extends TypeConverter<MoonPresence, int>
    with JsonTypeConverter2<MoonPresence, int, int> {
  const MoonPresenceConverter();

  @override
  MoonPresence fromSql(int fromDb) => MoonPresence.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => MoonPresence.values.first,
  );

  @override
  int toSql(MoonPresence value) => value.value;

  @override
  MoonPresence fromJson(int json) => fromSql(json);

  @override
  int toJson(MoonPresence value) => toSql(value);
}

class LocationErrorTypeConverter extends TypeConverter<LocationErrorType, int>
    with JsonTypeConverter2<LocationErrorType, int, int> {
  const LocationErrorTypeConverter();

  @override
  LocationErrorType fromSql(int fromDb) => LocationErrorType.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => LocationErrorType.values.first,
  );

  @override
  int toSql(LocationErrorType value) => value.value;

  @override
  LocationErrorType fromJson(int json) => fromSql(json);

  @override
  int toJson(LocationErrorType value) => toSql(value);
}

class LocationSourceConverter extends TypeConverter<LocationSource, int>
    with JsonTypeConverter2<LocationSource, int, int> {
  const LocationSourceConverter();

  @override
  LocationSource fromSql(int fromDb) => LocationSource.values.firstWhere(
    (e) => e.value == fromDb,
    orElse: () => LocationSource.values.first,
  );

  @override
  int toSql(LocationSource value) => value.value;

  @override
  LocationSource fromJson(int json) => fromSql(json);

  @override
  int toJson(LocationSource value) => toSql(value);
}
