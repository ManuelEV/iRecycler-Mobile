import 'package:flutter_svg/svg.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:irecycler_mobile/shared/constants.dart';
import 'package:irecycler_mobile/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Regístrate en iRecycler'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Ingresar'),
            textColor: Colors.white,
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[_signUpForm(), _signUpImage()])),
    );
  }

  Widget _signUpImage() {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: LayoutBuilder(
          builder: (_, constraints){
            return Container(
              //color: Colors.red,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                      'assets/images/nature/sun.svg',
                      width: constraints.maxWidth*1.0
                    )
                    )
                  ),
                  Positioned(
                    left: 0.0,
                    child: SvgPicture.asset(
                      'assets/images/nature/sprout.svg',
                      width: constraints.maxWidth*0.28  
                    )
                  ),
                  Positioned(
                    right: 0.0,
                    child: SvgPicture.asset(
                      'assets/images/recycle/recycling.svg',
                      width: constraints.maxWidth*0.28  
                    )
                  )
                ]
              )
            );
          }
        ));
  }

  Widget _signUpForm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'email',
                  icon: Icon(Icons.mail)
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'password',
                  icon: Icon(Icons.security)
                ),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
    );
  }

}