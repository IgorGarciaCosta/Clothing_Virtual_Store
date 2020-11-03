import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;

  DrawerTile(this.icon, this.text);//construtor
  @override
  Widget build(BuildContext context) {
    return Material(//uso o material pra ter um efeito visual ao clicar
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: Colors.black,
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
