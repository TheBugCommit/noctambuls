import 'package:equatable/equatable.dart';

class InAppNotification extends Equatable {
  const InAppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedAt,
  });

  final String id;
  final String title;
  final String body;
  final DateTime receivedAt;

  @override
  List<Object?> get props => [id, title, body, receivedAt];
}
