import 'package:hive/hive.dart';
import 'package:minbar_data/models/mosque.model.dart';
import 'package:minbar_data/utils/base_provider.dart';
import 'package:minbar_data/utils/constants.dart';

class AllMosquesProvider extends BaseProvider {
  List<Mosque> _mosques = [];
  List<Mosque> _mosqueToDisplay = [];

  set setMosques(List<Mosque> mosques) {
    _mosques = mosques;
    notifyListeners();
  }

  set setMosquesToDisplay(List<Mosque> mosques) {
    _mosqueToDisplay = mosques;
    notifyListeners();
  }

  List<Mosque> get getMosqueToDisplay => _mosqueToDisplay;

  void initialize() async {
    try {
      setMosques = [];
      print('Refreshing...');
      backToLoading(message: '...');
      await Future.delayed(Duration(seconds: 1));
      var userData = await Hive.openBox(USER_DATA_BOX_KEY);
      var mosques = userData.get(USER_MOSQUES_KEY);
      mosques.forEach((msq) {
        _mosques.add(Mosque.fromJson(msq));
      });
      setMosquesToDisplay = _mosques.take(20).toList();
      backToLoaded();
    } catch (error) {
      print('Error: $error');
      backToErrorOccurred(message: '${error.toString()}');
    }
  }

  AllMosquesProvider() {
    initialize();
  }

  void searchMosques({String searchParam}) async {
    backToLoading(message: 'Searching mosque');
    if (searchParam.isEmpty) {
      print('Search Param is empty');
      setMosquesToDisplay = _mosques.take(20).toList();
    } else {
      setMosquesToDisplay = _mosques.where((element) => element.mosqueName.toLowerCase().contains(searchParam.toString().toLowerCase())).toList();
    }
    backToLoaded();
  }

  void refresh() {
    initialize();
  }
}