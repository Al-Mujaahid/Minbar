import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minbar_data/pages/AddMosquePage/add_mosque_provider.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class AddMosquePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MinbarAppBar(title: "Add new mosque", rightSide: Container(),),
            Consumer<AddMosqueProvider>(
              builder: (context, value, child) {
                value.setBuildContext = context;
                return Column(
                  children: [
                    SizedBox(height: 10,),
                    if (value.isLoading())
                      ...[
                        CupertinoActivityIndicator(),
                        Text('${value.getStatusMessage}'),
                      ],
                    if (value.isErrorOccurred())
                      ...[
                        Icon(Icons.error),
                        Text('${value.getStatusMessage}')
                      ],
                    if (!value.isLoading())
                      ...[
                        ListTile(
                          title: Text('Mosque name'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueName}',
                            decoration: getInputDecoration(hintText: 'Mosque name'),
                            onChanged: (String string) {
                              value.mosqueName = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text('Mosque address'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueName}',
                            decoration: getInputDecoration(hintText: 'Mosque address'),
                            onChanged: (String string) {
                              value.mosqueAddress = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text('Mosque Imam'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueImamName}',
                            decoration: getInputDecoration(hintText: 'Mosque Imam Name'),
                            onChanged: (String string) {
                              value.mosqueImamName = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text('Mosque Muadhin Name'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueMuadhinName}',
                            decoration: getInputDecoration(hintText: 'Mosque Muadhin Name'),
                            onChanged: (String string) {
                              value.mosqueMuadhinName = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text('Mosque Contact'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueContact}',
                            decoration: getInputDecoration(hintText: 'Mosque Contact'),
                            onChanged: (String string) {
                              value.mosqueContact = string;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Text('Mosque Contact Owner'),
                          subtitle: TextFormField(
                            initialValue: '${value.mosqueContactOwner}',
                            decoration: getInputDecoration(hintText: 'Mosque Contact Owner'),
                            onChanged: (String string) {
                              value.mosqueContactOwner = string;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),

                        ListTile(
                          title: Text('Mosque Type'),
                          subtitle: SmartSelect.single(
                            modalType: S2ModalType.bottomSheet,
                            value: '${value.mosqueType}',
                            choiceItems: [
                              S2Choice(value: 'ratibi', title: 'Ratibi Mosque'),
                              S2Choice(value: 'jummah', title: 'Jummah Mosque'),
                              S2Choice(value: 'both', title: 'Ratibi and Jummah Mosque'),
                            ],
                            title: 'Select mosque type',
                            onChange: (val) {
                              if (val.value != null) {
                                value.mosqueType = val.value;
                              }
                            },
                          ),
                        ),

                        ListTile(
                          title: Text('Mosque Size'),
                          subtitle: SmartSelect.single(
                            modalType: S2ModalType.bottomSheet,
                            value: '${value.mosqueSize}',
                            choiceItems: [
                              S2Choice(value: 'small', title: 'Small Size Mosque (30 - 50 Musallaat)'),
                              S2Choice(value: 'medium', title: 'Medium Size Mosque (51 - 150 Musallaat)'),
                              S2Choice(value: 'large', title: 'Large Size Mosque (151 and above Musallaat)'),
                            ],
                            title: 'Select mosque size',
                            onChange: (val) {
                              if (val.value != null) {
                                value.mosqueSize = val.value;
                              }
                            },
                          ),
                        ),

                        ListTile(
                          title: Text('Mosque State'),
                          subtitle: SmartSelect.single(
                            value: '${value.mosqueState}',
                            choiceItems: [
                              ...value.states.map((e) {
                                return S2Choice(value: e['id'], title: e['name']);
                              })
                            ],
                            title: 'Select mosque state',
                            onChange: (val) {
                              print("selected: ${val.value}");
                              if (val.value != null) {
                                value.mosqueState = val.value;
                                value.getLCDA(stateId: val.value);
                              }
                            },
                          ),
                        ),

                        ListTile(
                          title: Text('Mosque LCDA'),
                          subtitle: SmartSelect.single(
                            value: '${value.mosqueLCDA}',
                            choiceItems: [
                              ...value.lcdas.map((e) {
                                return S2Choice(value: e['local_id'], title: e['local_name']);
                              })
                            ],
                            title: 'Select mosque lcda',
                            onChange: (val) {
                              if (val.value != null) {
                                value.mosqueLCDA = val.value;
                              }
                            },
                          ),
                        ),

                        ListTile(
                          leading: value.mosqueImage == null ? Image.asset('assets/images/icons/mosque.png', height: 30, width: 30,) : GestureDetector(
                            child: Image.file(value.mosqueImage, height: 30, width: 30,),
                            onTap: () => value.showSelectedImage(context),
                          ),
                          title: Text('Select/Capture Mosque Picture'),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () => value.selectImage(context, ImageSource.camera),
                                ),
                                IconButton(
                                  icon: Icon(Icons.image),
                                  onPressed: () => value.selectImage(context, ImageSource.gallery),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 25,),

                        Container(
                          child: RaisedButton(
                            child: Text('Add mosque'),
                            onPressed: () => value.addMosque(context),
                          ),
                        ),
                      ],
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
