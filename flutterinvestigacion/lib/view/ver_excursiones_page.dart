import 'package:flutter/material.dart';
import '../domain/excursion.dart';


class VerExcursionesPage extends StatelessWidget {
  const VerExcursionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

     // Retrieve the Excursion object passed from the previous screen
    final Excursion excursionDetalles = ModalRoute.of(context)!.settings.arguments as Excursion;
   // print(excursion.descripcion);
    // Datos de ejemplo para las excursiones
    List<Excursion> excursiones = [
      Excursion(
        id : 0,
        descripcion: 'Excursión 1',
        fecha: DateTime.now(),
        precio: 100,
        estado: 0,
        lugar: 'Lugar 1',
        cantidad: 5,
      ),
      // Agrega más objetos Excursion si es necesario
    ];

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(8),
          color: Colors.yellow[100],
          child: Text(
            'Detalles de la Excursión',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: excursiones.length,
              itemBuilder: (context, index) {
                final excursion = excursionDetalles;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        excursion.descripcion,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fecha: ${excursion.fecha.day.toString().padLeft(2, '0')}/${excursion.fecha.month.toString().padLeft(2, '0')}/${excursion.fecha.year}',
                          ),
                          Text(
                            'Precio: \$${excursion.precio.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Estado: ${excursion.estado}',
                          ),
                          Text(
                            'Lugar: ${excursion.lugar}',
                          ),
                          Text(
                            'Cantidad: ${excursion.cantidad}',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Acción para el botón "Actualizar"
                },
                child: Text('Actualizar'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Regresar'),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
