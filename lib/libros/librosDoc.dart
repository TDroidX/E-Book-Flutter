import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../crudLibros/altaLibro.dart'; // Ruta del archivo en la carpeta crudLibros
import '../busquedaLibros/busquedaLib.dart'; // Nueva ruta al archivo de búsqueda
import '../perfil/perfil.dart'; // Nueva ruta al archivo de perfil
import '.././main.dart'; 
import '../login/login.dart';// Ruta al archivo principal


class LibrosDocPage extends StatefulWidget {
  @override
  _LibrosDocPageState createState() => _LibrosDocPageState();
}

class _LibrosDocPageState extends State<LibrosDocPage> {
  List<Map<String, String>> libros = []; // Lista para almacenar los libros añadidos
  List<Map<String, String>> librosFiltrados = []; // Lista para almacenar los resultados de búsqueda

  @override
  void initState() {
    super.initState();
    librosFiltrados = libros; // Inicialmente, mostrar todos los libros
  }

  // Método para eliminar un libro
  void eliminarLibro(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este libro?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Eliminar"),
              onPressed: () {
                setState(() {
                  librosFiltrados.removeAt(index); // Eliminar el libro
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Función para cerrar sesión
Future<void> _cerrarSesion() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.remove('name');
  // await prefs.remove('password'); 
  await prefs.remove('isLoggedIn'); // Eliminar el estado de sesión

  // Redirigir al login
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()), // Redirige al LoginPage
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Libros y documentos"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        leading: PopupMenuButton<String>(
  icon: Icon(Icons.menu),
  onSelected: (String choice) {
    switch (choice) {
      case 'Inicio':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Inicio()), // Me da error aqui!!
        );
        break;
      case 'Perfil':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilPage()), // Redirige a la página de perfil
        );
        break;
      case 'Cerrar sesión':
        _cerrarSesion(); // Llamar a la función para cerrar sesión
        break;
      case 'Configuración':
        print('Navegar a Configuración');
        break;
      default:
        break;
    }
  },
  itemBuilder: (BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'Inicio',
        child: Text('Inicio'),
      ),
      PopupMenuItem<String>(
        value: 'Perfil',
        child: Text('Perfil'),
      ),
      PopupMenuItem<String>(
        value: 'Cerrar sesión',
        child: Text('Cerrar sesión'),
      ),
      PopupMenuItem<String>(
        value: 'Configuración',
        child: Text('Configuración'),
      ),
    ];
  },
)
,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusquedaLibPage(libros: libros),
                ),
              );
            },
          ),
        ],
      ),
      body: librosFiltrados.isEmpty
          ? Center(
              child: Text(
                "No se encontraron libros con ese nombre.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: librosFiltrados.length,
              itemBuilder: (context, index) {
                final libro = librosFiltrados[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: libro['portada'] != null
                        ? Image.network(libro['portada']!)
                        : Icon(Icons.book, size: 40, color: Colors.grey),
                    title: Container(
                      width: MediaQuery.of(context).size.width - 120, // Para dar más espacio
                      child: Text(
                        libro['titulo'] ?? "Sin título",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis, // Para evitar que el texto se desborde
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Text(libro['autor'] ?? "Autor desconocido"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            // Navegar a la configuración del libro para editar
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AltaLibroPage(), // Redirige a la página de configuración/edición
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => eliminarLibro(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevoLibro = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AltaLibroPage()),
          );

          if (nuevoLibro != null) {
            setState(() {
              libros.add(Map<String, String>.from(nuevoLibro));
              librosFiltrados = libros;
            });
          }
        },
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        child: Icon(Icons.add),
      ),
    );
  }
}
