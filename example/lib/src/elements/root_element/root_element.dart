@HtmlImport("theme.html")
@HtmlImport("root_element.html")
library example.elements.root_element;

import "package:polyce/polyce.dart";
import "package:example/example.dart";

@PolymerRegister("root-element")
class RootElement extends PolymerElement with PolyceRouterBehavior {
  RootElement.created() : super.created() {
    initRouter();
  }

  AppDrawer get drawer => $['drawer'];

  @property
  String appName = "Polyce App";

  @Observe("selected")
  selectedChanged(val) {
    if (!drawer.persistent) drawer.close();
  }


}
