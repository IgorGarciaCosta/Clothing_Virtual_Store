import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yearController = TextEditingController();
  final _sizeController = TextEditingController();
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
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(hintText: "Ano de lançamento"),
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(hintText: "Número de episódios"),
              ),

              SizedBox(height: 16.0),

              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: "Descrição"),
              ),

              SizedBox(height: 16.0),

              SizedBox(
                height: 44.0,

                child: RaisedButton(
                  child: Text(
                    "Adicionar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,

                  onPressed: (){
                    print("clicou!");
                    switch (validate()){
                      case "title":
                        print("t");
                        onFail("Título");
                        break;

                      case "year":
                        print("y");
                        onFail("Ano de lançamento");
                        break;

                      case "size":
                        print("s");
                        onFail("Número de episódios");
                        break;
                      case "description":
                        print("d");
                        onFail("Descrição");
                        break;
                      case "preenchidos":
                        print("p");
                        onSuccess();
                        break;
                    }
                  },
                ),
              )

            ],
          )
      ),
    );
  }

  String validate(){
    String title = _titleController.text;
    String size = _sizeController.text;
    String year = _yearController.text;
    String descrption = _descriptionController.text;
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


    else return "preenchidos";
  }

  void onFail(campo){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content:
        Text("O campo '${campo}' não pode ficar em branco!"),
        backgroundColor:Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void onSuccess(){
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



