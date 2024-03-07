// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, unnecessary_new, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yobeen_smart/LocalStorage/localeStorage.dart';
import 'package:yobeen_smart/Login/API/api_login.dart';
import 'package:yobeen_smart/Login/Model/model_login.dart';
import 'package:yobeen_smart/Login/Pages/loading_screen.dart';
import 'package:yobeen_smart/Navigation/API/api_stations.dart';
import 'package:yobeen_smart/Navigation/Page/navigation.dart';
import 'package:yobeen_smart/Welcome/Page/welcome_screen.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late LoginRequestModel _loginRequestModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
  bool _visibilityError = false;
  String _textError = "";
  String _emailErrorValidator = "";
  String _passwordErrorvalidator = "";
  bool _isChecked = false;

  void _loadUserEmailPassword() async {
    await GetStorage.init();
    var _email = LocalStorage.getTele() ?? "";
    var _password = LocalStorage.getPassword() ?? "";
    var _remeberMe = LocalStorage.getRemember() ?? false;

    if (_remeberMe) {
      setState(() {
        _isChecked = true;
      });
      _emailController.text = _email ?? "";
      _passwordController.text = _password ?? "";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
    _passwordVisible = false;
    _loginRequestModel = new LoginRequestModel(email_tel: '', password: '');
  }

  void toggleSwitch(bool value) {
    if (!_isChecked) {
      setState(() {
        _isChecked = true;
      });
      LocalStorage.saveTele(_emailController.text);
      LocalStorage.savePassword(_passwordController.text);
      LocalStorage.saveRemember(_isChecked);
    } else {
      LocalStorage.deletePassword();
      LocalStorage.deleteTele();
      LocalStorage.saveRemember(false);
      setState(() {
        _isChecked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    APILogin _apiLogin;
    APIStations apiStations;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Container(
          color: Color.fromARGB(255, 230, 227, 227),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 83 / 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("./assets/images/image/gp.png"),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 4 / 100,
                vertical: MediaQuery.of(context).size.height * 12 / 100),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Welcome())),
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                          child: Image.asset("./assets/images/logo/logo.png")),
                      Container(
                        child: Text('                           '),
                      )
                    ],
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100),
                  Text(
                    'Connexion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 23 / 100,
            right: 40,
            left: 40,
          ),
          child: Form(
              key: globalFormKey,
              child: Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height * 7 / 100),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 16),
                      prefixIcon: Container(
                        padding: EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 40),
                        child: Text('Email/Tél'),
                      ),
                      errorText: _emailErrorValidator,
                    ),
                    controller: _emailController,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 2 / 100),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(top: 16),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(16),
                        child: Text('Mot de passe'),
                      ),
                      errorText: _passwordErrorvalidator,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      hintStyle: TextStyle(
                        color: Color.fromARGB(137, 2, 2, 2),
                      ),
                    ),
                    controller: _passwordController,
                  ),
                ),
                Visibility(
                  child: Text(
                    _textError,
                    style: TextStyle(color: Colors.red),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _visibilityError,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        'Se souvenir de moi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Switch(
                        value: _isChecked,
                        activeColor: Colors.orange,
                        onChanged: toggleSwitch)
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                      onPressed: () => {},
                      child: Text(
                        'Mot de passe oublier?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      )),
                ),
              ])),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 241, 139, 4).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            child: FlatButton(
              onPressed: () => {
                _loginRequestModel.email_tel = _emailController.text,
                _loginRequestModel.password = _passwordController.text,
                _apiLogin = new APILogin(),
                apiStations = new APIStations(),
                if (_emailController.text.isEmpty &&
                    _passwordController.text.isEmpty)
                  {
                    _visibilityError = false,
                    _emailErrorValidator = 'Tapez votre Email/Tél',
                    _passwordErrorvalidator = 'Tapez votre mot de passe'
                  },
                _apiLogin.login(_loginRequestModel).then((value) async {
                  await GetStorage.init();
                  if (value.token.isNotEmpty) {
                    String tokenValue = value.token;
                    LocalStorage.saveToken('$tokenValue');
                    apiStations.getStations().then((value) async {
                      LocalStorage.saveSerial(value[0]["serial"]);
                    });

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Loading()));
                    await Future.delayed(const Duration(seconds: 5), () {});
                    LocalStorage.getToken();
                    LocalStorage.getSerial();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Navigation()));
                  } else if (value.error.isNotEmpty) {
                    setState(() {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        _emailErrorValidator = "";
                        _passwordErrorvalidator = "";
                        _visibilityError = true;
                        _textError = value.error;
                      }
                    });
                  }
                })
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Color.fromARGB(218, 255, 86, 34),
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text(
                "Connexion",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 3 / 100),
          Container(
            alignment: Alignment.center,
            child: FlatButton(
                onPressed: () => {},
                child: Text(
                  'yobeen.com',
                  style: TextStyle(
                    color: Color.fromARGB(153, 122, 120, 120),
                    fontSize: 14,
                  ),
                )),
          ),
        ])
      ]),
    );
  }
}
