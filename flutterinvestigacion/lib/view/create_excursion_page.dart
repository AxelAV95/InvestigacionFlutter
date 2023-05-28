import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class CreateExcursionPage extends StatefulWidget {
  const CreateExcursionPage({Key? key}) : super(key: key);

  @override
  _CreateExcursionPageState createState() => _CreateExcursionPageState();
}

class _CreateExcursionPageState extends State<CreateExcursionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _lugarController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();

  DateTime? _fecha;
  bool _estado = true;

  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    _descripcionController.dispose();
    _precioController.dispose();
    _lugarController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _limpiarCampos() {
    _descripcionController.clear();
    _precioController.clear();
    _lugarController.clear();
    _cantidadController.clear();
    setState(() {
      _fecha = null;
      _estado = true;
    });
  }

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
                  _formKey.currentState!.save();
                  _apiService.insertarExcursion(
                    context,
                    _descripcionController.text,
                    _fecha!,
                    double.parse(_precioController.text),
                    _estado,
                    _lugarController.text,
                    int.parse(_cantidadController.text),
                  );
                  _limpiarCampos();
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
                    controller: _descripcionController,
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
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          _fecha = selectedDate;
                        });
                      }
                    },
                    child: Text(
                      _fecha != null
                          ? 'Fecha: ${_fecha!.toString().substring(0, 10)}'
                          : 'Seleccionar fecha',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _precioController,
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
                    controller: _lugarController,
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
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _cantidadController,
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
