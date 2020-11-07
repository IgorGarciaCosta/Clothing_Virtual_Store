import 'package:flutter/material.dart';
import 'package:loja_three/datas/genre_data.dart';

class ProductScreen extends StatefulWidget {
  final GenreData product;
  ProductScreen(this.product);
  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  //essas duas linhas servem pra evitar isar "widget.product" e usar
  //apenas "product"
  final GenreData product;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
