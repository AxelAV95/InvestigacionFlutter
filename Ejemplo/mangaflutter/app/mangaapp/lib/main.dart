import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mangaapp/drop_view.dart';
import 'package:mangaapp/view_data.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Insertar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nombre = TextEditingController();
  TextEditingController tomo = TextEditingController();
  final _focusNode = FocusNode();

  Future<void> insertarManga(BuildContext context) async {
    if (nombre.text == "" || tomo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Llene los campos'),
        ),
      );
      _focusNode.requestFocus();
    } else {
      try {
        String uri = "http://192.168.100.246/mangaflutter/service/mangaservice.php";

        var data = {
          'metodo': 'insertar',
          'nombre': nombre.text,
          'tomo': tomo.text
        };

        var res = await http.post(Uri.parse(uri), body: json.encode(data));

        var resultado = jsonDecode(res.body);

        if (resultado['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Agregado con éxito'),

            ),
          );
          nombre.clear();
          tomo.clear();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al agregar'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: nombre,
               //focusNode: _focusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ingrese el nombre",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: tomo,
              // focusNode: _focusNode,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Ingrese el tomo",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add your button function here
                    insertarManga(context);
                  },
                  child: const Text('Insertar'),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Builder(builder: (context){
              return ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => view_data()));
              }, child: Text("Ver mangas"));
            },)
          ),
        ],
      ),
    );
  }
}


