@HtmlImport("root_element.html")
library root_element;

import "dart:async";
import "package:polyce/polyce.dart";
import "../route/home.dart";
import "../service/my_service.dart";

@PolymerRegister("root-element")
class RootElement extends PolymerElement
    with AutonotifyBehavior, Observable, PolyceRouter {
  RootElement.created() : super.created();

  @observable
  @Property(observer: "pageChanged")
  String selected;

  @reflectable
  pageChanged(String value, String old) {
    if (value != null) {
      PolyceRouter.goToName(value);
    }
  }

  MyService get service => Polyce.getService(MyService);

  ready() {
    new Timer(const Duration(seconds: 3), () {
      service?.data?.addAll([ "truc", "plop", "test"]);
    });
  }
}
