
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 102, 255),
              Color.fromARGB(255, 255, 153, 51)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
        )
      ),
    );

    //uso o stack pq quero colocar o conteúda acima do fundo
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,//some ao scrollar pra baixo e volta ao subir
              backgroundColor: Colors.transparent,
              elevation: 0.0,//define se vai ter sombra abaixo dela
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true,
              ),
            )
          ],
        )
      ],
    );
  }
}
