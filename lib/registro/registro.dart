import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login.dart';  // Importa el archivo de login

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi App",
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Función para validar los campos
  bool _validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  // Función para guardar los datos
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Guardar los datos
    await prefs.setString('name', _nameController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('age', _ageController.text);
    await prefs.setString('password', _passwordController.text);

    // Navegar a la página de login después de guardar
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),  // Navegar a la página de Login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER"),
        backgroundColor: Color.fromARGB(255, 53, 92, 125),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),  // Navegar a la página de Login
              );
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF223B59),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Icono del usuario
                  Container(
                    height: 80,
                    width: 80,
                    child: CustomPaint(
                      painter: PolygonPainter(),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF223B59),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  // Campo Nombre
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
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
                        return 'Por favor ingresa tu nombre';
                      }
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'El nombre solo debe contener letras';
                      }
                      if (value.length > 12) {
                        return 'El nombre debe tener máximo 12 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo Teléfono
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Color(0xFF223B59),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu teléfono';
                      }
                      if (value.length != 10) {
                        return 'El teléfono debe tener 10 dígitos';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo Edad
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Edad',
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF223B59),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu edad';
                      }
                      if (!RegExp(r'^\d{1,2}$').hasMatch(value)) {
                        return 'La edad debe ser un número de 1 o 2 dígitos';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo Contraseña
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
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
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa una contraseña';
                      }
                      if (!RegExp(r'^[a-zA-Z0-9]{1,8}$').hasMatch(value)) {
                        return 'La contraseña debe tener máximo 8 caracteres y sin caracteres especiales';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Campo Confirmar Contraseña
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
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
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor confirma la contraseña';
                      }
                      if (value != _passwordController.text) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),
                  // Botón Guardar
                  ElevatedButton(
                    onPressed: () {
                      if (_validateForm()) {
                        _saveData();  // Guardar los datos y redirigir
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF223B59),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Guardar', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF223B59)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2, 0);  // Vértice superior
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
