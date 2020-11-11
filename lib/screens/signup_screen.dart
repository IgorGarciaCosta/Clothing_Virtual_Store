import 'package:flutter/material.dart';
import 'package:loja_three/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar conta"),
          centerTitle: true,

        ),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if(model.isLoading)
                return Center(child: CircularProgressIndicator(),);
              return Form(//valida campos
                key: _formKey,
                child: ListView(//bom usar listView pq pode ser que algo importante seja coberto pelo teclado
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
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
                      controller: _emailController,
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
                      controller: _passwordController,
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
                      controller: _addressController,
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
                            fontSize: 18.0,
                          ),

                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            Map<String, dynamic>userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _addressController.text,
                            };

                            model.signUp(
                                userData: userData,
                                password: _passwordController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
        )
    );
  }

  void _onSuccess(){

  }

  void _onFail(){

  }
}



