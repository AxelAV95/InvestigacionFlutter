import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mangaapp/view_data.dart';

class update_record extends StatefulWidget {
  

  String id;
  String nombre;
  String tomo;
 
 

 update_record(this.id, this.nombre,this.tomo);

  @override
  State<update_record> createState() => _update_recordState();
}

class _update_recordState extends State<update_record> {

  TextEditingController nombre = TextEditingController();
  TextEditingController tomo = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    nombre.text = widget.nombre;
    tomo.text = widget.tomo;
    
  }

  Future<void> actualizarManga(BuildContext context) async{
    try{
        String uri = "http://192.168.100.246/mangaflutter/service/mangaservice.php";

         var data = {
          'id': widget.id,
          'nombre': nombre.text,
          'tomo': tomo.text
        };

        var res = await http.put(Uri.parse(uri), body: json.encode(data));

        var resultado = jsonDecode(res.body);

        if (resultado['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Actualizado con éxito'),

            ),
          );
          nombre.clear();
          tomo.clear();
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al actualizar'),
            ),
          );
        }

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: () async {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => view_data()),
        ModalRoute.withName('/'),
      );
      return false;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("Modificar"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: nombre,
              focusNode: _focusNode,
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
                    actualizarManga(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => view_data()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text('Actualizar'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}