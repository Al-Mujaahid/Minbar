import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minbar_data/pages/AddMosquePage/add_mosque_actions.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';
import 'package:minbar_data/utils/message_alert.dart';

class AddMosqueProvider extends BaseProvider {
  String mosqueName = '';
  String mosqueAddress = '';
  String mosqueImamName = '';
  String mosqueSize = '';
  String mosqueType = '';
  String mosqueState = '';
  String mosqueLCDA = '';
  String userId = '';
  String mosqueMuadhinName = '';
  String mosqueContact = '';
  String mosqueContactOwner = '';
  String lat = '';
  String lng = '';
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
      userId = userBox.get(USER_DETAIL_KEY)['id'];
      print(userId);
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
          lat = event.location.latitude.toString();
          lng = event.location.longitude.toString();
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

  void addMosque(BuildContext ctx) {
    if (mosqueContactOwner.isEmpty || mosqueName.isEmpty || mosqueAddress.isEmpty || mosqueImamName.isEmpty || mosqueContact.isEmpty ) {
      backToErrorOccurred(message: 'All field are required');
      MessageAlert.InfoAlert(context, message: 'All fields are required');
    } else if (mosqueImage == null) {
      backToErrorOccurred(message: 'Mosque image is required');
      MessageAlert.InfoAlert(context, message: 'Mosque image is required');
    } else {
      _addMosque(ctx);
    }
  }

  void _addMosque(BuildContext ctx) async {
    try {
      backToInProgress(message: 'Adding mosque...');
      String fileName = mosqueImage.path.split('/').last;
      var mosqueData = {
        'mosque_image': await MultipartFile.fromFile(mosqueImage.path, filename:fileName),
        'mosque_name': mosqueName, 'local_id': mosqueLCDA, 'state_id': mosqueState, 'mosque_address': mosqueAddress,
        'mosque_phone': mosqueContact, 'mosque_imam_name': mosqueImamName, 'mosque_muadhin_name': mosqueMuadhinName,
        'mosque_size': mosqueSize, 'mosque_type': mosqueType, 'lat': lat, 'lng': lng, 'contact_collected': mosqueContactOwner,
        'user_id': userId
      };
      var addMosqueResponse = await AddMosqueActions.addMosque(mosqueData: mosqueData);
      print(addMosqueResponse);
      if (addMosqueResponse['status'] == true) {
        var userBox = await Hive.openBox(USER_DATA_BOX_KEY);
        userBox.put(USER_TOTAL_LARGE_MOSQUE_KEY, addMosqueResponse['stat']['tl']);
        userBox.put(USER_TOTAL_SMALL_MOSQUE_KEY, addMosqueResponse['stat']['ts']);
        userBox.put(USER_TOTAL_MEDIUM_MOSQUE_KEY, addMosqueResponse['stat']['tm']);
        userBox.put(USER_TOTAL_MOSQUE_KEY, addMosqueResponse['stat']['tt']);
        userBox.put(USER_MOSQUES_KEY, addMosqueResponse['stat']['ttm']);
        MessageAlert.InfoAlert(ctx, message: '${addMosqueResponse['msg']}', onClose: () {
          backToLoaded();
          Navigator.of(context).popAndPushNamed('/');
        });
      } else {
        MessageAlert.InfoAlert(ctx, message: '${addMosqueResponse['msg']}');
      }
    } catch (error) {
      backToErrorOccurred(message: 'Error occurred: $error');
      MessageAlert.InfoAlert(ctx, message: 'Error: $error');
    }
  }

  AddMosqueProvider() {
    initialize();
  }

}
