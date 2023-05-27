import 'package:flutter/material.dart';


class CreateExcursionPage extends StatefulWidget {
  const CreateExcursionPage({Key? key}) : super(key: key);

  @override
  _CreateExcursionPageState createState() => _CreateExcursionPageState();
}

class _CreateExcursionPageState extends State<CreateExcursionPage> {
  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  String? _descripcion;
  // ignore: unused_field
  DateTime? _fecha;
  // ignore: unused_field
  double? _precio;
  // ignore: unused_field
  bool _estado = true;
  // ignore: unused_field
  String? _lugar;
  // ignore: unused_field
  int? _cantidad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Excursiones',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle form submission
                }
              },
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Descripción'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa una descripción válida';
                      }
                      if (_containsNumeric(value)) {
                        return 'Por favor, ingresa solo texto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _descripcion = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fecha'),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa una fecha válida';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Parse and save the DateTime value
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Precio'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un precio válido';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, ingresa un número válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _precio = double.tryParse(value!);
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _estado,
                        onChanged: (value) {
                          setState(() {
                            _estado = value!;
                          });
                        },
                      ),
                      Text('Estado'),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lugar'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa un lugar válido';
                      }
                      if (_containsNumeric(value)) {
                        return 'Por favor, ingresa solo texto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _lugar = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresa una cantidad válida';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Por favor, ingresa un número válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _cantidad = int.tryParse(value!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 bool _containsNumeric(String value) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(value);
  }
}