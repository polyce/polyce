library example.models.my_model;

import "package:polyce/polyce.dart";

class MyModel extends Observable {
  @observable
  String foo;

  @observable
  ObservableList<String> list;

  MyModel();
}
