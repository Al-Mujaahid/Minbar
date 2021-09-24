import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/EditProfilePage/edit_profile_page_provider.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MinbarAppBar(title: 'Edit profile', rightSide: Container(),),
            Consumer<EditProfilePageProvider>(
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
                          title: Text('First name'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.firstName}',
                            decoration: getInputDecoration(hintText: 'First name'),
                            onChanged: (String string) {
                              value.userData.firstName = string;
                            },
                          ),
                        ),

                        ListTile(
                          title: Text('Last name'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.lastName}',
                            decoration: getInputDecoration(hintText: 'Last name'),
                            onChanged: (String string) {
                              value.userData.lastName = string;
                            },
                          ),
                        ),

                        ListTile(
                          title: Text('Email'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.email}',
                            decoration: getInputDecoration(hintText: 'Email'),
                            onChanged: (String string) {
                              value.userData.email = string;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),

                        ListTile(
                          title: Text('Phone number'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.phoneNumber}',
                            decoration: getInputDecoration(hintText: 'Phone number'),
                            onChanged: (String string) {
                              value.userData.phoneNumber = string;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        ListTile(
                          title: Text('Address'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.address}',
                            decoration: getInputDecoration(hintText: 'Address'),
                            onChanged: (String string) {
                              value.userData.address = string;
                            },
                            maxLines: 3,
                          ),
                        ),

                        ListTile(
                          title: Text('Organisation'),
                          subtitle: TextFormField(
                            initialValue: '${value.userData.organisation}',
                            decoration: getInputDecoration(hintText: 'Organisation'),
                            onChanged: (String string) {
                              value.userData.organisation = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: RaisedButton(
                            child: Text('Update profile'),
                            onPressed: () => value.updateProfile(context),
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