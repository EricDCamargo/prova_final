import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  BMIScreenState createState() => BMIScreenState();
}

class BMIScreenState extends State<BMIScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _result = '';

  void _calculateBMI(int age, String gender) {
    if (_weightController.text.isEmpty || _heightController.text.isEmpty) {
      setState(() {
        _result = 'Por favor, preencha ambos os campos.';
      });
      return;
    }

    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) /
        100; // Convertendo altura para metros
    double bmi = weight / (height * height);

    String bmiCategory = _getBMICategory(bmi, age, gender);

    setState(() {
      _result = 'Seu IMC é ${bmi.toStringAsFixed(2)} ($bmiCategory)';
    });
  }

  String _getBMICategory(double bmi, int age, String gender) {
    if (age < 18) {
      if (gender.toLowerCase() == 'masculino') {
        // Categorias para meninos
        if (age < 5) {
          if (bmi < 14) return 'Abaixo do peso';
          if (bmi <= 18) return 'Peso normal';
          return 'Acima do peso';
        } else if (age < 10) {
          if (bmi < 14.5) return 'Abaixo do peso';
          if (bmi <= 19) return 'Peso normal';
          return 'Acima do peso';
        } else {
          if (bmi < 16) return 'Abaixo do peso';
          if (bmi <= 23) return 'Peso normal';
          return 'Acima do peso';
        }
      } else {
        // Categorias para meninas
        if (age < 5) {
          if (bmi < 14) return 'Abaixo do peso';
          if (bmi <= 18) return 'Peso normal';
          return 'Acima do peso';
        } else if (age < 10) {
          if (bmi < 14.5) return 'Abaixo do peso';
          if (bmi <= 19) return 'Peso normal';
          return 'Acima do peso';
        } else {
          if (bmi < 16) return 'Abaixo do peso';
          if (bmi <= 23) return 'Peso normal';
          return 'Acima do peso';
        }
      }
    } else {
      // Categorias para adultos
      if (gender.toLowerCase() == 'masculino') {
        if (bmi < 18.5) {
          return 'Abaixo do peso';
        } else if (bmi < 24.9) {
          return 'Peso normal';
        } else if (bmi < 29.9) {
          return 'Sobrepeso';
        } else if (bmi < 34.9) {
          return 'Obesidade Grau I';
        } else if (bmi < 39.9) {
          return 'Obesidade Grau II';
        } else {
          return 'Obesidade Grau III';
        }
      } else {
        // Categorias para feminino
        if (bmi < 18.5) {
          return 'Abaixo do peso';
        } else if (bmi < 24.9) {
          return 'Peso normal';
        } else if (bmi < 29.9) {
          return 'Sobrepeso';
        } else if (bmi < 34.9) {
          return 'Obesidade Grau I';
        } else if (bmi < 39.9) {
          return 'Obesidade Grau II';
        } else {
          return 'Obesidade Grau III';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Extração dos argumentos com verificação de nulidade
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs == null) {
      // Tratativa de nulidade exibição de erros
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Nenhum usuário encontrado!'),
        ),
      );
    }

    final Map<String, dynamic> user = routeArgs as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de IMC'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Calculando IMC para: ${user['name']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Altura (cm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _calculateBMI(user['age'], user['gender']),
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
