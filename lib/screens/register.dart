import 'package:flutter/material.dart';
import 'package:foodmobileapp/screens/login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);
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
              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create account",style: TextStyle(fontSize: 20,color: Colors.white),),
                      Text("Sign up here",style: TextStyle(color: Colors.white),),
                  ],
                ),
              )
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                 
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,right: 20,),
                    child: Center(
                      
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          RegisterForm()
                        ],
                      )
                    ),
                    ),
                )
                )
          ],
        ),
      )
    )));
  }
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formkey = GlobalKey<FormState>();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: "Enter your name",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Enter your email",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
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
                  obscureText == true ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              )),
          obscureText: obscureText,
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(
              labelText: "Confirm your password",
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                  FocusScope.of(context).unfocus();
                },
                child: Icon(
                  obscureText == true ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              )),
          obscureText: obscureText,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
          style:
              ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40)),
        ),
        Row(
          children: [
            SizedBox(
              height: 40,
            ),
            Text("I  have  already an account"),
            GestureDetector(
              child: Text(
                " log in ",
                style: TextStyle(color: Colors.cyan),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
              },
            ),
          ],
        )
      ],
    ));
  }
}
