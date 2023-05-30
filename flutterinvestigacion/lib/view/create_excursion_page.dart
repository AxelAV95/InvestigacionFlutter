import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_page.dart';
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
  String? _fechaError;

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
      _fechaError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Crear Excursión',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Excursion App')), // Reemplaza MyHomePage con el nombre correcto de tu página de inicio
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Color(0xFFE0FF85), // Cambia el color del card a E0FF85
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
                            _fechaError = null; // Reiniciar el mensaje de error de fecha
                          });
                        }
                      },
                      child: Text(
                        _fecha != null
                            ? 'Fecha: ${_fecha!.toString().substring(0, 10)}'
                            : 'Seleccionar fecha',
                      ),
                    ),
                    if (_fechaError != null) ...[
                      SizedBox(height: 8),
                      Text(
                        _fechaError!,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
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
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_fecha == null) {
                              setState(() {
                                _fechaError = 'Por favor, selecciona una fecha';
                              });
                            } else {
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

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Se creó una nueva excursión'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Agregar'),
                      ),
                    ),
                  ],
                ),
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
