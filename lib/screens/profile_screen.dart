import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extração dos argumentos com verificação de nulidade
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs == null) {
      // Tratativa de nulidade exibição de erros whatever...
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

    String determineBackground(int age, String gender) {
      if (gender == "Maculino") {
        if (age < 13) return 'lib/assets/male_children_bg.png';
        if (age < 20) return 'lib/assets/male_teen_bg.png';
        if (age < 60) return 'lib/assets/male_adult_bg.png';
        return 'lib/assets/male_senior_bg.png';
      } else {
        if (age < 13) return 'lib/assets/female_children_bg.png';
        if (age < 20) return 'lib/assets/female_teen_bg.jpeg';
        if (age < 60) return 'lib/assets/female_adult_bg.jpeg';
        return 'lib/assets/female_senior_bg.jpeg';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user['name']),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(determineBackground(user['age'], user['gender'])),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bem-vindo, ${user['name']}!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calculator');
                },
                child: Text('Calculadora'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bmi', arguments: user);
                },
                child: Text('Cálculo de IMC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
