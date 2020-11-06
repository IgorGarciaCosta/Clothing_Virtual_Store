import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_three/datas/genre_data.dart';
import 'package:loja_three/tiles/genre_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor:
                  Colors.white, //barrinha qued indica em que ícone está
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("generos").document(snapshot.documentID)
              .collection("items").getDocuments(),//pega todos os gêneros lá do banco
            builder: (context, snapshot) {
            if (!snapshot.hasData) {
              //se não retornar nada
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              return TabBarView(
                physics:
                    NeverScrollableScrollPhysics(), //impede de mudar entre frid e lista deslizando pro lado
                //aqui dentro ficam o grid e a lista
                children: [
                  //GRID
                  GridView.builder(//não carrega tudo de vez
                      padding: EdgeInsets.all(4.0),//espaço em todos os lados
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65),//núm de itens na horizintal
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        return GenreTile("grid", GenreData.fromDocument(snapshot.data.documents[index]));
                      }),


                  //LISTA
                  ListView.builder(
                     padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      return GenreTile("list", GenreData.fromDocument(snapshot.data.documents[index]));
                    }
                  )
                ],
              );
            }
          }
          )
      ),
    );
  }
}
