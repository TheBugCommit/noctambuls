import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/censuses/data/models/census_model.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';

void main() {
  final tNow = DateTime(2024, 6, 15, 20, 0).toUtc();

  final tCensus = Census(
    id: 'c1',
    title: 'Cens nit',
    startTime: tNow,
    createdAt: tNow,
    updatedAt: tNow,
    locationName: 'Parc Natural',
    description: 'Descripció del cens',
    isJoined: true,
    alreadyDone: false,
  );

  group('CensusModel.fromEntity', () {
    test('mapeja tots els camps correctament, isDeleted=false per defecte', () {
      final model = CensusModel.fromEntity(tCensus);

      expect(model.id, tCensus.id);
      expect(model.title, tCensus.title);
      expect(model.startTime, tCensus.startTime);
      expect(model.createdAt, tCensus.createdAt);
      expect(model.updatedAt, tCensus.updatedAt);
      expect(model.locationName, tCensus.locationName);
      expect(model.description, tCensus.description);
      expect(model.isJoined, tCensus.isJoined);
      expect(model.alreadyDone, tCensus.alreadyDone);
      expect(model.isDeleted, isFalse);
    });
  });

  group('CensusModel.toDomain', () {
    test('genera Census amb tots els camps; isDeleted s\'ignora', () {
      final model = CensusModel(
        id: 'c1',
        title: 'Cens nit',
        startTime: tNow,
        createdAt: tNow,
        updatedAt: tNow,
        locationName: 'Parc Natural',
        description: 'Descripció del cens',
        isJoined: true,
        alreadyDone: false,
        isDeleted: true, // ha de ser ignorat
      );

      final domain = model.toDomain();

      expect(domain.id, model.id);
      expect(domain.title, model.title);
      expect(domain.startTime, model.startTime.toUtc());
      expect(domain.createdAt, model.createdAt.toUtc());
      expect(domain.updatedAt, model.updatedAt.toUtc());
      expect(domain.locationName, model.locationName);
      expect(domain.description, model.description);
      expect(domain.isJoined, model.isJoined);
      expect(domain.alreadyDone, model.alreadyDone);
    });

    test('roundtrip fromEntity → toDomain preserva les dades', () {
      final model = CensusModel.fromEntity(tCensus);
      final domain = model.toDomain();

      expect(domain.id, tCensus.id);
      expect(domain.title, tCensus.title);
      expect(domain.isJoined, tCensus.isJoined);
    });
  });
}
