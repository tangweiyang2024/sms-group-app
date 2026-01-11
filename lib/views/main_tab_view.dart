import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sms_list_view.dart';
import 'grouped_sms_view.dart';
import 'rule_list_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    SMSListView(),
    GroupedSMSView(),
    RuleListView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '短信',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: '分组',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '规则',
          ),
        ],
      ),
    );
  }
}