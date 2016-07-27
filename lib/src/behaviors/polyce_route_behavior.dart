library polyce.behaviors.route;

import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouteBehavior implements PolyceRouteManager {
  bool _routeIsDefault;
  @property
  bool get routeIsDefault => _routeIsDefault;
  set routeIsDefault(val) {
    _routeIsDefault = val;
    notifyPath("routeIsDefault", val);
  }

  String _routePattern;
  @property
  String get routePattern => _routePattern;
  set routePattern(val) {
    _routePattern = val;
    notifyPath("routePattern", val);
  }

  String _routeName;

  set routeName(val) {
    _routeName = val;
    notifyPath("routeName", val);
  }

  @property
  String get routeName => _routeName;

  void routeParametersChanged(bool active, dynamic data, Map route) {
    if (active) {
      parametersRouteChanged(data);
    }
  }

  void routeChanged(bool active, dynamic data, Map route) {
    if (active) {
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
  parametersRouteChanged([Map parameters]);
}
