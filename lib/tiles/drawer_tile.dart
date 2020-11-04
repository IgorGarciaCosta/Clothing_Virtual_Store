import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);//construtor
  @override
  Widget build(BuildContext context) {
    return Material(//uso o material pra ter um efeito visual ao clicar
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();//fecha o drawer antes de mudar a página
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                //se a pág. atual do controlador for = à pág do meu item
                //, coz azul, senão, cinza
                color: controller.page.round() == page?
                    Theme.of(context).primaryColor:Colors.grey[700],
              ),
              SizedBox(width: 32.0,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller.page.round() == page?
                      Theme.of(context).primaryColor:Colors.grey[700]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
