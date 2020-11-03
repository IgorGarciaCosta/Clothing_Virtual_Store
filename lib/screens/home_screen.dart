import 'package:flutter/material.dart';
import 'package:loja_three/tabs/home_tabs.dart';
import 'package:loja_three/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(//coloco as telas aqui dentro
      physics:NeverScrollableScrollPhysics() ,//faz as telas são serem arrastáveis
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(),
        )
      ],
    );
  }
}
