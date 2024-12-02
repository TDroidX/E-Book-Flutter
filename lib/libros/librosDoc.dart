import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart'; // Para seleccionar archivos
import '../crudLibros/altaLibro.dart'; // Ruta del archivo en la carpeta crudLibros

class LibrosDocPage extends StatefulWidget {
  @override
  _LibrosDocPageState createState() => _LibrosDocPageState();
}

class _LibrosDocPageState extends State<LibrosDocPage> {
  List<Map<String, String>> libros = []; // Lista para almacenar los libros añadidos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Libros y documentos"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Acción para buscar libros (se puede implementar más adelante)
            },
          ),
        ],
      ),
      body: libros.isEmpty
          ? Center(
              child: Text(
                "Nada por mostrar aún...",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: libros.length,
              itemBuilder: (context, index) {
                final libro = libros[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: libro['portada'] != null
                        ? Image.network(libro['portada']!)
                        : Icon(Icons.book, size: 40, color: Colors.grey),
                    title: Text(libro['titulo'] ?? "Sin título"),
                    subtitle: Text(libro['autor'] ?? "Autor desconocido"),
                    trailing: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        // Acción para configuración del libro
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de altas
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AltaLibroPage()),
          );
        },
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        child: Icon(Icons.add),
      ),
    );
  }
}
