import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minbar_data/models/mosque.model.dart';
import 'package:minbar_data/pages/AddMosquePage/add_mosque_actions.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';

class EditMosqueProvider extends BaseProvider {
  Mosque mosque;
  List states = [];
  List lcdas = [];
  File mosqueImage;

  set setStates(List sta) {
    states = sta;
    notifyListeners();
  }

  set setMosqueImage(File image) {
    mosqueImage = image;
    notifyListeners();
  }

  set setLCDAs(List lcds) {
    lcdas = lcds;
    notifyListeners();
  }


  initialize() async {
    try {
      var userBox = await Hive.openBox(USER_DATA_BOX_KEY);
      mosque.userId = userBox.get(USER_DETAIL_KEY)['id'];
      // print(userId);
      listenToLocation();
      var statesResponse = await AddMosqueActions.getState();
      setStates = statesResponse['data'];
      // print(statesResponse);
      backToLoaded();
    } catch (error) {
      backToErrorOccurred(message: 'Network or internet error occurred');
    }
  }

  void getLCDA({stateId}) async {
    // print("I am getting lcda");
    if (stateId.toString().isNotEmpty) {
      try {
        backToLoading(message: 'Getting selected state lcda...');
        var lcdaResponse = await AddMosqueActions.getStateLCDA(stateId: stateId);
        setLCDAs = lcdaResponse['data'];
        backToLoaded();
      } catch (error) {
        backToErrorOccurred(message: 'Error getting state lcda: $error');
      }
    }
  }

  void listenToLocation() async {
    backToLoading(message: 'Getting current location...');
    try {
      Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen((event) {
        if (event.isSuccessful) {
          mosque.mosqueLat = event.location.latitude.toString();
          mosque.mosqueLng = event.location.longitude.toString();
        } else {
          backToErrorOccurred(message: "An error occurred!, Please enable your location and come back here to try again");
        }
      });
    } catch (error) {
      backToErrorOccurred(message: "An error occurred!. Error: ${error.toString()}");
    }
  }

  void showSelectedImage(BuildContext ctx) {
    showBottomSheet(
      context: ctx,
      builder: (context) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Swipe down or press the back button to dismiss this page')
                ),
                SizedBox(height: 20,),
                Image.file(mosqueImage),
              ],
            ),
          ),
        );
      },
    );
  }

  void selectImage(BuildContext ctx, ImageSource source) async {
    PickedFile pickedFile = await ImagePicker.platform.pickImage(source: source);
    if (pickedFile != null) {
      print(pickedFile);
      setMosqueImage = File(pickedFile.path);
      showSelectedImage(ctx);
    }
  }

  void updateMosque(BuildContext ctx) {
    if (mosque.mosqueContact.isEmpty || mosque.mosqueName.isEmpty || mosque.mosqueAddress.isEmpty || mosque.mosqueImamName.isEmpty || mosque.mosqueContactOwner.isEmpty ) {
      backToErrorOccurred(message: 'All field are required');
      MessageAlert.InfoAlert(context, message: 'All fields are required');
    }
    // else if (mosqueImage == null) {
    //   backToErrorOccurred(message: 'Mosque image is required');
    //   MessageAlert.InfoAlert(context, message: 'Mosque image is required');
    // }
    else {
      _updateMosque(ctx);
    }
  }

  void _updateMosque(BuildContext ctx) async {
    try {
      backToInProgress(message: 'Updating mosque...');
      // if ()
      Map<String, dynamic> mosqueData = {};
      if (mosqueImage != null) {
        String fileName = mosqueImage.path.split('/').last;
        mosqueData = {
          'mosque_image': await MultipartFile.fromFile(mosqueImage.path, filename:fileName),
          'mosque_name': mosque.mosqueName, 'local_id': mosque.mosqueLCDA, 'state_id': mosque.mosqueState, 'mosque_address': mosque.mosqueAddress,
          'mosque_phone': mosque.mosqueContact, 'mosque_imam_name': mosque.mosqueImamName, 'mosque_muadhin_name': mosque.mosqueMuadhin,
          'mosque_size': mosque.mosqueSize, 'mosque_type': mosque.mosqueType, 'lat': mosque.mosqueLat, 'lng': mosque.mosqueLng, 'contact_collected': mosque.mosqueContactOwner,
          'user_id': mosque.userId, 'id': mosque.id
        };
      } else {
        mosqueData = {
          'mosque_name': mosque.mosqueName, 'local_id': mosque.mosqueLCDA, 'state_id': mosque.mosqueState, 'mosque_address': mosque.mosqueAddress,
          'mosque_phone': mosque.mosqueContact, 'mosque_imam_name': mosque.mosqueImamName, 'mosque_muadhin_name': mosque.mosqueMuadhin,
          'mosque_size': mosque.mosqueSize, 'mosque_type': mosque.mosqueType, 'lat': mosque.mosqueLat, 'lng': mosque.mosqueLng, 'contact_collected': mosque.mosqueContactOwner,
          'user_id': mosque.userId, 'id': mosque.id
        };
      }
      var updateMosqueResponse = await AddMosqueActions.updateMosque(mosqueData: mosqueData);
      print(updateMosqueResponse);
      if (updateMosqueResponse['status'] == true) {
        var userBox = await Hive.openBox(USER_DATA_BOX_KEY);
        userBox.put(USER_TOTAL_LARGE_MOSQUE_KEY, updateMosqueResponse['stat']['tl']);
        userBox.put(USER_TOTAL_SMALL_MOSQUE_KEY, updateMosqueResponse['stat']['ts']);
        userBox.put(USER_TOTAL_MEDIUM_MOSQUE_KEY, updateMosqueResponse['stat']['tm']);
        userBox.put(USER_TOTAL_MOSQUE_KEY, updateMosqueResponse['stat']['tt']);
        userBox.put(USER_MOSQUES_KEY, updateMosqueResponse['stat']['ttm']);
        MessageAlert.InfoAlert(ctx, message: '${updateMosqueResponse['msg']}', onClose: () {
          backToLoaded();
          Navigator.pop(context);
        });
      } else {
        backToErrorOccurred(message: '${updateMosqueResponse['msg']}');
        MessageAlert.InfoAlert(ctx, message: '${updateMosqueResponse['msg']}');
      }
    } catch (error) {
      backToErrorOccurred(message: 'Error occurred: $error');
      MessageAlert.InfoAlert(ctx, message: 'Error: $error');
    }
  }

  EditMosqueProvider({Mosque mosqueData}) {
    mosque = mosqueData;
    getLCDA(stateId: mosque.mosqueState);
    initialize();
  }

}
