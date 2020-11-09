import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar conta"),
        centerTitle: true,

      ),
      body: Form(//valida campos
        key: _formKey,
        child: ListView(//bom usar listView pq pode ser que algo importante seja coberto pelo teclado
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Nome completo"
              ),
              validator: (text){
                if(text.isEmpty){
                  return "Nome Invalido";
                }
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,//já aparece o @ no teclado
              validator: (text){
                if(text.isEmpty || !text.contains("@")){
                  return "Email Invalido";
                }
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Senha"
              ),
              obscureText: true,//pra não ver a senha
              validator: (text){
                if(text.isEmpty || text.length<6){
                  return "Senha inválida";
                }
              },
            ),
            SizedBox(height: 16.0,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Endereço"
              ),
              validator: (text){
                if(text.isEmpty){
                  return "Endereço inválido";
                }
              },
            ),

            SizedBox(height: 16.0,),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text("Cadastrar",
                  style: TextStyle(
                      fontSize: 18.0
                  ),

                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  if(_formKey.currentState.validate()){

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
