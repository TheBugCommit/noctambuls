import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/core/domain/enums/location_source.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/moon_presence.dart';
import 'package:noctambuls/features/observations/domain/enums/rain_level.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sky_condition.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/enums/temperature_range.dart';
import 'package:noctambuls/features/observations/domain/enums/visibility_level.dart';
import 'package:noctambuls/features/observations/domain/enums/wind_level.dart';
import 'package:noctambuls/features/observations/domain/exceptions/session_exceptions.dart';
import 'package:noctambuls/features/observations/domain/failures/validation_failures.dart';

void main() {
  final now = DateTime(2024, 6, 15, 10, 30);

  ObservationSession buildSession({
    String id = 'sess-1',
    SessionType type = SessionType.incidental,
    bool isLocked = false,
    DateTime? startTime,
    DateTime? endTime,
    List<ObservationRecord> observations = const [],
    List<String> participants = const [],
    GeoPosition? location,
    int? listeningPoint,
    SyncStatus syncStatus = SyncStatus.draft,
  }) {
    return ObservationSession(
      id: id,
      annotatorId: 'user-1',
      sessionType: type,
      isLocked: isLocked,
      startTime: startTime,
      endTime: endTime,
      createdAt: now,
      updatedAt: now,
      observations: observations,
      participants: participants,
      location: location,
      listeningPoint: listeningPoint,
      syncStatus: syncStatus,
    );
  }

  ObservationRecord buildRecord({
    String id = 'obs-1',
    String sessionId = 'sess-1',
    GeoPosition? location,
  }) {
    return ObservationRecord(
      id: id,
      sessionId: sessionId,
      speciesId: 'parus_major',
      contactType: ContactType.visual,
      bearing: 0.0,
      startTime: now,
      endTime: now,
      createdAt: now,
      updatedAt: now,
      location: location,
    );
  }

  // ─── Propietats calculades ────────────────────────────────────────────────

  group('Propietats calculades', () {
    test('isObserving: endTime=null, !isLocked, !isDeleted → true', () {
      expect(buildSession().isObserving, isTrue);
    });

    test('isObserving: endTime!=null → false', () {
      expect(
        buildSession(endTime: now).isObserving,
        isFalse,
      );
    });

    test('isObserving: isLocked=true → false', () {
      expect(buildSession(isLocked: true).isObserving, isFalse);
    });

    test('isReviewing: endTime!=null, !isLocked, !isDeleted → true', () {
      expect(buildSession(endTime: now).isReviewing, isTrue);
    });

    test('isReviewing: isLocked=true → false', () {
      expect(
        buildSession(endTime: now, isLocked: true).isReviewing,
        isFalse,
      );
    });

    test('isFinished: isLocked=true, !isDeleted → true', () {
      expect(buildSession(isLocked: true).isFinished, isTrue);
    });

    test('canEditObservationDate: incidental + isObserving → true', () {
      expect(buildSession().canEditObservationDate, isTrue);
    });

    test(
      'canEditObservationDate: incidental + isReviewing (endTime!=null) → false',
      () {
        expect(
          buildSession(endTime: now).canEditObservationDate,
          isFalse,
        );
      },
    );

    test('canEditObservationDate: census → false', () {
      expect(
        buildSession(type: SessionType.census).canEditObservationDate,
        isFalse,
      );
    });

    test('needsListeningPoint: census → true', () {
      expect(
        buildSession(type: SessionType.census).needsListeningPoint,
        isTrue,
      );
    });

    test('needsListeningPoint: station → true', () {
      expect(
        buildSession(type: SessionType.station).needsListeningPoint,
        isTrue,
      );
    });

    test('needsListeningPoint: incidental → false', () {
      expect(buildSession().needsListeningPoint, isFalse);
    });

    test('needsLocation: census → true', () {
      expect(buildSession(type: SessionType.census).needsLocation, isTrue);
    });

    test('needsLocation: incidental → false', () {
      expect(buildSession().needsLocation, isFalse);
    });
  });

  // ─── addObservation ───────────────────────────────────────────────────────

  group('addObservation', () {
    test('hauria d\'afegir una observació a la llista', () {
      final record = buildRecord();
      final updated = buildSession().addObservation(record);

      expect(updated.observations.length, 1);
      expect(updated.observations.first.id, 'obs-1');
    });

    test('hauria d\'afegir múltiples observacions', () {
      final r1 = buildRecord(id: 'obs-1');
      final r2 = buildRecord(id: 'obs-2');

      final updated = buildSession().addObservation(r1).addObservation(r2);

      expect(updated.observations.length, 2);
    });

    test('hauria de llançar SessionUpdateException si la sessió és locked', () {
      expect(
        () => buildSession(isLocked: true).addObservation(buildRecord()),
        throwsA(isA<SessionUpdateException>()),
      );
    });
  });

  // ─── updateObservation ────────────────────────────────────────────────────

  group('updateObservation', () {
    test('hauria de substituir l\'observació existent per id', () {
      final original = buildRecord(id: 'obs-1');
      final updated = buildRecord(id: 'obs-1', sessionId: 'sess-1');

      final session = buildSession(observations: [original]);
      final result = session.updateObservation(updated);

      expect(result.observations.length, 1);
      expect(result.observations.first, updated);
    });

    test('hauria de llançar SessionUpdateException si la sessió és locked', () {
      final session = buildSession(
        isLocked: true,
        observations: [buildRecord()],
      );

      expect(
        () => session.updateObservation(buildRecord()),
        throwsA(isA<SessionUpdateException>()),
      );
    });

    test(
      'hauria de deixar la llista igual si l\'id no coincideix amb cap obs',
      () {
        final record = buildRecord(id: 'obs-1');
        final unknownRecord = buildRecord(id: 'obs-999');

        final session = buildSession(observations: [record]);
        final result = session.updateObservation(unknownRecord);

        expect(result.observations.first.id, 'obs-1');
      },
    );
  });

  // ─── removeObservation ────────────────────────────────────────────────────

  group('removeObservation', () {
    test('hauria d\'eliminar l\'observació amb l\'id indicat', () {
      final r1 = buildRecord(id: 'obs-1');
      final r2 = buildRecord(id: 'obs-2');

      final session = buildSession(observations: [r1, r2]);
      final result = session.removeObservation('obs-1');

      expect(result.observations.length, 1);
      expect(result.observations.first.id, 'obs-2');
    });

    test('no hauria de modificar res si l\'id no existeix', () {
      final session = buildSession(observations: [buildRecord()]);
      final result = session.removeObservation('inexistent');

      expect(result.observations.length, 1);
    });

    test('hauria de llançar SessionUpdateException si la sessió és locked', () {
      final session = buildSession(
        isLocked: true,
        observations: [buildRecord()],
      );

      expect(
        () => session.removeObservation('obs-1'),
        throwsA(isA<SessionUpdateException>()),
      );
    });
  });

  // ─── addParticipant ───────────────────────────────────────────────────────

  group('addParticipant', () {
    test('hauria d\'afegir un codi de format vàlid (#OR-ABCD-1234)', () {
      final result = buildSession().addParticipant('#OR-AB-2024');

      expect(result.participants, contains('#OR-AB-2024'));
    });

    test('hauria d\'acceptar codis amb 1-4 lletres', () {
      final s = buildSession();

      expect(
        () => s.addParticipant('#OR-A-0001'),
        returnsNormally,
      );
      expect(
        () => s.addParticipant('#OR-ABCD-9999'),
        returnsNormally,
      );
    });

    test(
      'hauria de llançar InvalidParticipantCodeException per format incorrecte',
      () {
        expect(
          () => buildSession().addParticipant('INVALID'),
          throwsA(isA<InvalidParticipantCodeException>()),
        );
        expect(
          () => buildSession().addParticipant('#OR--2024'),
          throwsA(isA<InvalidParticipantCodeException>()),
        );
        expect(
          () => buildSession().addParticipant('#OR-ABCDE-2024'),
          throwsA(isA<InvalidParticipantCodeException>()),
        );
      },
    );

    test('no hauria de duplicar un participant ja existent', () {
      const code = '#OR-AB-2024';
      final session = buildSession(participants: [code]);
      final result = session.addParticipant(code);

      expect(result.participants.length, 1);
    });

    test('hauria de llançar SessionUpdateException si la sessió és locked', () {
      expect(
        () => buildSession(isLocked: true).addParticipant('#OR-AB-2024'),
        throwsA(isA<SessionUpdateException>()),
      );
    });
  });

  // ─── removeParticipant ────────────────────────────────────────────────────

  group('removeParticipant', () {
    test('hauria d\'eliminar el participant indicat', () {
      const code = '#OR-AB-2024';
      final session = buildSession(participants: [code, '#OR-CD-2025']);
      final result = session.removeParticipant(code);

      expect(result.participants, isNot(contains(code)));
      expect(result.participants.length, 1);
    });

    test('no hauria de llançar si el codi no existia', () {
      final session = buildSession(participants: ['#OR-AB-2024']);
      expect(
        () => session.removeParticipant('#OR-ZZ-9999'),
        returnsNormally,
      );
    });

    test('hauria de retornar this sense canvis si la sessió és locked', () {
      const code = '#OR-AB-2024';
      final session = buildSession(isLocked: true, participants: [code]);
      final result = session.removeParticipant(code);

      expect(result.participants, contains(code));
    });
  });

  // ─── finishSession ────────────────────────────────────────────────────────

  group('finishSession', () {
    test('hauria d\'establir endTime (no null)', () {
      final result = buildSession(startTime: now).finishSession();

      expect(result.endTime, isNotNull);
      expect(result.isLocked, isFalse);
    });

    test(
      'hauria de llançar SessionUpdateException si la sessió ja no és observant',
      () {
        final reviewing = buildSession(endTime: now);

        expect(
          () => reviewing.finishSession(),
          throwsA(isA<SessionUpdateException>()),
        );
      },
    );

    test(
      'hauria de llançar SessionUpdateException si la sessió és locked',
      () {
        expect(
          () => buildSession(isLocked: true).finishSession(),
          throwsA(isA<SessionUpdateException>()),
        );
      },
    );
  });

  // ─── finishAndLock ────────────────────────────────────────────────────────

  group('finishAndLock', () {
    test(
      'hauria d\'establir isLocked=true i syncStatus=pending',
      () {
        final result = buildSession(startTime: now).finishAndLock();

        expect(result.isLocked, isTrue);
        expect(result.syncStatus, SyncStatus.pending);
        expect(result.endTime, isNotNull);
      },
    );

    test('hauria de ser idempotent si ja és finished', () {
      final locked = buildSession(isLocked: true);
      final result = locked.finishAndLock();

      expect(result, locked);
    });
  });

  // ─── changeDate ───────────────────────────────────────────────────────────

  group('changeDate', () {
    test('hauria de canviar la data en una sessió incidental observant', () {
      final session = buildSession(startTime: now);
      final newDate = DateTime(2024, 7, 1);

      expect(() => session.changeDate(newDate), returnsNormally);
    });

    test(
      'hauria de llançar SessionUpdateException en sessió no incidental',
      () {
        final census = buildSession(type: SessionType.census);
        expect(
          () => census.changeDate(DateTime(2024, 7, 1)),
          throwsA(isA<SessionUpdateException>()),
        );
      },
    );

    test(
      'hauria de llançar SessionUpdateException si la sessió ja no és observant',
      () {
        final reviewing = buildSession(endTime: now);
        expect(
          () => reviewing.changeDate(DateTime(2024, 7, 1)),
          throwsA(isA<SessionUpdateException>()),
        );
      },
    );

    test('hauria de canviar les dates de les observacions embegudes', () {
      final session = buildSession(
        startTime: now,
        observations: [buildRecord()],
      );
      final newDate = DateTime(2024, 7, 1);

      final result = session.changeDate(newDate);

      expect(result.observations.first.startTime.day, newDate.day);
      expect(result.observations.first.startTime.month, newDate.month);
    });
  });

  // ─── updateProperties ─────────────────────────────────────────────────────

  group('updateProperties', () {
    test('hauria d\'actualitzar les propietats indicades', () {
      final result = buildSession().updateProperties(
        temperature: TemperatureRange.aboveThirty,
        wind: WindLevel.moderate,
        sky: SkyCondition.overcast,
        rain: RainLevel.drizzle,
        visibility: VisibilityLevel.good,
        moon: MoonPresence.present,
        listeningPoint: 3,
      );

      expect(result.temperature, TemperatureRange.aboveThirty);
      expect(result.wind, WindLevel.moderate);
      expect(result.sky, SkyCondition.overcast);
      expect(result.rain, RainLevel.drizzle);
      expect(result.visibility, VisibilityLevel.good);
      expect(result.moon, MoonPresence.present);
      expect(result.listeningPoint, 3);
    });

    test('hauria de mantenir les propietats anteriors per als nuls', () {
      final session = buildSession().updateProperties(
        temperature: TemperatureRange.tenToTwenty,
      );

      final result = session.updateProperties(wind: WindLevel.breeze);

      expect(result.temperature, TemperatureRange.tenToTwenty);
      expect(result.wind, WindLevel.breeze);
    });
  });

  // ─── validateFinalization ─────────────────────────────────────────────────

  group('validateFinalization', () {
    final tLocation = GeoPosition(
      latitude: 41.3,
      longitude: 2.1,
      accuracy: 5.0,
      altitude: 100.0,
      altitudeAccuracy: 10.0,
      timestamp: now,
      locationSource: LocationSource.gps,
    );

    test('hauria de retornar null si tot és correcte (census)', () {
      final session = buildSession(
        type: SessionType.census,
        location: tLocation,
        listeningPoint: 1,
      );

      expect(session.validateFinalization(), isNull);
    });

    test('hauria de retornar null si tot és correcte (incidental)', () {
      final session = buildSession(
        observations: [buildRecord(location: tLocation)],
      );

      expect(session.validateFinalization(), isNull);
    });

    test('hauria de retornar null si incidental sense observacions', () {
      expect(buildSession().validateFinalization(), isNull);
    });

    test(
      'missingSessionLocation: census sense location → true',
      () {
        final session = buildSession(
          type: SessionType.census,
          listeningPoint: 1,
        );

        final failure = session.validateFinalization();
        expect(failure, isA<SessionValidationFailure>());
        expect(failure!.missingSessionLocation, isTrue);
      },
    );

    test(
      'missingListeningPoint: census sense listeningPoint → true',
      () {
        final session = buildSession(
          type: SessionType.census,
          location: tLocation,
        );

        final failure = session.validateFinalization();
        expect(failure, isA<SessionValidationFailure>());
        expect(failure!.missingListeningPoint, isTrue);
      },
    );

    test(
      'missingObservationLocationIds: incidental amb obs sense location → conté id',
      () {
        final obsWithoutLocation = buildRecord(id: 'obs-no-loc');
        final obsWithLocation = buildRecord(
          id: 'obs-with-loc',
          location: tLocation,
        );

        final session = buildSession(
          observations: [obsWithoutLocation, obsWithLocation],
        );

        final failure = session.validateFinalization();
        expect(failure, isA<SessionValidationFailure>());
        expect(
          failure!.missingObservationLocationIds,
          contains('obs-no-loc'),
        );
        expect(
          failure.missingObservationLocationIds,
          isNot(contains('obs-with-loc')),
        );
      },
    );

    test('múltiples errors de validació combinats (census)', () {
      final session = buildSession(type: SessionType.census);

      final failure = session.validateFinalization();
      expect(failure, isA<SessionValidationFailure>());
      expect(failure!.missingSessionLocation, isTrue);
      expect(failure.missingListeningPoint, isTrue);
    });
  });

  // ─── Transicions d'estat de sync ──────────────────────────────────────────

  group('Sync state transitions', () {
    test('markAsSyncing estableix syncStatus a syncing', () {
      final result = buildSession(syncStatus: SyncStatus.pending).markAsSyncing();
      expect(result.syncStatus, SyncStatus.syncing);
    });

    test('markAsSynced estableix syncStatus a synced', () {
      final result = buildSession(syncStatus: SyncStatus.syncing).markAsSynced();
      expect(result.syncStatus, SyncStatus.synced);
      expect(result.syncError, isNull);
    });

    test('markBackToPending estableix syncStatus a pending', () {
      final result =
          buildSession(syncStatus: SyncStatus.error).markBackToPending();
      expect(result.syncStatus, SyncStatus.pending);
      expect(result.syncError, isNull);
    });

    test('markAsDeleted estableix isDeleted a true', () {
      final result = buildSession().markAsDeleted();
      expect(result.isDeleted, isTrue);
    });
  });
}
