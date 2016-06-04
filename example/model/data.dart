/**
 * Created by lejard_h on 27/03/16.
 */

library data;

import "package:polyce/polyce.dart";

@serializable
class Data extends PolyceModel {
  @observable
  String foo;
  @observable
  List<String> list = new ObservableList.from(["list", "in", "model"]);

  Data([this.foo = "bar"]);
}
