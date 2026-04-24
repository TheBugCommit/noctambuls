import 'package:drift/drift.dart';
import 'package:noctambuls/core/database/app_database.dart';

class BirdSeeder {
  static const _ducId = 'e2f9a3c1-4b7d-4f8e-9c2b-1d5a6e8b7c9d';
  static const _enganyapastorsId = 'c8a2b1f3-5d9e-4c7a-9b8f-3e1d2c4a5b6d';
  static const _gamarusId = 'f1d2c3b4-a5e6-4f7d-8c9b-0e1a2b3c4d5e';
  static const _mussolBanyutId = 'a7b8c9d0-e1f2-4a3b-8c7d-6e5f4a3b2c1d';
  static const _mussolComuId = 'd4e5f6a7-b8c9-4d0e-1f2a-3b4c5d6e7f8a';
  static const _olibaId = 'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d5e';
  static const _sibocId = 'e8f9a0b1-c2d3-4e4f-5a6b-7c8d9e0f1a2b';
  static const _xotId = 'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e7f';

  static Future<void> seed(AppDatabase db) async {
    await db.transaction(() async {
      await db.batch((b) {
        b
          ..insertAllOnConflictUpdate(db.birdsTable, [
            BirdsTableCompanion.insert(
              id: _ducId,
              scientificName: 'Bubo bubo',
              imagePath: 'assets/images/birds/duc.jpg',
              audioPath: 'assets/audios/Duc (Bubo bubo).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Duc_eurasi%C3%A0tic',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _enganyapastorsId,
              scientificName: 'Caprimulgus europaeus',
              imagePath: 'assets/images/birds/enganyapastors.jpg',
              audioPath:
                  'assets/audios/Enganyapastors (Caprimulgus europaeus).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Enganyapastors_europeu',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _gamarusId,
              scientificName: 'Strix aluco',
              imagePath: 'assets/images/birds/gamarus.jpg',
              audioPath: 'assets/audios/Gamarús (Strix aluco).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Gamar%C3%BAs_eurasi%C3%A0tic',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _mussolBanyutId,
              scientificName: 'Asio otus',
              imagePath: 'assets/images/birds/mussol_banyut.jpg',
              audioPath: 'assets/audios/Mussol Banyut (Asio otus).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Mussol_banyut',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _mussolComuId,
              scientificName: 'Athene noctua',
              imagePath: 'assets/images/birds/mussol_comu.jpg',
              audioPath: 'assets/audios/Mussol comú (Athene noctua).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Mussol_com%C3%BA',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _olibaId,
              scientificName: 'Tyto alba',
              imagePath: 'assets/images/birds/oliba.jpg',
              audioPath: 'assets/audios/Òliba (Tyto alba).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/%C3%92liba_comuna',
              ),
            ),
            BirdsTableCompanion.insert(
              id: _sibocId,
              scientificName: 'Caprimulgus ruficollis',
              imagePath: 'assets/images/birds/siboc.jpg',
              audioPath: 'assets/audios/Siboc (Caprimulgus ruficollis).m4a',
              infoUrl: const Value('https://ca.wikipedia.org/wiki/Siboc'),
            ),
            BirdsTableCompanion.insert(
              id: _xotId,
              scientificName: 'Otus scops',
              imagePath: 'assets/images/birds/xot.jpg',
              audioPath: 'assets/audios/Xot (Otus scops).m4a',
              infoUrl: const Value(
                'https://ca.wikipedia.org/wiki/Xot_eurasi%C3%A0tic',
              ),
            ),
          ])
          ..insertAllOnConflictUpdate(db.birdNamesTable, [
            // Duc
            BirdNamesTableCompanion.insert(
              id: '4f8d29c0-1b5e-4a6c-9f3d-8e7b1a2c5d4e',
              birdId: _ducId,
              languageCode: 'ca',
              commonName: 'Duc',
              description:
                  "El rapinyaire nocturn més gran d'Europa. Destaca pels seus ulls "
                  "taronges i plomes al cap en forma d'orella. És un caçador "
                  "implacable i territorial típic d'hàbitats rocosos i feréstecs.",
            ),
            BirdNamesTableCompanion.insert(
              id: '7a6b5c4d-3e2f-41a0-9b8c-7d6e5f4a3b2c',
              birdId: _ducId,
              languageCode: 'es',
              commonName: 'Búho real',
              description:
                  'La mayor rapaz nocturna de Europa. Destaca por sus ojos '
                  'naranjas y plumas en la cabeza en forma de oreja. Es un '
                  'cazador implacable y territorial típico de hábitats rocosos.',
            ),
            // Enganyapastors
            BirdNamesTableCompanion.insert(
              id: '1d2c3b4a-5e6f-47a8-9b0c-1d2e3f4a5b6c',
              birdId: _enganyapastorsId,
              languageCode: 'ca',
              commonName: 'Enganyapastors',
              description:
                  "Au nocturna d'esvelt vol silenciós i plomatge extremadament "
                  "mimètic. S'alimenta d'insectes al vol i el seu cant nupcial "
                  'és un trinat rítmic, aspre i sostingut molt característic.',
            ),
            BirdNamesTableCompanion.insert(
              id: '9f8e7d6c-5b4a-43f2-1e0d-9c8b7a6f5e4d',
              birdId: _enganyapastorsId,
              languageCode: 'es',
              commonName: 'Chotacabras europeo',
              description:
                  'Ave nocturna de ágil vuelo silencioso y plumaje extremadamente '
                  'mimético. Se alimenta de insectos al vuelo y su canto nupcial '
                  'es un trino rítmico, áspero y sostenido muy característico.',
            ),
            // Gamarús
            BirdNamesTableCompanion.insert(
              id: '2e3f4a5b-6c7d-48e9-0f1a-2b3c4d5e6f7a',
              birdId: _gamarusId,
              languageCode: 'ca',
              commonName: 'Gamarús',
              description:
                  'Mussol forestal de port rabassut i profunds ulls negres. Típic '
                  'de zones boscoses i parcs urbans madurs. El seu cèlebre cant '
                  'ululat és el so clàssic i misteriós de les nits de bosc.',
            ),
            BirdNamesTableCompanion.insert(
              id: '8a9b0c1d-2e3f-44a5-b6c7-d8e9f0a1b2c3',
              birdId: _gamarusId,
              languageCode: 'es',
              commonName: 'Cárabo común',
              description:
                  'Búho forestal de porte rechoncho y profundos ojos negros. Típico '
                  'de zonas boscosas y parques urbanos maduros. Su célebre canto '
                  'ululado es el sonido clásico y misterioso de las noches de bosque.',
            ),
            // Mussol banyut
            BirdNamesTableCompanion.insert(
              id: '3f4a5b6c-7d8e-49f0-1a2b-3c4d5e6f7a8b',
              birdId: _mussolBanyutId,
              languageCode: 'ca',
              commonName: 'Mussol banyut',
              description:
                  'De port esvelt, llueix uns plomalls llargs que erigeix com si '
                  "fossin orelles quan s'alarma. Hiverna en grup i sol utilitzar "
                  'vius abandonats de còrvids per criar en pinedes i boscos.',
            ),
            BirdNamesTableCompanion.insert(
              id: 'c7d8e9f0-a1b2-43c4-d5e6-f7a8b9c0d1e2',
              birdId: _mussolBanyutId,
              languageCode: 'es',
              commonName: 'Búho chico',
              description:
                  'De porte esbelto, luce unos penachos largos que erige como '
                  'orejas cuando se alarma. Inverna en grupo y suele utilizar '
                  'nidos abandonados de córvidos para criar en pinares.',
            ),
            // Mussol comú
            BirdNamesTableCompanion.insert(
              id: '4a5b6c7d-8e9f-40a1-b2c3-d4e5f6a7b8c9',
              birdId: _mussolComuId,
              languageCode: 'ca',
              commonName: 'Mussol comú',
              description:
                  "Rapinyaire petit, arrodonit i d'ulls grocs molt expressius. "
                  'Estretament lligat a ambients agraris tradicionals. És freqüent '
                  "veure'l actiu de dia, vigilant des de pals o teulades.",
            ),
            BirdNamesTableCompanion.insert(
              id: 'd5e6f7a8-b9c0-41d2-e3f4-a5b6c7d8e9f0',
              birdId: _mussolComuId,
              languageCode: 'es',
              commonName: 'Mochuelo europeo',
              description:
                  'Rapaz pequeña, redondeada y de ojos amarillos muy expresivos. '
                  'Estrechamente ligada a ambientes agrarios tradicionales. Es común '
                  'verla activa de día, vigilando desde postes o tejados.',
            ),
            // Òliba
            BirdNamesTableCompanion.insert(
              id: '5b6c7d8e-9f0a-41b2-c3d4-e5f6a7b8c9d0',
              birdId: _olibaId,
              languageCode: 'ca',
              commonName: 'Òliba',
              description:
                  'Inconfusible per la seva màgica cara pàl·lida en forma de cor '
                  'i un vol blanc, fantasmagòric i absolutament silenciós. És '
                  'una gran aliada de la pagesia pel seu control de rosegadors.',
            ),
            BirdNamesTableCompanion.insert(
              id: 'e6f7a8b9-c0d1-42e3-f4a5-b6c7d8e9f0a1',
              birdId: _olibaId,
              languageCode: 'es',
              commonName: 'Lechuza común',
              description:
                  'Inconfundible por su mágica cara pálida en forma de corazón '
                  'y un vuelo blanco, fantasmagórico y absolutamente silencioso. Es '
                  'una gran aliada rural por su eficaz control de roedores.',
            ),
            // Siboc
            BirdNamesTableCompanion.insert(
              id: '6c7d8e9f-0a1b-42c3-d4e5-f6a7b8c9d0e1',
              birdId: _sibocId,
              languageCode: 'ca',
              commonName: 'Siboc',
              description:
                  "Parent proper de l'enganyapastors però més gran i pàl·lid, "
                  'amb un distintiu collar rovellat. És un au estival termòfila '
                  'que prefereix els espais arbustius oberts i de clima càlid.',
            ),
            BirdNamesTableCompanion.insert(
              id: 'f7a8b9c0-d1e2-43f4-a5b6-c7d8e9f0a1b2',
              birdId: _sibocId,
              languageCode: 'es',
              commonName: 'Chotacabras pardo',
              description:
                  'Pariente del chotacabras europeo pero más grande y pálido, '
                  'con un distintivo collar oxidado. Es un ave estival termófila '
                  'que prefiere los espacios arbustivos abiertos y cálidos.',
            ),
            // Xot
            BirdNamesTableCompanion.insert(
              id: '7d8e9f0a-1b2c-43d4-e5f6-a7b8c9d0e1f2',
              birdId: _xotId,
              languageCode: 'ca',
              commonName: 'Xot',
              description:
                  'El nostre rapinyaire nocturn més petit. Visitant estival expert '
                  "en camuflatge entre l'escorça dels arbres. El seu cant és un "
                  "característic asxiulet aflautat i monòton: 'xiu... xiu...'.",
            ),
            BirdNamesTableCompanion.insert(
              id: 'a8b9c0d1-e2f3-44a5-b6c7-d8e9f0a1b2c3',
              birdId: _xotId,
              languageCode: 'es',
              commonName: 'Autillo europeo',
              description:
                  'Nuestra rapaz nocturna más pequeña. Visitante estival experto '
                  'en camuflaje entre la corteza de los árboles. Su canto es un '
                  "característico silbido aflautado y monótono: 'tiu... tiu...'.",
            ),
          ]);
      });
    });
  }
}
