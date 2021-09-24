import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minbar_data/models/user.model.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MinbarAppBar(title: PROFILE_TITLE,rightSide: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.red,),
              onPressed: () {
                MessageAlert.ConfirmAlert(context, message: "Do you want to logout?", okText: 'Logout', onOkayPressed: () async {
                  var userBox = await Hive.openBox(USER_DATA_BOX_KEY);
                  userBox.delete(USER_LOGGED_IN_KEY);
                  Navigator.of(context).pushReplacementNamed('/splash');
                });
              },
            ),),

            WatchBoxBuilder(
              box: Hive.box(USER_DATA_BOX_KEY),
              builder: (context, box) {
                var userData = box.get(USER_DETAIL_KEY);
                // print(userData);
                var user = User.fromJson(userData);
                return Column(
                  children: [
                    ListTile(
                      title: Text('Full name'),
                      subtitle: Text('${user.firstName} ${user.lastName}'),
                    ),
                    ListTile(
                      title: Text('Email'),
                      subtitle: Text('${user.email}'),
                    ),
                    ListTile(
                      title: Text('Address'),
                      subtitle: Text('${user.address}'),
                    ),
                    ListTile(
                      title: Text('Phone Number'),
                      subtitle: Text('${user.phoneNumber}'),
                    ),
                    ListTile(
                      title: Text('Organisation'),
                      subtitle: Text('${user.organisation}'),
                    ),
                    Divider(height: 1, thickness: 4, ),
                    // ListTile(
                    //   onTap: () => Navigator.pushNamed(context, '/edit_profile', arguments: user),
                    //   contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    //   title: Text('Edit profile'),
                    //   subtitle: Text('Change your personal information'),
                    //   trailing: Icon(Icons.chevron_right),
                    // ),

                    ListTile(
                      onTap: () => Navigator.pushNamed(context, '/change_password'),
                      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                      title: Text('Change password'),
                      subtitle: Text('Change your password'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    
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