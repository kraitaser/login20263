import 'package:flutter/material.dart';
import 'package:login20263/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (context) => AuthService()),
      ],
      child: const MyApp()
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login demo',
      theme: ThemeData(
        colorScheme:ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 163, 39, 240)),
        useMaterial3: true
      )
    );
  }
}