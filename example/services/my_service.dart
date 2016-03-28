/**
 * Created by lejard_h on 27/03/16.
 */

library MyService;

import "package:polyce/polyce.dart";
import "../data.dart";

@serializable
@service
class MyService extends PolyceService {
  @observable List<String> data = new ObservableList.from(["toto", "titi", "tata"]);
  @observable Data model;

  init() {
    model = new Data();
  }
}
