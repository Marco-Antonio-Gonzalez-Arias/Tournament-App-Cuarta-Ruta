import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/models/participant_base.dart';

class KnockoutParticipantModel implements ParticipantBase {
  @override
  final String id;
  @override
  final String name;

  KnockoutParticipantModel({String? id, required this.name})
    : id = id ?? const Uuid().v4();

  factory KnockoutParticipantModel.fromJson(Map<String, dynamic> json) =>
      KnockoutParticipantModel(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
