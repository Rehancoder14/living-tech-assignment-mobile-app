import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:livingtechassignment/screens/auth/provider/auth_provider.dart';
import 'package:livingtechassignment/screens/auth/view/login_screen.dart';
import 'package:livingtechassignment/screens/dashboard/view/dashboard.dart';
import 'package:livingtechassignment/services/api_service.dart';
import 'package:livingtechassignment/services/local_storage_service.dart';
import 'package:livingtechassignment/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  await Hive.openBox(kUserDataBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiService>(
          create: (context) => ApiService(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.rootScaffoldMessengerKey,
        title: 'Living tech assignment',
        home: _navigate(),
      ),
    );
  }

  Widget _navigate() {
    return LocalStorageService.getUserValue(UserField.token) == null
        ? LoginPage()
        : const DashboardScreen();
  }
}
