import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/sms_service.dart';
import '../widgets/group_card.dart';
import 'group_detail_view.dart';

class GroupedSMSView extends StatelessWidget {
  const GroupedSMSView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分组短信'),
      ),
      body: Consumer<SMSService>(
        builder: (context, smsService, child) {
          if (smsService.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (smsService.groups.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_off,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '暂无分组',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '请在规则设置中创建分组规则',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: smsService.groups.length,
            itemBuilder: (context, index) {
              final group = smsService.groups[index];
              return GroupCard(
                group: group,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupDetailView(group: group),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}