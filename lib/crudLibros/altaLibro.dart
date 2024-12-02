import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AltaLibroPage extends StatefulWidget {
  @override
  _AltaLibroPageState createState() => _AltaLibroPageState();
}

class _AltaLibroPageState extends State<AltaLibroPage> {
  String? fileName; // Nombre del archivo seleccionado
  String? filePath; // Ruta del archivo seleccionado
  String titulo = '';
  String autor = '';
  String fecha = '';

  Future<void> seleccionarArchivo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'epub'], // Solo archivos PDF y EPUB
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        fileName = result.files.first.name; // Nombre del archivo
        filePath = result.files.first.path; // Ruta del archivo
      });
    }
  }

  void guardarLibro() {
    if (titulo.isEmpty || autor.isEmpty || fecha.isEmpty || filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, llena todos los campos")),
      );
      return;
    }

    // Aquí podrías pasar los datos a la pantalla anterior o guardarlos en una base de datos
    Navigator.pop(context, {
      'titulo': titulo,
      'autor': autor,
      'fecha': fecha,
      'archivo': filePath,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Altas"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: seleccionarArchivo,
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[200],
                child: fileName == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file, size: 50, color: Colors.grey),
                            Text("Seleccionar archivo"),
                          ],
                        ),
                      )
                    : Center(
                        child: Text(
                          "Archivo seleccionado: $fileName",
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "Nombre:"),
              onChanged: (value) {
                setState(() {
                  titulo = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Autor:"),
              onChanged: (value) {
                setState(() {
                  autor = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: "Fecha:"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  fecha = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: guardarLibro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 53, 92, 125),
                ),
                child: Text("Guardar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
