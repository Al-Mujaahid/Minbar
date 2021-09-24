import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/AuthPage/RegisterPage/register_provider.dart';
import 'package:minbar_data/utils/action_status_message.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<RegisterPageProvider>(context, listen: false).setBuildContext =
        context;
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
                  child: Text(
                    "Minbar Data",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white.withOpacity(0.9),
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              child: SingleChildScrollView(
                child: Consumer<RegisterPageProvider>(
                  builder: (context, registerPageProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'We will be glad to have you onboard',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        ActionStatusMessage(
                          actionState: registerPageProvider.getActionState,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Expanded(
                              child: TextFormField(
                            initialValue: registerPageProvider.fname,
                            onChanged: (String email) {
                              registerPageProvider.setFirstName = email;
                            },
                            decoration:
                                getInputDecoration(hintText: "First name"),
                          )),
                          SizedBox(width: 10),
                          Expanded(
                              child: TextFormField(
                            initialValue: registerPageProvider.lname,
                            onChanged: (String email) {
                              registerPageProvider.setLastName = email;
                            },
                            decoration:
                                getInputDecoration(hintText: "Last name"),
                          ))
                        ]),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: registerPageProvider.email,
                          onChanged: (String email) {
                            registerPageProvider.setEmail = email;
                          },
                          decoration: getInputDecoration(hintText: "Email"),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: registerPageProvider.phone,
                          onChanged: (String password) {
                            registerPageProvider.setPhone = password;
                          },
                          decoration:
                              getInputDecoration(hintText: "Phone number"),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          initialValue: registerPageProvider.password,
                          onChanged: (String password) {
                            registerPageProvider.setPassword = password;
                          },
                          decoration: getInputDecoration(hintText: "Password"),
                          obscureText: !registerPageProvider.passwordIsVisible,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () =>
                                  registerPageProvider.setPasswordIsVisible =
                                      !registerPageProvider.passwordIsVisible,
                              child: Consumer<RegisterPageProvider>(
                                builder: (context, value, child) {
                                  return Text(
                                      '${value.passwordIsVisible ? 'Hide' : 'Show'} Password');
                                },
                              ),
                            ),
                            // InkWell(
                            //   onTap: () => Navigator.of(context).pushNamed('/forget_password'),
                            //   child: Text('Forget password'),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          onPressed: registerPageProvider.isLoading()
                              ? null
                              : () => registerPageProvider.register(context),
                          child: registerPageProvider.isLoading()
                              ? CupertinoActivityIndicator()
                              : Text('Register'),
                        ),
                        SizedBox(height: 40),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 17),
                                children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline),
                                  text: 'Login',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print("I am here o");
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/login', (route) => false);
                                    }),
                            ]))
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
