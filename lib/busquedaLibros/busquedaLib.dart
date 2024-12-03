import 'package:flutter/material.dart';

class BusquedaLibPage extends StatefulWidget {
  final List<Map<String, String>> libros; // Recibir la lista de libros

  BusquedaLibPage({required this.libros});

  @override
  _BusquedaLibPageState createState() => _BusquedaLibPageState();
}

class _BusquedaLibPageState extends State<BusquedaLibPage> {
  List<Map<String, String>> librosFiltrados = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    librosFiltrados = widget.libros; // Inicializar con todos los libros
  }

  void buscarLibro(String texto) {
    setState(() {
      query = texto;

      if (query.isEmpty) {
        librosFiltrados = widget.libros; // Mostrar todos los libros si no hay texto
      } else {
        librosFiltrados = widget.libros
            .where((libro) => libro['titulo']!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar un libro"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: buscarLibro,
              decoration: InputDecoration(
                hintText: "Buscar un libro",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          // Resultados de búsqueda o mensaje vacío
          Expanded(
            child: librosFiltrados.isEmpty
                ? Center(
                    child: Text(
                      "No se encontraron libros.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: librosFiltrados.length,
                    itemBuilder: (context, index) {
                      final libro = librosFiltrados[index];
                      return ListTile(
                        leading: Icon(Icons.book, color: Colors.blue),
                        title: Text(libro['titulo'] ?? "Sin título"),
                        subtitle: Text(libro['autor'] ?? "Autor desconocido"),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
