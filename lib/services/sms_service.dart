import 'package:flutter/foundation.dart';
import '../models/sms_message.dart';
import '../models/group_rule.dart';
import '../models/sms_group.dart';
import 'grouping_engine.dart';

class SMSService extends ChangeNotifier {
  List<SMSMessage> _messages = [];
  List<SMSGroup> _groups = [];
  List<GroupRule> _rules = [];
  List<SMSMessage> _ungroupedMessages = [];
  bool _isLoading = false;

  final GroupingEngine _groupingEngine = GroupingEngine();

  List<SMSMessage> get messages => _messages;
  List<SMSGroup> get groups => _groups;
  List<GroupRule> get rules => _rules;
  List<SMSMessage> get ungroupedMessages => _ungroupedMessages;
  bool get isLoading => _isLoading;

  SMSService() {
    _loadDefaultRules();
    loadMessages();
  }

  void _loadDefaultRules() {
    _rules = [
      GroupRule(
        id: '1',
        groupName: '银行通知',
        matchType: MatchType.keyword,
        patterns: ['银行', '账户', '余额', '支出', '收入'],
        priority: 1,
        color: '#F44336',
      ),
      GroupRule(
        id: '2',
        groupName: '快递通知',
        matchType: MatchType.keyword,
        patterns: ['快递', '物流', '取件', '菜鸟'],
        priority: 2,
        color: '#FFC107',
      ),
      GroupRule(
        id: '3',
        groupName: '验证码',
        matchType: MatchType.regex,
        patterns: [r'\d{6}', '验证码'],
        priority: 3,
        color: '#4CAF50',
      ),
      GroupRule(
        id: '4',
        groupName: '运营商',
        matchType: MatchType.sender,
        patterns: ['10086', '10010', '10000'],
        priority: 4,
        color: '#2196F3',
      ),
    ];
    notifyListeners();
  }

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _messages = _generateMockMessages();
    _processGrouping();

    _isLoading = false;
    notifyListeners();
  }

  List<SMSMessage> _generateMockMessages() {
    final now = DateTime.now();
    return [
      SMSMessage(
        id: '1',
        sender: '10086',
        content: '【中国移动】您的余额不足10元，请及时充值',
        date: now,
      ),
      SMSMessage(
        id: '2',
        sender: '10010',
        content: '【中国联通】尊敬的客户，您已成功办理5G套餐',
        date: now.subtract(const Duration(hours: 1)),
      ),
      SMSMessage(
        id: '3',
        sender: '快递通知',
        content: '【顺丰速运】您的快递已到达菜鸟驿站',
        date: now.subtract(const Duration(hours: 2)),
      ),
      SMSMessage(
        id: '4',
        sender: '95588',
        content: '【工商银行】您的账户于1月10日支出1000.00元',
        date: now.subtract(const Duration(days: 1)),
      ),
      SMSMessage(
        id: '5',
        sender: '12306',
        content: '【铁路客服】您购买的G1234次列车已发车',
        date: now.subtract(const Duration(days: 2)),
      ),
      SMSMessage(
        id: '6',
        sender: '外卖',
        content: '【美团】您的外卖已送达，请及时取餐',
        date: now.subtract(const Duration(days: 3)),
      ),
      SMSMessage(
        id: '7',
        sender: '验证码',
        content: '【阿里云】您的验证码是123456，10分钟内有效',
        date: now.subtract(const Duration(days: 4)),
      ),
    ];
  }

  void _processGrouping() {
    final Map<String, List<SMSMessage>> groupedMessages = {};
    final Set<String> groupedIds = {};

    for (final message in _messages) {
      final groupId = _groupingEngine.processMessage(message, _rules);
      if (groupId != null) {
        groupedMessages.putIfAbsent(groupId, () => []).add(message);
        groupedIds.add(message.id);
      }
    }

    _ungroupedMessages = _messages.where((msg) => !groupedIds.contains(msg.id)).toList();

    _groups = _rules.map((rule) {
      final groupMessages = groupedMessages[rule.id] ?? [];
      return SMSGroup(
        id: rule.id,
        name: rule.groupName,
        messageIds: groupMessages.map((m) => m.id).toList(),
        ruleId: rule.id,
        color: rule.color,
        messageCount: groupMessages.length,
      );
    }).where((group) => group.messageCount > 0).toList();
  }

  void addRule(GroupRule rule) {
    _rules.add(rule);
    _processGrouping();
    notifyListeners();
  }

  void updateRule(GroupRule rule) {
    final index = _rules.indexWhere((r) => r.id == rule.id);
    if (index != -1) {
      _rules[index] = rule;
      _processGrouping();
      notifyListeners();
    }
  }

  void deleteRule(String ruleId) {
    _rules.removeWhere((rule) => rule.id == ruleId);
    _processGrouping();
    notifyListeners();
  }

  void refreshMessages() {
    loadMessages();
  }

  List<SMSMessage> getMessagesForGroup(String groupId) {
    return _messages.where((msg) => _groups
      .firstWhere((group) => group.id == groupId)
      .messageIds.contains(msg.id)
    ).toList();
  }

  SMSMessage? getMessageById(String messageId) {
    try {
      return _messages.firstWhere((msg) => msg.id == messageId);
    } catch (e) {
      return null;
    }
  }
}