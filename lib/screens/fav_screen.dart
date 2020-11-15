import 'package:flutter/material.dart';
import 'package:loja_three/models/fav_model.dart';
import 'package:scoped_model/scoped_model.dart';

class FavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Favoritos"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<FavModel>(
              builder: (context, child, model){
                int quantidade = model.products.length;
                return Text(
                  
                    //se quant. == null, retorna 0, se não for, retorna o val. de quant.
                    "${quantidade ?? 0} ${quantidade==1 ?"ITEM":"ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
