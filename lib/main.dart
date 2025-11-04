import 'package:flutter/material.dart';
import 'package:saude_verde/pages/home_page.dart';
import 'package:saude_verde/widgets/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saúde Verde',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(), // Aqui a SplashScreen será a inicial
      routes: {
        '/home': (context) => HomePage(), // Defina a rota para a HomePage
      },
    );
  }
}
//Gerar Apk
//flutter build apk --release
