import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loja_three/models/item_model.dart';

class TelaDeAdicao extends StatefulWidget {
  @override
  _TelaDeAdicaoState createState() => _TelaDeAdicaoState();
}

class _TelaDeAdicaoState extends State<TelaDeAdicao> {
  String category;

  String id;
  String title;
  String description;
  int year;
  int size;
  List images;
  String genero;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();
  final _sizeController = TextEditingController();
  final _genreController = TextEditingController();
  File imagemGlobal = null;
  Future<File> imagemFuture = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Adicione obra à lista",
        ),
        centerTitle: true,

      ),


      body:
            Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Título"),
                maxLines: null,
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(hintText: "Ano de lançamento"),
                maxLines: null,
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(hintText: "Número de episódios"),
                maxLines: null,
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: "Descrição"),
                maxLines: null,
              ),

              SizedBox(height: 16.0,),

              TextFormField(
                controller: _genreController,
                decoration: InputDecoration(hintText: "Gênero"),
                maxLines: null,
              ),

              SizedBox(height: 16.0,),

              SizedBox(
              height: 36.0,

              child: imagemGlobal==null?

                RaisedButton.icon(
                  onPressed: () async{
                    final File imgFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                    imagemGlobal = imgFile;
                    setState(() {

                    });

                  },

                  label: Text(
                    "Adicionar imagem",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),

                  icon: Icon(Icons.camera_alt),
                  color: Theme.of(context).primaryColor,
                ):

                RaisedButton.icon(
                    onPressed: () async{
                      final File imgFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                      imagemGlobal = imgFile;
                      setState(() {

                      });

                    },

                    label: Text(
                    "Imagem adicionada",
                    style: TextStyle(fontSize: 18.0),),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),

                    icon: Icon(Icons.check),
                    color: Colors.green,
                ),
          ),


              SizedBox(height: 26.0),

              SizedBox(
                height: 44.0,

                child: RaisedButton(
                  child: Text(
                    "Adicionar anime",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,

                  onPressed: (){
                    print("clicou!");
                    switch (validate()){
                      case "title":
                        onFail("Título");
                        break;

                      case "year":
                        onFail("Ano de lançamento");
                        break;

                      case "size":
                        onFail("Número de episódios");
                        break;
                      case "description":
                        onFail("Descrição");
                        break;


                      case "genero":
                        onFail("genero");
                        break;

                      case "preenchidos":
                        print("p");
                        onSuccess(_genreController.text);
                        break;
                    }




                  },
                ),
              ),



            ],
          )
      ),
    );
  }




  bool validaImg(File imgFile){
    if(imgFile==null){
      return false;
    }
    else return true;
    
  }
  
  String validate(){
    String title = _titleController.text;
    String size = _sizeController.text;
    String year = _yearController.text;
    String descrption = _descriptionController.text;
    String generoDigitado = _genreController.text;
    if((title=='')){
      return "title";
    }
    else if((size=='')){
      return "size";
    }

    else if((year=='')){
      return "year";
    }

    else if((descrption == '')){
      return "description";
    }

    else if((generoDigitado == '')){
      return "genero";
    }
    

    else return "preenchidos";
  }

  void onFail(campo){

    if(!validaImg(imagemGlobal)){//se não tiver img
      print("sem img");
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
          Text("Preencha o campo '${campo}' e adicione uma imagem"),
          backgroundColor:Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }

    else if(validaImg(imagemGlobal)){//se tiver img
      print("com img");
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:
          Text("O campo '${campo}' não pode ficar em branco!"),
          backgroundColor:Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }


  }

  void onSuccess(String genero){
    ItemModel addItem = ItemModel();//instancio ItemModel
    //Map<String, dynamic> dadosDoItem = addItem.itemData;

    Map<String, dynamic>dadosDoItem = {//passo os dados obtidos pro dadosDoItem
      "title":_titleController.text,
      "year":_yearController.text,
      "size":_sizeController.text,
      "description":_descriptionController.text,
    };


    addItem.adicionaItemNoBanco(itemData: dadosDoItem, genero: genero);//mando os dados pra função de adicionar no banco

    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content:
        Text("Adicionado com sucesso!"),
        backgroundColor:Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}



