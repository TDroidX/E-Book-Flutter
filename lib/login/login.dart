import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../libros/librosDoc.dart'; // Importa el archivo librosDoc
import '../registro/registro.dart'; // Importa el archivo de registro
import '../main.dart'; // Importa tu archivo main.dart para acceder a la función Inicio()

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  // Función para validar las credenciales del usuario
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    String? savedPassword = prefs.getString('password');

    if (_usuarioController.text == savedName &&
        _contrasenaController.text == savedPassword) {
      // Guardar estado de sesión en SharedPreferences
      await prefs.setBool('isLoggedIn', true); 

      // Navegar a la página de Libros
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LibrosDocPage()), // Navegar a librosDoc
      );
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Inicio()), // Redirige a Inicio
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()), // Navegar a registro
              );
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 53, 92, 125),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 122, 60),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF223B59)),
                ),
                SizedBox(height: 16),
                // Campo Usuario
                TextFormField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF223B59)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Campo Contraseña
                TextFormField(
                  controller: _contrasenaController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF223B59)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                // Botón Iniciar Sesión
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _login(); // Validar las credenciales
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF223B59),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Iniciar Sesión', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
