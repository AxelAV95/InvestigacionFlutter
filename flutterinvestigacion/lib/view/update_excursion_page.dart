import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../domain/excursion.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutterinvestigacion/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ActualizarExcursionView extends StatefulWidget {
  final Excursion excursion;

  ActualizarExcursionView({required this.excursion});

  @override
  _ActualizarExcursionViewState createState() => _ActualizarExcursionViewState();
}

class _ActualizarExcursionViewState extends State<ActualizarExcursionView> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _lugarController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _idController.text = widget.excursion.id.toString();
    _descripcionController.text = widget.excursion.descripcion;
    _fechaController.text =
        '${widget.excursion.fecha.day.toString().padLeft(2, '0')}/${widget.excursion.fecha.month.toString().padLeft(2, '0')}/${widget.excursion.fecha.year}';
    _precioController.text = widget.excursion.precio.toString();
    _estadoController.text = widget.excursion.estado.toString();
    _lugarController.text = widget.excursion.lugar;
    _cantidadController.text = widget.excursion.cantidad.toString();
  }

  Future<void> modificarExcursion() async {
    try {
      final int idExcursion = int.parse(_idController.text);
      final String nuevaDescripcion = _descripcionController.text;
      final DateTime nuevaFecha =
          DateFormat('dd/MM/yyyy').parse(_fechaController.text);
      final double nuevoPrecio = double.parse(_precioController.text);
      final int nuevoEstado = int.parse(_estadoController.text);
      final String nuevoLugar = _lugarController.text;
      final int nuevaCantidad = int.parse(_cantidadController.text);

      var data = {
        'id': idExcursion.toString(),
        'descripcion': nuevaDescripcion,
        'fecha': nuevaFecha.toString(),
        'precio': nuevoPrecio.toString(),
        'estado': nuevoEstado.toString(),
        'lugar': nuevoLugar,
        'cantidad': nuevaCantidad.toString(),
      };

      var res = await http.put(Uri.parse(apiUrl), body: json.encode(data));
      var resultado = jsonDecode(res.body);

      if (resultado['statusCode'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Actualizado con éxito'),
          ),
        );
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar'),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Excursión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
              ),
            ),
            TextField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha',
              ),
            ),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(
                labelText: 'Precio',
              ),
            ),
            TextField(
              controller: _estadoController,
              decoration: InputDecoration(
                labelText: 'Estado',
              ),
            ),
            TextField(
              controller: _lugarController,
              decoration: InputDecoration(
                labelText: 'Lugar',
              ),
            ),
            TextField(
              controller: _cantidadController,
              decoration: InputDecoration(
                labelText: 'Cantidad',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                modificarExcursion(); // Llamada al método modificarExcursion
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Excursion App'),
                  ),
                  ModalRoute.withName('/'),
                );
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
