import 'package:flutter/material.dart';
import 'package:loja_three/screens/fav_screen.dart';

class FavButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.favorite, color:Colors.white),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>FavScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
