import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/AuthPage/LoginPage/login_provider.dart';
import 'package:minbar_data/utils/action_status_message.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  Provider.of<LoginPageProvider>(context, listen: false).setBuildContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Center(
                child: Transform.rotate(
                  angle: 120,
                  child: Text("Minbar Data", style: TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w900
                  ),),
                ),
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.9),
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              child: SingleChildScrollView(
                child: Consumer<LoginPageProvider>(
                  builder: (context, loginPageProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Welcome back', style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700
                        ),),
                        SizedBox(height: 2,),
                        Text('login to continue', style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w300
                        ),),
                        SizedBox(height: 10,),
                        Divider(),
                        SizedBox(height: 10,),
                        ActionStatusMessage(actionState: loginPageProvider.getActionState,),
                        SizedBox(height: 20,),
                        TextFormField(
                          initialValue: loginPageProvider.email,
                          onChanged: (String email) {
                            loginPageProvider.setEmail = email;
                          },
                          decoration: getInputDecoration(hintText: "Email"),
                        ),
                        SizedBox(height: 16,),
                        TextFormField(
                          initialValue: loginPageProvider.password,
                          onChanged: (String password) {
                            loginPageProvider.setPassword = password;
                          },
                          decoration: getInputDecoration(hintText: "Password"),
                          obscureText: !loginPageProvider.passwordIsVisible,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => loginPageProvider.setPasswordIsVisible = !loginPageProvider.passwordIsVisible,
                              child: Consumer<LoginPageProvider>(
                                builder: (context, value, child) {
                                  return Text('${value.passwordIsVisible ? 'Hide' : 'Show'} Password');
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).pushNamed('/forget_password'),
                              child: Text('Forget password'),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        ElevatedButton(
                          onPressed: loginPageProvider.isLoading() ? null : () => loginPageProvider.login(context),
                          child: loginPageProvider.isLoading() ? CupertinoActivityIndicator() : Text('Login'),
                        ),
                        SizedBox(height: 40),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black54, fontSize: 17),
                                children: [
                                  TextSpan(
                                      text: 'Don\'t have an account? '
                                  ),
                                  TextSpan(
                                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, decoration: TextDecoration.underline),
                                      text: 'Register',
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        print("I am here o");
                                        Navigator.of(context).pushNamedAndRemoveUntil('/register', (route) => false);
                                      }
                                  ),
                                ]
                            )
                        )
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}