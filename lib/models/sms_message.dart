import 'dart:convert';

class SMSMessage {
  final String id;
  final String sender;
  final String content;
  final DateTime date;
  final String? groupId;

  SMSMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.date,
    this.groupId,
  });

  factory SMSMessage.fromJson(Map<String, dynamic> json) {
    return SMSMessage(
      id: json['id'] as String,
      sender: json['sender'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      groupId: json['groupId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'content': content,
      'date': date.toIso8601String(),
      'groupId': groupId,
    };
  }

  SMSMessage copyWith({
    String? id,
    String? sender,
    String? content,
    DateTime? date,
    String? groupId,
  }) {
    return SMSMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      content: content ?? this.content,
      date: date ?? this.date,
      groupId: groupId ?? this.groupId,
    );
  }
}