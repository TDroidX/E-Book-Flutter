import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './login/login.dart'; // Asegúrate de que este archivo exista en la ruta mencionada
import './libros/librosDoc.dart'; // Suponiendo que este es tu archivo de libros

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
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Ya no verificamos el estado de inicio de sesión al inicio.
    // Esto solo se hará cuando el usuario presione el botón "Entrar".
  }

  // Verifica el estado de la sesión cuando el usuario presiona el botón
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      isLoggedIn = loggedIn;
    });

    // Si está logueado, redirige a librosDoc
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LibrosDocPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context), // Pasamos el contexto
    );
  }

  Widget cuerpo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/fondo2.jpeg"),
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
                foregroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
              ),
              onPressed: () {
                // Verificar el estado de inicio de sesión cuando el usuario presiona el botón
                _checkLoginStatus();
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
}
