import 'package:flutter/material.dart';
import 'package:flutterinvestigacion/view/home_page.dart';
import 'package:flutterinvestigacion/view/create_excursion_page.dart';
import 'package:flutterinvestigacion/view/ver_excursiones_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excursiones App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 150)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Excursiones App'),
      routes: {
        '/Agregar': (context) => CreateExcursionPage(),
        '/Ver': (context) => VerExcursionesPage(),
      },
    );
  }
}