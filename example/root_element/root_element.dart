@HtmlImport("root_element.html")
library root_element;

import "package:polyce/polyce.dart";

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

  @reflectable
  home(event, [_]) {
    PolyceRouter.goToName("Home");
  }

  @reflectable
  http(event, [_]) {
    PolyceRouter.goToName("Http");
  }

}
