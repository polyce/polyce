library polyce.behaviors.router;

import "dart:html";
import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouterBehavior implements PolyceRouteManager {
  String _selected;

  @Property()
  String get selected => _selected;

  @reflectable
  set selected(val) {
    _selected = val;
    notifyPath("selected", val);

    if (val != null) {
      goToName(val);
    }
  }

  @reflectable
  void goToHome(MouseEvent event, [_]) {
    event.stopPropagation();
    event.preventDefault();
    goToDefault();
  }

  List<PolymerRoute> _routes;

  @property
  List<PolymerRoute> get routes => _routes;

  void set routes(List<PolymerRoute> value) {
    _routes = value;
    notifyPath("routes", value);
  }

  void routeChanged(bool active, dynamic data, Map route) {
    print("routeChanged");
    routes = PolyceRouteManager.routes?.values;

    if (routes?.any((PolymerRoute _route) => _route.active)) {
      PolymerRoute r = routes?.firstWhere((PolymerRoute _route) => _route.isDefault, orElse: () => null);
      selected = r.name;
    } else {
      selected = routes?.firstWhere((PolymerRoute _route) => _route.active)?.name;
    }
  }
}
