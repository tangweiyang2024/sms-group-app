import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/group_rule.dart';
import '../services/sms_service.dart';
import '../services/grouping_engine.dart';

class RuleEditorView extends StatefulWidget {
  final GroupRule? rule;

  const RuleEditorView({super.key, this.rule});

  @override
  State<RuleEditorView> createState() => _RuleEditorViewState();
}

class _RuleEditorViewState extends State<RuleEditorView> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final _patternController = TextEditingController();
  final _testTextController = TextEditingController();

  List<String> _patterns = [];
  MatchType _selectedMatchType = MatchType.keyword;
  String _selectedColor = '#2196F3';
  int _priority = 0;
  bool? _testResult;

  final List<String> _colors = [
    '#2196F3', // Blue
    '#F44336', // Red
    '#FFC107', // Amber
    '#4CAF50', // Green
    '#9C27B0', // Purple
    '#FF9800', // Orange
    '#795548', // Brown
    '#607D8B', // Blue Grey
  ];

  @override
  void initState() {
    super.initState();
    if (widget.rule != null) {
      _loadRule(widget.rule!);
    }
  }

  void _loadRule(GroupRule rule) {
    _groupNameController.text = rule.groupName;
    _patterns = List.from(rule.patterns);
    _selectedMatchType = rule.matchType;
    _selectedColor = rule.color;
    _priority = rule.priority;
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _patternController.dispose();
    _testTextController.dispose();
    super.dispose();
  }

  void _addPattern() {
    if (_patternController.text.trim().isNotEmpty) {
      setState(() {
        _patterns.add(_patternController.text.trim());
        _patternController.clear();
      });
    }
  }

  void _removePattern(int index) {
    setState(() {
      _patterns.removeAt(index);
    });
  }

  void _testRule() {
    if (_groupNameController.text.trim().isEmpty || _patterns.isEmpty) {
      return;
    }

    final testRule = GroupRule(
      id: 'test',
      groupName: _groupNameController.text.trim(),
      matchType: _selectedMatchType,
      patterns: _patterns,
      priority: _priority,
      color: _selectedColor,
    );

    final result = GroupingEngine.instance.testRule(testRule, _testTextController.text);
    setState(() {
      _testResult = result;
    });
  }

  void _saveRule() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final rule = GroupRule(
      id: widget.rule?.id ?? const Uuid().v4(),
      groupName: _groupNameController.text.trim(),
      matchType: _selectedMatchType,
      patterns: _patterns,
      priority: _priority,
      color: _selectedColor,
    );

    if (widget.rule != null) {
      context.read<SMSService>().updateRule(rule);
    } else {
      context.read<SMSService>().addRule(rule);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rule == null ? '新建规则' : '编辑规则'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _isFormValid() ? _saveRule : null,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: '分组名称',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入分组名称';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<MatchType>(
              value: _selectedMatchType,
              decoration: const InputDecoration(
                labelText: '匹配类型',
                border: OutlineInputBorder(),
              ),
              items: MatchType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMatchType = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<int>(
              value: _priority,
              decoration: const InputDecoration(
                labelText: '优先级',
                border: OutlineInputBorder(),
              ),
              items: List.generate(10, (index) {
                return DropdownMenuItem(
                  value: index,
                  child: Text('$index'),
                );
              }),
              onChanged: (value) {
                setState(() {
                  _priority = value!;
                });
              },
            ),
            const SizedBox(height: 24),

            const Text(
              '规则模式',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _patternController,
                    decoration: const InputDecoration(
                      hintText: '输入模式',
                      border: OutlineInputBorder(),
                    ),
                    onFieldSubmitted: (_) => _addPattern(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _addPattern,
                ),
              ],
            ),
            const SizedBox(height: 8),

            if (_patterns.isEmpty)
              const Text(
                '暂无规则模式',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...List.generate(_patterns.length, (index) {
                return Card(
                  child: ListTile(
                    title: Text(_patterns[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => _removePattern(index),
                    ),
                  ),
                );
              }),
            const SizedBox(height: 24),

            const Text(
              '颜色标识',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(int.parse(color.replaceFirst('#', '0xFF'))),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == color
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            const Text(
              '规则测试',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _testTextController,
              decoration: const InputDecoration(
                hintText: '输入测试文本',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),

            if (_testResult != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _testResult!
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _testResult! ? Colors.green : Colors.red,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _testResult! ? Icons.check_circle : Icons.cancel,
                      color: _testResult! ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _testResult! ? '匹配成功' : '匹配失败',
                      style: TextStyle(
                        color: _testResult! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: _testTextController.text.trim().isNotEmpty
                  ? _testRule
                  : null,
              child: const Text('测试规则'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _groupNameController.text.trim().isNotEmpty && _patterns.isNotEmpty;
  }
}