import 'package:equatable/equatable.dart';

class Bird extends Equatable {
  const Bird({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.infoUrl,
    this.localAudioPath,
    this.localImagePath,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final String description;
  final String imageUrl;
  final String audioUrl;
  final String infoUrl;
  final String? localAudioPath;
  final String? localImagePath;

  bool get hasLocalImage => localImagePath != null;

  bool get hasLocalAudio => localAudioPath != null;

  @override
  List<Object?> get props => [
    id,
    commonName,
    scientificName,
    description,
    imageUrl,
    audioUrl,
    infoUrl,
    localImagePath,
    localAudioPath,
  ];
}
