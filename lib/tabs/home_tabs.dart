
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

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
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection("home").
              orderBy("pos").getDocuments(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return SliverToBoxAdapter(//usa isso pq o circleboxindicator não pode estar direto dentro do sliver
                    child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                }

                else {//se houver algum dado
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,//espaçamento horizontal
                    staggeredTiles: snapshot.data.documents.map(
                        (doc){//função anonima que recebe o documento do banco
                            return StaggeredTile.count(doc.data["x"], doc.data["y"]);//pega as dimensões dos documentos
                        }
                    ).toList(),
                    children: snapshot.data.documents.map(
                        (doc){
                          return FadeInImage.memoryNetwork(//imagem que aparecerá suavemente
                              placeholder: kTransparentImage,
                              image: doc.data["image"],
                              fit:BoxFit.cover
                          );
                        }
                      ).toList(),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
