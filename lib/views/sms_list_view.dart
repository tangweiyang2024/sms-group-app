import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/sms_service.dart';
import '../widgets/message_card.dart';

class SMSListView extends StatelessWidget {
  const SMSListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('短信列表'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<SMSService>().refreshMessages();
            },
          ),
        ],
      ),
      body: Consumer<SMSService>(
        builder: (context, smsService, child) {
          if (smsService.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              smsService.refreshMessages();
            },
            child: ListView(
              children: [
                if (smsService.ungroupedMessages.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '未分组短信',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ...smsService.ungroupedMessages.map((message) {
                  return MessageCard(message: message);
                }),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '所有短信 (${smsService.messages.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...smsService.messages.map((message) {
                  return MessageCard(message: message);
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}