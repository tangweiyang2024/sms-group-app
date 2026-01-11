import 'package:flutter/material.dart';
import '../models/group_rule.dart';

class RuleCard extends StatelessWidget {
  final GroupRule rule;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RuleCard({
    super.key,
    required this.rule,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(
                    int.parse(rule.color.replaceFirst('#', '0xFF')),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rule.groupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        Chip(
                          label: Text(rule.matchType.displayName),
                          backgroundColor: Colors.blue.withOpacity(0.1),
                          labelStyle: const TextStyle(fontSize: 12),
                        ),
                        Chip(
                          label: Text('${rule.patterns.length} 个规则'),
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          labelStyle: const TextStyle(fontSize: 12),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '优先级 ${rule.priority}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}