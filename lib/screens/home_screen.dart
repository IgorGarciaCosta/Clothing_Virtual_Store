import 'package:flutter/material.dart';
import 'package:loja_three/tabs/genre_tab.dart';
import 'package:loja_three/tabs/home_tabs.dart';
import 'package:loja_three/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(//coloco as telas aqui dentro
      controller: _pageController,
      physics:NeverScrollableScrollPhysics() ,//faz as telas são serem arrastáveis
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Gêneros"),
            centerTitle: true,
          ),
          drawer:CustomDrawer(_pageController) ,
          body: GenreTab(),
        ),
      ],
    );
  }
}
