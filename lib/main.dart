import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/main_tab_view.dart';
import 'services/sms_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SMSService()),
        ChangeNotifierProvider(create: (_) => StorageService.instance),
      ],
      child: MaterialApp(
        title: '短信分组',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainTabView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}