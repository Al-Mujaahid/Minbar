import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/AuthPage/ForgetPasswordPage/forget_password_provider.dart';
import 'package:minbar_data/utils/action_status_message.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ForgetPasswordProvider _forgetPasswordProvider = Provider.of<ForgetPasswordProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0, right: 0, left: 0, bottom: 0,
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: 0, right: 0, left: 0,
            child: SingleChildScrollView(
              child: Hero(
                tag: 'auth_pages',
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                  ),
                  child: Column(
                    children: [
                      Text('Forget Password', style: TextStyle(
                          fontSize: 25
                      ),),
                      SizedBox(height: 10,),
                      Consumer<ForgetPasswordProvider>(
                        builder: (context, value, child) {
                          return ActionStatusMessage(actionState: value.getActionState,);
                        },
                      ),
                      Container(
                        padding: INPUT_PADDING,
                        child: Material(
                          color: Colors.transparent,
                          child: TextFormField(
                            initialValue: _forgetPasswordProvider.email,
                            onChanged: (String email) {
                              _forgetPasswordProvider.email = email;
                            },
                            decoration: getInputDecoration(hintText: "Registered Email").copyWith(
                              helperText: 'Input your registered email address'
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                      Container(
                          padding: INPUT_PADDING,
                          child: RaisedButton(
                            onPressed: _forgetPasswordProvider.isLoading() ? null : () => _forgetPasswordProvider.requestPasswordReset(context),
                            child: _forgetPasswordProvider.isLoading() ? CupertinoActivityIndicator() : Text('Request Password Reset'),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
