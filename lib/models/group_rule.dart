import 'dart:convert';

enum MatchType {
  keyword('关键字'),
  regex('正则表达式'),
  sender('发件人');

  final String displayName;
  const MatchType(this.displayName);

  static MatchType fromString(String value) {
    return MatchType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => MatchType.keyword,
    );
  }
}

class GroupRule {
  final String id;
  final String groupName;
  final MatchType matchType;
  final List<String> patterns;
  final int priority;
  final bool isEnabled;
  final String color;

  GroupRule({
    required this.id,
    required this.groupName,
    required this.matchType,
    required this.patterns,
    this.priority = 0,
    this.isEnabled = true,
    this.color = '#2196F3',
  });

  factory GroupRule.fromJson(Map<String, dynamic> json) {
    return GroupRule(
      id: json['id'] as String,
      groupName: json['groupName'] as String,
      matchType: MatchType.fromString(json['matchType'] as String? ?? 'keyword'),
      patterns: List<String>.from(json['patterns'] as List),
      priority: json['priority'] as int? ?? 0,
      isEnabled: json['isEnabled'] as bool? ?? true,
      color: json['color'] as String? ?? '#2196F3',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'groupName': groupName,
      'matchType': matchType.name,
      'patterns': patterns,
      'priority': priority,
      'isEnabled': isEnabled,
      'color': color,
    };
  }

  GroupRule copyWith({
    String? id,
    String? groupName,
    MatchType? matchType,
    List<String>? patterns,
    int? priority,
    bool? isEnabled,
    String? color,
  }) {
    return GroupRule(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      matchType: matchType ?? this.matchType,
      patterns: patterns ?? this.patterns,
      priority: priority ?? this.priority,
      isEnabled: isEnabled ?? this.isEnabled,
      color: color ?? this.color,
    );
  }
}