import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/censuses/data/models/api/censuses_response_model.dart';

void main() {
  group('CensusesResponseModel.fromJson', () {
    test('parseja censuses i serverTime correctament', () {
      final json = {
        'censuses': [
          {
            'id': 'c1',
            'title': 'Cens nit',
            'date': '2024-06-15',
            'time': '20:00',
            'updatedAt': '2024-06-15T18:00:00.000Z',
          },
        ],
        'serverTime': '2024-06-15T20:00:00.000Z',
      };

      final model = CensusesResponseModel.fromJson(json);

      expect(model.serverTime, '2024-06-15T20:00:00.000Z');
      expect(model.censuses.length, 1);
      expect(model.censuses.first.id, 'c1');
    });

    test('parseja llista buida', () {
      final json = {'censuses': [], 'serverTime': '2024-06-15T20:00:00.000Z'};

      final model = CensusesResponseModel.fromJson(json);

      expect(model.censuses, isEmpty);
    });
  });

  group('CensusRemoteDto.fromJson', () {
    test('parseja tots els camps inclòs isDeleted', () {
      final json = {
        'id': 'c1',
        'title': 'Cens nit',
        'date': '2024-06-15',
        'time': '20:00',
        'updatedAt': '2024-06-15T18:00:00.000Z',
        'latitude': 41.5,
        'longitude': 2.1,
        'locationName': 'Parc Natural',
        'description': 'Descripció',
        'isDeleted': true,
      };

      final dto = CensusRemoteDto.fromJson(json);

      expect(dto.id, 'c1');
      expect(dto.title, 'Cens nit');
      expect(dto.date, '2024-06-15');
      expect(dto.time, '20:00');
      expect(dto.latitude, 41.5);
      expect(dto.longitude, 2.1);
      expect(dto.locationName, 'Parc Natural');
      expect(dto.description, 'Descripció');
      expect(dto.isDeleted, isTrue);
    });

    test('isDeleted és false per defecte si no s\'inclou', () {
      final json = {
        'id': 'c2',
        'title': 'Cens',
        'date': '2024-06-15',
        'time': '21:00',
        'updatedAt': '2024-06-15T18:00:00.000Z',
      };

      final dto = CensusRemoteDto.fromJson(json);

      expect(dto.isDeleted, isFalse);
    });
  });

  group('CensusRemoteDto.toModel', () {
    test('amb coordenades → CensusModel amb GeoPosition', () {
      final dto = CensusRemoteDto(
        id: 'c1',
        title: 'Cens nit',
        date: '2024-06-15',
        time: '20:00',
        updatedAt: '2024-06-15T18:00:00.000Z',
        latitude: 41.5,
        longitude: 2.1,
      );

      final model = dto.toModel();

      expect(model.geoPosition, isNotNull);
      expect(model.geoPosition!.latitude, 41.5);
      expect(model.geoPosition!.longitude, 2.1);
    });

    test('sense coordenades → CensusModel amb geoPosition=null', () {
      final dto = CensusRemoteDto(
        id: 'c1',
        title: 'Cens nit',
        date: '2024-06-15',
        time: '20:00',
        updatedAt: '2024-06-15T18:00:00.000Z',
      );

      final model = dto.toModel();

      expect(model.geoPosition, isNull);
    });

    test('startTime construït correctament de date+time en UTC', () {
      final dto = CensusRemoteDto(
        id: 'c1',
        title: 'Cens',
        date: '2024-06-15',
        time: '20:30',
        updatedAt: '2024-06-15T18:00:00.000Z',
      );

      final model = dto.toModel();

      expect(model.startTime, DateTime.utc(2024, 6, 15, 20, 30));
      expect(model.startTime.isUtc, isTrue);
    });

    test('updatedAt mapejat correctament i isDeleted propagat', () {
      final dto = CensusRemoteDto(
        id: 'c1',
        title: 'Cens',
        date: '2024-06-15',
        time: '20:00',
        updatedAt: '2024-06-15T18:00:00.000Z',
        isDeleted: true,
      );

      final model = dto.toModel();

      expect(model.updatedAt, DateTime.parse('2024-06-15T18:00:00.000Z').toUtc());
      expect(model.isDeleted, isTrue);
    });
  });
}
