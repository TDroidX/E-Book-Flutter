import 'package:flutter/material.dart';
import './login/login.dart'; // Asegúrate de que este archivo exista en la ruta mencionada

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context), // Pasamos el contexto
    );
  }
}

Widget cuerpo(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/img/fondo1.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          nombre(),
          SizedBox(height: 10),
          // Botón que redirige al LoginPage
          TextButton(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              ),
              backgroundColor: const MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 56, 80, 219),
              ),
              foregroundColor: const MaterialStatePropertyAll<Color>(
                Colors.white,
              ),
            ),
            onPressed: () {
              // Navegar a LoginPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: const Text(
              "Entrar",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget nombre() {
  return Text(
    "Bienvenido",
    style: TextStyle(
      color: Colors.white,
      fontSize: 55.0,
      fontWeight: FontWeight.bold,
    ),
  );
}
