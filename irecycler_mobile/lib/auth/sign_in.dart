import 'package:flutter_svg/svg.dart';
import 'package:irecycler_mobile/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:irecycler_mobile/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              elevation: 0.0,
              title: Text('Ingresa a iRecycler'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Registrarse'),
                  textColor: Colors.white,
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
                child: Column(children: <Widget>[_loginForm(), _loginImage()])),
          );
  }

  Widget _loginImage() {
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
                      'assets/images/nature/world.svg',
                      width: constraints.maxWidth*1.0
                    )
                    )
                  ),
                  Positioned(
                    left: 0.0,
                    child: SvgPicture.asset(
                      'assets/images/nature/leaves.svg',
                      width: constraints.maxWidth*0.28  
                    )
                  ),
                  Positioned(
                    right: 0.0,
                    child: SvgPicture.asset(
                      'assets/images/recycle/recycle.svg',
                      width: constraints.maxWidth*0.28  
                    )
                  )
                ]
              )
            );
          }
        ));
  }

  Widget _loginForm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'email', icon: Icon(Icons.mail)),
              //textInputDecoration.copyWith(hintText: 'email'),
              validator: (val) => val.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: 'password', icon: Icon(Icons.security)),
              //textInputDecoration.copyWith(hintText: 'password'),
              validator: (val) =>
                  val.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) {
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
