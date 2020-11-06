import 'package:flutter/material.dart';
import 'package:loja_three/datas/genre_data.dart';

class GenreTile extends StatelessWidget {
  final String type;
  final GenreData product;
  GenreTile(this.type, this.product);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: type == "grid"?
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.8,
                  child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          Text(
                            "${product.size} eps",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                )
              ],
            )
            :Row(),
      ),
    );
  }
}
