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

  Bird copyWith({
    String? id,
    String? commonName,
    String? scientificName,
    String? description,
    String? imageUrl,
    String? audioUrl,
    String? infoUrl,
    String? localAudioPath,
    String? localImagePath,
  }) {
    return Bird(
      id: id ?? this.id,
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      infoUrl: infoUrl ?? this.infoUrl,
      localAudioPath: localAudioPath ?? this.localAudioPath,
      localImagePath: localImagePath ?? this.localImagePath,
    );
  }

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
