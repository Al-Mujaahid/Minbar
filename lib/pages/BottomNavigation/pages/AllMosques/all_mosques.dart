import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/all_mosque_provider.dart';
import 'package:minbar_data/pages/BottomNavigation/pages/AllMosques/one_mosque.dart';
import 'package:minbar_data/partals/app_bar.dart';
import 'package:minbar_data/utils/styles.dart';
import 'package:provider/provider.dart';

class AllMosques extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AllMosquesProvider>(
          builder: (context, value, child) {
            // print("ActionStatus: ${value.getActionState.actionStatus}");
            return Column(
              children: [
                MinbarAppBar(
                  title: "All Mosques",
                  rightSide: OutlineButton(
                    onPressed: () => Navigator.of(context).pushNamed('/add_mosque'),
                    child: Text('Add mosque'),
                    // tooltip: 'Add new mosque',
                  ),
                ),
                
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, width: .5
                      )
                    )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: getInputDecoration(hintText: 'Search mosque here by name...').copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10)
                          ),
                          onChanged: (String searchParam) {
                            value.searchMosques(searchParam: searchParam);
                          },
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            value.isLoading() ? CupertinoActivityIndicator() : IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () => value.refresh(),
                              tooltip: 'Refresh',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (value.isLoading())
                  ...[
                    CupertinoActivityIndicator()
                  ],
                ...value.getMosqueToDisplay.map((e) {
                  return OneMosque(mosque: e,);
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}