import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../domain/excursion.dart';

import '../services/api_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Excursion> excursionesData = [];

  ApiService apiService = ApiService();

  

  

  @override
  void initState() {
    super.initState();
    apiService.onExcursionDeleted = refreshView; 
    apiService.obtenerExcursiones().then((data) {
      setState(() {
        excursionesData = data;
        print(excursionesData.length);
      });
    });
  }

  void refreshView() async {

    setState(() {
    excursionesData = []; 
    });
    setState(() {
      
      apiService.obtenerExcursiones().then((data) {
        setState(() {
          excursionesData = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Excursiones"),
      ),
      body: ListView.builder(
        itemCount: excursionesData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                // Handle onTap event
              },
              child: ListTile(
                title: Text(excursionesData[index].descripcion),
                subtitle: Text(excursionesData[index].lugar),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/Ver',
                          arguments: excursionesData[
                              index], // Pass the Excursion object as arguments
                        );
                      },
                      child: Icon(CupertinoIcons.eye),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        // Handle delete icon tap
                        apiService.eliminarExcursion(context, excursionesData[
                              index].id);
                              refreshView(); 
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/Agregar');
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
