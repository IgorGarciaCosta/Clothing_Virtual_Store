import 'package:flutter/material.dart';
import 'package:loja_three/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      //tudo que estiver abaixo do scopedModel
      //vai ter acesso ao UserModel()
      model: UserModel(),
      child: MaterialApp(
          title: 'Minha loja virtual bolada',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreen()//MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

