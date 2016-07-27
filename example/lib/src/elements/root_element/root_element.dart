@HtmlImport("theme.html")
@HtmlImport("root_element.html")
library example.elements.root_element;

import "dart:html";
import "package:polyce/polyce.dart";
import "package:example/example.dart";

@PolymerRegister("root-element")
class RootElement extends PolymerElement with PolyceRouteManager, PolyceRouterBehavior {
  RootElement.created() : super.created();

  AppDrawer get drawer => $['drawer'];

  @property
  String appName = "Polyce App";

  @Observe("selected")
  selectedChanged(val) {
    if (!drawer.persistent) drawer.close();
  }


}
