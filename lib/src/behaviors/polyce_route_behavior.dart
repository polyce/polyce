library polyce.behaviors.route;

import "dart:html";
import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouteBehavior implements PolyceRouteManager {
  @property
  bool routeIsDefault;

  @property
  String routePattern;

  @property
  String routeName;

  void routeChanged(bool active, dynamic data) {
    if (!active) {
      (Polymer.dom(this) as PolymerDom).removeAttribute("hidden");
    } else {
      (Polymer.dom(this) as PolymerDom).setAttribute("hidden", null);
    }

    if (active) {
      enterRoute(data);
    }
  }

  static ready(PolyceRouteBehavior instance) {
    PolyceRouteManager.routes[instance.routeName] = new PolymerRoute(instance.routeName, instance.routePattern, isDefault: instance.routeIsDefault);
  }

  enterRoute([Map parameters]);
}
