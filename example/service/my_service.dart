/**
 * Created by lejard_h on 27/03/16.
 */

library MyService;

import "package:polyce/polyce.dart";
import "../model/data.dart";

@serializable
class MyService extends PolyceService {
  @observable List<String> data = new ObservableList.from(["toto", "titi", "tata"]);
  @observable Data model;

  static MyService _instance;
  MyService._constructor() : super.constructor();
  factory MyService() {
    if (_instance == null) {
      _instance = new MyService._constructor();
    }
    return _instance;
  }

  initialize() {
    model = new Data();
  }
}
