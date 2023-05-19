import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mangaapp/update_record.dart';

class view_data extends StatefulWidget {
  const view_data({super.key});

  @override
  State<view_data> createState() => _view_dataState();
}
 
class _view_dataState extends State<view_data> {

  List mangaData = [];

  Future<void> eliminarManga(BuildContext context, String id) async{

     String uri = "http://192.168.100.246/mangaflutter/service/mangaservice.php?id=${id}";
    
    try{
      var response = await http.delete(Uri.parse(uri));
      var resultado = jsonDecode(response.body);

        if (resultado['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Eliminado con éxito'),

            ),
          );
          obtenerMangas();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar'),
            ),
          );
        }
    }catch(e){
      print(e);
    }
  }

  Future<void> obtenerMangas() async{
    String uri = "http://192.168.100.246/mangaflutter/service/mangaservice.php";
    try{
      var response = await http.get(Uri.parse(uri));

      setState(() {
        mangaData = jsonDecode(response.body);  
      });
      
    }catch(e){
      print(e);
    }

  }

void refreshView() async{
 setState(() { 

  mangaData =[];
  obtenerMangas();

 });

}

  @override
  void initState() {
    obtenerMangas();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Mangas"),
    ),
    body: ListView.builder(
      itemCount: mangaData.length,
      itemBuilder: (context,index){
        return Card(
          margin: EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => update_record(
                mangaData[index]['mangaid'],
                mangaData[index]['manganombre'],
                mangaData[index]['mangatomo']
            ),
        ),
    ).then((result) {
     
         
        if (result) {
            //obtenerMangas();
            refreshView();
           
        }
    });
},
            child: ListTile(
  title: Text(mangaData[index]['manganombre']),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detalles"),
          content: Text("ID:${mangaData[index]['mangaid']}\nNombre: ${mangaData[index]['manganombre']}"+"\nTomo:${mangaData[index]['mangatomo']}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  },
  child: Icon(CupertinoIcons.eye),
),

      SizedBox(width: 16),
      GestureDetector(
        onTap: () {
          eliminarManga(context, mangaData[index]['mangaid']);
        },
        child: Icon(CupertinoIcons.delete_simple),
      ),
    ],
  ),
),

          ),
        );
      },
    ),
  );
}

}