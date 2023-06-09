import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../domain/excursion.dart';
import 'package:intl/intl.dart';
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
  final ApiService _apiService = ApiService();

  void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Excursion App')),
    );
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Actualizar Excursión',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              color: Color(0xFFE0FF85),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa una descripción válida';
                        }
                        if (!_containsOnlyLetters(value)) {
                          return 'Por favor, ingresa solo letras y espacios';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _fechaController,
                      decoration: InputDecoration(
                        labelText: 'Fecha',
                      ),
                      enabled: false,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _precioController,
                      decoration: InputDecoration(
                        labelText: 'Precio',
                      ),
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
                    TextFormField(
                      controller: _estadoController,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un estado válido';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Por favor, ingresa un número válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _lugarController,
                      decoration: InputDecoration(
                        labelText: 'Lugar',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un lugar válido';
                        }
                        if (!_validatePlace(value)) {
                          return 'Por favor, ingresa solo letras y espacios';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _cantidadController,
                      decoration: InputDecoration(
                        labelText: 'Cantidad',
                      ),
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
                    ElevatedButton(
                      onPressed: () {
                        if (_validateForm()) {
                          final String nuevaDescripcion = _descripcionController.text;
                          final String nuevaFecha = _fechaController.text;
                          final double nuevoPrecio = double.parse(_precioController.text);
                          final int nuevoEstado = int.parse(_estadoController.text);
                          final String nuevoLugar = _lugarController.text;
                          final int nuevaCantidad = int.parse(_cantidadController.text);

                          DateTime originalDate =
                              DateFormat("dd-MM-yyyy").parse(nuevaFecha.replaceAll("/", "-"));
                          String formattedDateString = DateFormat("yyyy-MM-dd").format(originalDate);

                          Excursion excursionActualizada = Excursion(
                            id: widget.excursion.id,
                            descripcion: nuevaDescripcion,
                            fecha: DateTime.parse(formattedDateString),
                            precio: nuevoPrecio,
                            estado: nuevoEstado,
                            lugar: nuevoLugar,
                            cantidad: nuevaCantidad,
                          );

                          _apiService.modificarExcursion(context, excursionActualizada);
                          _navigateToHomePage(context);
                        }
                      },
                      child: Text('Guardar'),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_descripcionController.text.isEmpty || _descripcionController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa una descripción válida'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }
    if (!_containsOnlyLetters(_descripcionController.text)) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, ingresa una descripción válida'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return false;
  }
    if (_precioController.text.isEmpty || double.tryParse(_precioController.text) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa un precio válido'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (_estadoController.text.isEmpty || int.tryParse(_estadoController.text) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa un estado válido'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (_lugarController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa un lugar válido'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (!_validatePlace(_lugarController.text)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa solo letras y espacios para el lugar'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    if (_cantidadController.text.isEmpty || int.tryParse(_cantidadController.text) == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa una cantidad válida'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return false;
    }

    return true;
  }

  bool _validatePlace(String value) {
    final placeRegex = RegExp(r'^[a-zA-Z\s]+$');
    return placeRegex.hasMatch(value);
  }
   bool _containsOnlyLetters(String value) {
       final lettersOnlyRegex = RegExp(r'^[a-zA-Z\s]+$');
    return lettersOnlyRegex.hasMatch(value);
  }
}


