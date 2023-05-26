import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excursiones App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 183, 150)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Excursiones App'),
      routes: {
        '/Agregar': (context) => CreateExcursionPage(),
        '/Ver': (context) => VerExcursionesPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/my_image.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bienvenido al App de Excursiones!',
              ),
              SizedBox(height: 50), // Espacio entre el texto y la imagen
              Image.asset(
                'assets/viaje2.jpg', // Ruta de la imagen que deseas mostrar
                width: 200, // Ancho de la imagen
                height: 200, // Alto de la imagen
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Agregar');
        },
        tooltip: 'Agregar',
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 58, 183, 150),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Agregar Excursión'),
              onTap: () {
                Navigator.pushNamed(context, '/Agregar');
              },
            ),
            ListTile(
              title: Text('Ver Excursiones'),
              onTap: () {
                Navigator.pushNamed(context, '/Ver');
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Ver Excursiones
class VerExcursionesPage extends StatelessWidget {
  const VerExcursionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para las excursiones
    List<Excursion> excursiones = [
      Excursion(
        descripcion: 'Excursión 1',
        fecha: DateTime.now(),
        precio: 100,
        estado: true,
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
                final excursion = excursiones[index];
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
                            'Estado: ${excursion.estado ? 'Activo' : 'Inactivo'}',
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

// Clase para representar una excursión
class Excursion {
  final String descripcion;
  final DateTime fecha;
  final double precio;
  final bool estado;
  final String lugar;
  final int cantidad;

  Excursion({
    required this.descripcion,
    required this.fecha,
    required this.precio,
    required this.estado,
    required this.lugar,
    required this.cantidad,
  });
}

// Clase de form
class CreateExcursionPage extends StatefulWidget {
  const CreateExcursionPage({Key? key}) : super(key: key);

  @override
  _CreateExcursionPageState createState() => _CreateExcursionPageState();
}

class _CreateExcursionPageState extends State<CreateExcursionPage> {
  final _formKey = GlobalKey<FormState>();

  String? _descripcion;
  DateTime? _fecha;
  double? _precio;
  bool _estado = true;
  String? _lugar;
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
