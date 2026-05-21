import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';

void main() {
  final tToday = DateTime.now().toUtc();

  Census makeCensus({DateTime? startTime, bool isJoined = false, bool alreadyDone = false}) {
    return Census(
      id: 'c1',
      title: 'Cens de prova',
      startTime: startTime ?? tToday,
      createdAt: tToday,
      updatedAt: tToday,
      isJoined: isJoined,
      alreadyDone: alreadyDone,
    );
  }

  group('isTodaysCensus', () {
    test('startTime és avui (UTC) → true', () {
      final census = makeCensus(startTime: tToday);
      expect(census.isTodaysCensus, isTrue);
    });

    test('startTime és ahir → false', () {
      final yesterday = tToday.subtract(const Duration(days: 1));
      final census = makeCensus(startTime: yesterday);
      expect(census.isTodaysCensus, isFalse);
    });

    test('startTime és demà → false', () {
      final tomorrow = tToday.add(const Duration(days: 1));
      final census = makeCensus(startTime: tomorrow);
      expect(census.isTodaysCensus, isFalse);
    });
  });

  group('join', () {
    test('retorna cens amb isJoined=true, resta de camps preservats', () {
      final census = makeCensus();
      final joined = census.join();

      expect(joined.isJoined, isTrue);
      expect(joined.id, census.id);
      expect(joined.title, census.title);
      expect(joined.startTime, census.startTime);
      expect(joined.alreadyDone, census.alreadyDone);
    });
  });

  group('abandon', () {
    test('retorna cens amb isJoined=false', () {
      final census = makeCensus(isJoined: true);
      final abandoned = census.abandon();

      expect(abandoned.isJoined, isFalse);
      expect(abandoned.id, census.id);
    });
  });

  group('markAsDone', () {
    test('retorna cens amb alreadyDone=true', () {
      final census = makeCensus();
      final done = census.markAsDone();

      expect(done.alreadyDone, isTrue);
      expect(done.id, census.id);
    });
  });

  group('Equatable', () {
    test('mateixos valors → iguals', () {
      final a = Census(
        id: 'c1',
        title: 'Cens',
        startTime: tToday,
        createdAt: tToday,
        updatedAt: tToday,
      );
      final b = Census(
        id: 'c1',
        title: 'Cens',
        startTime: tToday,
        createdAt: tToday,
        updatedAt: tToday,
      );
      expect(a, equals(b));
    });

    test('id diferent → no iguals', () {
      final a = makeCensus();
      final b = Census(
        id: 'other-id',
        title: a.title,
        startTime: a.startTime,
        createdAt: a.createdAt,
        updatedAt: a.updatedAt,
      );
      expect(a, isNot(equals(b)));
    });
  });
}
