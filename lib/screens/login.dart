import 'package:flutter/material.dart';
import 'package:minhas_tarefas/screens/home.dart';

import '../constants/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/images/logo_login.png'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: primaryGrey, width: 1.5),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'E-mail',
                      hintText: 'email@email.com',
                      labelStyle: const TextStyle(
                        color: primaryGrey,
                      ),
                      suffixIcon: const Icon(
                        Icons.mail,
                        size: 20,
                        color: primaryBlack,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: primaryGrey, width: 1.5),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Senha',
                      labelStyle: const TextStyle(
                        color: primaryGrey,
                      ),
                      hintText: '*****',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: primaryBlack,
                        ),
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text('Entrar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == 'admin@admin.com' &&
          passwordController.text == 'admin') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    email: emailController.text,
                  )),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-mail e/ou senha incorreto(s)')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha os campos')),
      );
    }
  }
}
