import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterinvestigacion/utils/utils.dart';

import 'package:http/http.dart' as http;

import '../domain/excursion.dart';

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
