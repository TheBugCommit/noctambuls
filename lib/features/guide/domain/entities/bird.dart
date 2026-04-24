import 'package:equatable/equatable.dart';

class Bird extends Equatable {
  const Bird({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.description,
    required this.imagePath,
    required this.audioPath,
    required this.infoUrl,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final String description;
  final String imagePath;
  final String audioPath;
  final String infoUrl;

  @override
  List<Object?> get props => [
    id,
    commonName,
    scientificName,
    description,
    imagePath,
    audioPath,
    infoUrl,
  ];
}
