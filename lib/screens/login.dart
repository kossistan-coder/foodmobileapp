import 'package:flutter/material.dart';
import 'package:foodmobileapp/models/api_response.dart';
import 'package:foodmobileapp/models/user.dart';
import 'package:foodmobileapp/screens/home.dart';
import 'package:foodmobileapp/screens/register.dart';
import 'package:foodmobileapp/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          color: Colors.orange,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login into your account",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          "Sign up here",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [LoginForm()],
                      )),
                    ),
                  ))
            ],
          ),
        ))));
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  RegExp exp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  bool loading = false;
  void _loginAndRedirectToHome() async {
    ApiResponse response = ApiResponse();

    response = await login(_txtEmail.text, _txtPassword.text);
    if (response.message == null) {
      setRoot(response.data as User);
      var root = await getUserRoot();
      if (root == 0) {
        _saveAndRedirectToHome(response.data as User);
      } else {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Les comptes administrateurs n'ont pas le droit d'acces")));
      }
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${response.message}")));
    }
  }

  void setRoot(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('root', user.root ?? 2);
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.token ?? '');
    prefs.setInt('userId', user.id ?? 2);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _txtEmail,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "The email blank must not be empty";
                } else if (!exp.hasMatch(value)) {
                  return "Email incorrect";
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _txtPassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please fill the field";
                } else if (value.length < 8) {
                  return "Password length must be more than 8";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Enter your password",
                  border: OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(
                      obscureText == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  )),
              obscureText: obscureText,
            ),
            SizedBox(
              height: 30,
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                          _loginAndRedirectToHome();
                        });
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                        minimumSize: Size(double.infinity, 40)),
                  ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text("I don't have  an account"),
                GestureDetector(
                  child: Text(
                    " sign in ",
                    style: TextStyle(color: Colors.cyan),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Register()),
                        (route) => false);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
