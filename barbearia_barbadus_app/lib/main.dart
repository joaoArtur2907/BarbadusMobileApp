import 'package:barbearia_barbadus_app/Screens/LoginPage.dart';
import 'package:barbearia_barbadus_app/Service/auth_service.dart';
import 'package:barbearia_barbadus_app/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:barbearia_barbadus_app/db/app-database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase().database;
  await AuthService().criarAdminParaTeste();

  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: homePage());
    return MaterialApp(home: LoginPage());
  }
}