import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Idade'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua idade';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Sexo:'),
                  Row(
                    children: [
                      Checkbox(
                        value: _gender == 'Masculino',
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) _gender = 'Masculino';
                          });
                        },
                      ),
                      Text('Masculino'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _gender == 'Feminino',
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) _gender = 'Feminino';
                          });
                        },
                      ),
                      Text('Feminino'),
                    ],
                  ),
                ],
              ),
              if (_gender == null)
                Text(
                  'Por favor, selecione seu sexo',
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  } else if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}')
                      .hasMatch(value)) {
                    return 'Digite um endereço de e-mail válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _gender != null) {
                    await DatabaseHelper.instance.insertUser({
                      'name': _nameController.text,
                      'age': int.parse(_ageController.text),
                      'gender': _gender,
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Cadastro realizado com sucesso!')),
                    );

                    Navigator.pop(context);
                  } else if (_gender == null) {
                    setState(() {});
                  }
                },
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
