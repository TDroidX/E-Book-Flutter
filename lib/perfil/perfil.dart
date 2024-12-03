import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenido al perfil de usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Aquí puedes ver y editar tus datos personales.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ListTile(
              title: Text('Nombre de Usuario'),
              subtitle: Text('Juan Pérez'),
              leading: Icon(Icons.account_circle),
            ),
            ListTile(
              title: Text('Correo Electrónico'),
              subtitle: Text('juan.perez@example.com'),
              leading: Icon(Icons.email),
            ),
            ListTile(
              title: Text('Teléfono'),
              subtitle: Text('+1 234 567 890'),
              leading: Icon(Icons.phone),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Lógica para editar perfil
              },
              child: Text('Editar Perfil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 53, 92, 125), // Cambié `primary` por `backgroundColor`
              ),
            ),
          ],
        ),
      ),
    );
  }
}
