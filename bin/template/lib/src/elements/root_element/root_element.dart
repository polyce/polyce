@HtmlImport("theme.html")
@HtmlImport("root_element.html")
library __projectName__.elements.root_element;

import "dart:html";
import "package:polyce/polyce.dart";
import "package:__projectName__/__projectName__.dart";

@PolymerRegister("root-element")
class RootElement extends PolymerElement
    with AutonotifyBehavior, Observable, PolyceRouter {
  RootElement.created() : super.created();

  PaperDrawerPanel get drawer => $['drawerPanel'];

  @observable
  @Property(observer: "pageChanged")
  String selected;
  @reflectable
  pageChanged(String value, String old) {
    if (value != null) {
      drawer.closeDrawer();
      PolyceRouter.goToName(value);
    }
  }


  @reflectable
  void goToHome(MouseEvent event, [_]) {
    event.stopPropagation();
    event.preventDefault();
    drawer.closeDrawer();
    PolyceRouter.goToDefault();
  }
}
