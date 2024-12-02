import 'package:flutter/material.dart';
import '../registro/registro.dart';  // Importa el archivo de registro

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi App",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variables para los controladores de los campos de texto
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  // Variable para controlar si la contraseña está visible
  bool _obscureText = true;

  // Clave global para el formulario
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        actions: [
          // Aquí agregamos el botón para ir a la página de registro
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),  // Navegar a la pantalla de registro
              );
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 53, 92, 125), // Fondo negro
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 192, 122, 60), // Fondo naranja del contenedor
            borderRadius: BorderRadius.circular(16),
          ),
          child: Form(
            key: _formKey, // Asignamos la clave al formulario
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF223B59), // Azul oscuro del título
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Usamos CustomPaint para dibujar el polígono
                Container(
                  height: 80,
                  width: 80,
                  child: CustomPaint(
                    painter: PolygonPainter(),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF223B59), // Azul oscuro del ícono
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF223B59),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu usuario';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Campo de Contraseña con funcionalidad de ver/ocultar
                TextFormField(
                  controller: _contrasenaController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF223B59),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // Cambia el estado de visibilidad
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
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Si el formulario es válido, realizamos la autenticación
                      // Aquí puedes agregar la lógica de autenticación
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 20, 90, 175), // Azul oscuro del botón
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CustomPainter para dibujar un polígono
class PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    // Define los puntos del polígono
    path.moveTo(size.width * 0.5, 0); // Vértice superior
    path.lineTo(size.width, size.height * 0.35);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.35);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
