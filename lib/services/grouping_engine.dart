import 'dart:core';
import '../models/sms_message.dart';
import '../models/group_rule.dart';

class GroupingEngine {
  static const GroupingEngine instance = GroupingEngine._internal();
  factory GroupingEngine() => instance;
  GroupingEngine._internal();

  String? processMessage(SMSMessage message, List<GroupRule> rules) {
    final enabledRules = rules
        .where((rule) => rule.isEnabled)
        .toList()
      ..sort((a, b) => a.priority.compareTo(b.priority));

    for (final rule in enabledRules) {
      if (_matchesRule(message, rule)) {
        return rule.id;
      }
    }
    return null;
  }

  bool _matchesRule(SMSMessage message, GroupRule rule) {
    switch (rule.matchType) {
      case MatchType.keyword:
        return rule.patterns.any((pattern) =>
          message.content.contains(pattern) ||
          message.sender.contains(pattern)
        );

      case MatchType.regex:
        return rule.patterns.any((pattern) {
          try {
            final regex = RegExp(pattern);
            return regex.hasMatch(message.content) ||
                   regex.hasMatch(message.sender);
          } catch (e) {
            return false;
          }
        });

      case MatchType.sender:
        return rule.patterns.contains(message.sender);
    }
  }

  bool testRule(GroupRule rule, String testText) {
    final testMessage = SMSMessage(
      id: 'test',
      sender: '测试',
      content: testText,
      date: DateTime.now(),
    );
    return _matchesRule(testMessage, rule);
  }

  void processMessages(
    List<SMSMessage> messages,
    List<GroupRule> rules,
    Map<String, List<SMSMessage>> groupedMessages,
  ) {
    groupedMessages.clear();
    
    for (final message in messages) {
      final groupId = processMessage(message, rules);
      if (groupId != null) {
        groupedMessages.putIfAbsent(groupId, () => []).add(message);
      }
    }
  }
}