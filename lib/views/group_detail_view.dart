import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sms_group.dart';
import '../services/sms_service.dart';
import '../widgets/message_card.dart';

class GroupDetailView extends StatelessWidget {
  final SMSGroup group;

  const GroupDetailView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(group.name),
        backgroundColor: Color(
          int.parse(group.color.replaceFirst('#', '0xFF')),
        ),
      ),
      body: Consumer<SMSService>(
        builder: (context, smsService, child) {
          final messages = smsService.getMessagesForGroup(group.id);

          if (messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '该分组暂无短信',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return MessageCard(message: messages[index]);
            },
          );
        },
      ),
    );
  }
}