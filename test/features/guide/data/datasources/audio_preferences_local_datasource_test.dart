import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:noctambuls/features/guide/data/datasources/audio_preferences_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late AudioPreferencesLocalDataSourceImpl datasource;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = AudioPreferencesLocalDataSourceImpl(prefs: mockPrefs);
  });

  group('hasAcceptedWarning', () {
    test('key present i true → retorna true', () async {
      when(() => mockPrefs.getBool('audio_warning_accepted')).thenReturn(true);

      expect(await datasource.hasAcceptedWarning(), isTrue);
    });

    test('key absent → retorna false', () async {
      when(() => mockPrefs.getBool('audio_warning_accepted')).thenReturn(null);

      expect(await datasource.hasAcceptedWarning(), isFalse);
    });
  });

  group('setWarningAccepted', () {
    test("crida prefs.setBool('audio_warning_accepted', true)", () async {
      when(
        () => mockPrefs.setBool('audio_warning_accepted', true),
      ).thenAnswer((_) async => true);

      await datasource.setWarningAccepted();

      verify(() => mockPrefs.setBool('audio_warning_accepted', true)).called(1);
    });

    test('setBool retorna false → llença excepció', () async {
      when(
        () => mockPrefs.setBool('audio_warning_accepted', true),
      ).thenAnswer((_) async => false);

      expect(() => datasource.setWarningAccepted(), throwsException);
    });
  });
}
