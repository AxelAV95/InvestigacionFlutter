import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterinvestigacion/utils/utils.dart';

import 'package:http/http.dart' as http;

import '../domain/excursion.dart';
import 'package:intl/intl.dart';

class ApiService {
    Function()? onExcursionDeleted; // Define a callback function
    


  //Obtener excursiones
  Future<List<Excursion>> obtenerExcursiones() async {
    List<Excursion> excursionesData = [];
    try {
      var response = await http.get(Uri.parse("$apiUrl?metodo=obtener"));
      //print(response.body);

      List<dynamic> excursionJsonList = jsonDecode(response.body);
      excursionesData = excursionJsonList.map((excursionJson) {
        return Excursion(
          id: int.parse(excursionJson['excursionid']),
          descripcion: excursionJson['excursiondescripcion'],
          fecha: DateTime.parse(excursionJson['excursionfecha']),
          precio: double.parse(excursionJson['excursionprecio']),
          estado: int.parse(excursionJson['excursionestado']),
          lugar: excursionJson['excursionlugar'],
          cantidad: int.parse(excursionJson['excursioncapacidad']),
        );
      }).toList();
    } catch (e) {
      print(e);
    }
    return excursionesData;
  }
Future<void> insertarExcursion(
  BuildContext context,
  String descripcion,
  DateTime fecha,
  double precio,
  bool estado,
  String lugar,
  int cantidad,
) async {

      String fechaFormateada = DateFormat('yyyy-MM-dd').format(fecha);
 print('descripcion : $descripcion');
print('Fecha formateada: $fechaFormateada');
 print('precio : $precio');
print('estado : $estado');
 print('lugar : $lugar');
print('cantidad : $cantidad');

  try {
     var data = {
  'metodo': 'insertar',
  'descripcion': descripcion,
  'fecha': fechaFormateada,
  'precio': precio.toString(),
  'estado': estado.toString(),
  'lugar': lugar,
  'cantidad': cantidad.toString(),
};
  //  var res = await http.post(Uri.parse(uri), body: json.encode(data));

  //       var resultado = jsonDecode(res.body);



   var res = await http.post(Uri.parse(apiUrl), body:json.encode(data));

    var resultado = jsonDecode(res.body);

    if (resultado['statusCode'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Agregado con éxito'),
        ),
      );
      // Limpiar los campos después de agregar
      descripcion = '';
      precio = 0.0;
      estado = false;
      lugar = '';
      cantidad = 0;
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

  //Eliminar excursión
  Future<void> eliminarExcursion(BuildContext context, int id) async{

   // print("$apiUrl?id=${id}");
    try{
      var response = await http.delete(Uri.parse("$apiUrl?id=${id}"));
    //  print(response.body);
      var resultado = jsonDecode(response.body);

        if (resultado['statusCode'] == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(resultado['message']),

            ),
          );

          if (onExcursionDeleted != null) {
            onExcursionDeleted!(); // Call the callback function
        }  
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
  

}
