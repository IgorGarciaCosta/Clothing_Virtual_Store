import 'package:carousel_pro/carousel_pro.dart';
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
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4.0,
                dotSpacing: 15.0,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,//não muda as imagens automaticamente

              ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,//tenta ocupar o máx espaço disp
                children: <Widget>[
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500
                    ),
                    maxLines: 3,
                  ),
                  Text("Ano de lançamento: ${product.year}",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),)
                ],
              ),
          )
        ],
      ),
    );
  }
}
