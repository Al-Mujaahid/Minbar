import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/ChangePasswordPage/change_password_provider.dart';
import 'package:minbar_data/pages/EditProfilePage/edit_profile_page_provider.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MinbarAppBar(title: 'Change Password', rightSide: Container(),),
            Consumer<ChangePasswordProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    if (value.isLoading())
                      ...[
                        Text('${value.getActionState.message}'),
                        CupertinoActivityIndicator(),
                      ],
                    if (!value.isLoading())
                      ...[
                        ListTile(
                          title: Text('Old password'),
                          subtitle: TextFormField(
                            initialValue: '${value.oldPassword}',
                            decoration: getInputDecoration(hintText: 'old password'),
                            onChanged: (String string) {
                              value.oldPassword = string;
                            },
                            obscureText: !value.passwordIsVisible,
                          ),
                        ),

                        ListTile(
                          title: Text('New password'),
                          subtitle: TextFormField(
                            initialValue: '${value.newPassword}',
                            decoration: getInputDecoration(hintText: 'New password'),
                            onChanged: (String string) {
                              value.newPassword = string;
                            },
                            obscureText: !value.passwordIsVisible,
                          ),
                        ),

                        ListTile(
                          title: Text('Confirm password'),
                          subtitle: TextFormField(
                            initialValue: '${value.confirmNewPassword}',
                            decoration: getInputDecoration(hintText: 'Confirm password'),
                            onChanged: (String string) {
                              value.confirmNewPassword = string;
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: !value.passwordIsVisible,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => value.setPasswordIsVisible = !value.passwordIsVisible,
                                child: Text('${value.passwordIsVisible ? 'Hide' : 'Show'} password'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: RaisedButton(
                            child: Text('Change password'),
                            onPressed: () => value.updatePassword(context),
                          ),
                        ),
                      ]
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}