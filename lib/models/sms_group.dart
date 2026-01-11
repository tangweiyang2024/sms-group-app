import 'dart:convert';

class SMSGroup {
  final String id;
  final String name;
  final List<String> messageIds;
  final String ruleId;
  final String color;
  final int messageCount;

  SMSGroup({
    required this.id,
    required this.name,
    required this.messageIds,
    required this.ruleId,
    required this.color,
    this.messageCount = 0,
  });

  factory SMSGroup.fromJson(Map<String, dynamic> json) {
    return SMSGroup(
      id: json['id'] as String,
      name: json['name'] as String,
      messageIds: List<String>.from(json['messageIds'] as List),
      ruleId: json['ruleId'] as String,
      color: json['color'] as String,
      messageCount: json['messageCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'messageIds': messageIds,
      'ruleId': ruleId,
      'color': color,
      'messageCount': messageCount,
    };
  }

  SMSGroup copyWith({
    String? id,
    String? name,
    List<String>? messageIds,
    String? ruleId,
    String? color,
    int? messageCount,
  }) {
    return SMSGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      messageIds: messageIds ?? this.messageIds,
      ruleId: ruleId ?? this.ruleId,
      color: color ?? this.color,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}