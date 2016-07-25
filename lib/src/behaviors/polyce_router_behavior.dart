library polyce.behaviors.router;

import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouterBehavior implements PolyceRouteManager {
  bool _routeReady;

  @property
  bool get routeReady => _routeReady;

  set routeReady(value) {
    _routeReady = value;
    notifyPath("routeReady", true);
  }

  List<PolymerRoute> _routes;

  @property
  List<PolymerRoute> get routes => _routes;

  void set routes(List<PolymerRoute> value) {
    _routes = value;
    notifyPath("routes", value);
  }

  static ready(PolyceRouterBehavior instance) {
    instance.routes = PolyceRouteManager.routes.values;
    instance.routeReady = true;
  }

  @reflectable
  String activeRoute(_) {
    PolymerRoute r = routes?.firstWhere((PolymerRoute route) => route.active, orElse: () => null);
    if (r == null) {
      r = routes?.firstWhere((PolymerRoute route) => route.isDefault, orElse: () => null);
      goToDefault();
    }
    return r?.name;
  }

}
