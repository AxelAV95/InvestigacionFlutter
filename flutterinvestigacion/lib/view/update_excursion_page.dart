import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../domain/excursion.dart';
import 'home_page.dart';

class ActualizarExcursionView extends StatefulWidget {
  final Excursion excursion;

  ActualizarExcursionView({required this.excursion});

  @override
  _ActualizarExcursionViewState createState() => _ActualizarExcursionViewState();
}

class _ActualizarExcursionViewState extends State<ActualizarExcursionView> {
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _estadoController = TextEditingController();
  TextEditingController _lugarController = TextEditingController();
  TextEditingController _cantidadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descripcionController.text = widget.excursion.descripcion;
    _fechaController.text =
        '${widget.excursion.fecha.day.toString().padLeft(2, '0')}/${widget.excursion.fecha.month.toString().padLeft(2, '0')}/${widget.excursion.fecha.year}';
    _precioController.text = widget.excursion.precio.toString();
    _estadoController.text = widget.excursion.estado.toString();
    _lugarController.text = widget.excursion.lugar;
    _cantidadController.text = widget.excursion.cantidad.toString();
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
                final String nuevaDescripcion = _descripcionController.text;
                final String nuevaFecha = _fechaController.text;
                final double nuevoPrecio = double.parse(_precioController.text);
                final int nuevoEstado = int.parse(_estadoController.text);
                final String nuevoLugar = _lugarController.text;
                final int nuevaCantidad = int.parse(_cantidadController.text);

                Excursion excursionActualizada = Excursion(
                  id: widget.excursion.id,
                  descripcion: nuevaDescripcion,
                  fecha: DateTime.parse(nuevaFecha),
                  precio: nuevoPrecio,
                  estado: nuevoEstado,
                  lugar: nuevoLugar,
                  cantidad: nuevaCantidad,
                );

                Navigator.pop(context, excursionActualizada);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
