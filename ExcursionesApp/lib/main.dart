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
                'Acá va contenido Visual Atractivo de la App',
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



// Clase para la vista de "Ver Excursiones"
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
      
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Excursión'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: excursiones.length,
              itemBuilder: (context, index) {
                final excursion = excursiones[index];
                return ListTile(
                  title: Text(excursion.descripcion),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha: ${excursion.fecha}'),
                      Text('Precio: ${excursion.precio}'),
                      Text('Estado: ${excursion.estado ? 'Activo' : 'Inactivo'}'),
                      Text('Lugar: ${excursion.lugar}'),
                      Text('Cantidad: ${excursion.cantidad}'),
                    ],
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
class CreateExcursionPage extends StatelessWidget {
  const CreateExcursionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Excursiones'),
            ElevatedButton(
              onPressed: () {
                // Handle form submission
              },
              child: Text('Agregar'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha'),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                      // Handle checkbox value change
                    },
                  ),
                  Text('Estado'),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lugar'),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
