@HtmlImport("theme.html")
@HtmlImport("root_element.html")
library example.elements.root_element;

import "dart:html";
import "package:polyce/polyce.dart";
import "package:example/example.dart";
import "package:example/routes_elements.dart";

@PolymerRegister("root-element")
class RootElement extends PolymerElement
    with PolyceRouteManager, PolyceRouterBehavior {

  RootElement.created() : super.created();

  AppDrawer get drawer => $['drawer'];

  @property
  String appName = "Polyce App";

  String _selected;

  @Property()
  String get selected => _selected;

  @reflectable
  set selected(val) {
    _selected = val;
    notifyPath("selected", val);

    if (val != null) {
      goToName(val);
      if (!drawer.persistent) drawer.close();
    }
  }


  @reflectable
  void goToHome(MouseEvent event, [_]) {
    event.stopPropagation();
    event.preventDefault();
    if (!drawer.persistent) drawer.close();
    goToDefault();
  }
}
