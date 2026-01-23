import 'package:uuid/uuid.dart';
import 'package:cuarta_ruta_app/models/match_base.dart';

class MatchModel implements MatchBase {
  @override
  final String id;
  @override
  final String? participantAId;
  @override
  final String? participantBId;
  @override
  final String? winnerId;
  @override
  final bool isCompleted;

  MatchModel({
    String? id,
    this.participantAId,
    this.participantBId,
    this.winnerId,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  MatchModel copyWith({
    String? participantAId,
    String? participantBId,
    String? winnerId,
    bool? isCompleted,
  }) {
    return MatchModel(
      id: id,
      participantAId: participantAId ?? this.participantAId,
      participantBId: participantBId ?? this.participantBId,
      winnerId: winnerId ?? this.winnerId,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json['id'],
    participantAId: json['participantAId'],
    participantBId: json['participantBId'],
    winnerId: json['winnerId'],
    isCompleted: json['isCompleted'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'participantAId': participantAId,
    'participantBId': participantBId,
    'winnerId': winnerId,
    'isCompleted': isCompleted,
  };
}
