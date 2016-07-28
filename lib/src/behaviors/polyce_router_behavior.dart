library polyce.behaviors.router;

import "dart:html";
import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouterBehavior implements PolymerElement {

  PolyceRouter get polyceRouter => PolyceService.getService(PolyceRouter);

  String _selected;

  @Property(notify: true)
  String get selected => _selected;

  @reflectable
  set selected(val) {
    _selected = val;
    notifyPath("selected", val);
    if (val != null) {
      polyceRouter.goToName(val);
    }
  }

  @reflectable
  void goToHome(MouseEvent event, [_]) {
    event.stopPropagation();
    event.preventDefault();
    polyceRouter.goToDefault();
  }

  dynamic _route;

  @Property(notify: true)
  dynamic get route => _route;

  Map<String, dynamic> _routeTester = new Map<String, dynamic>();

  set route(value) {
    _route = value;
    notifyPath("route", value);
    _routeTester.clear();
    for (String key in polyceRouter.routes.keys) {
      _routeTester[key] = false;
    }
  }

  @Listen('polyce-route-inactive')
  needToGoDefault(CustomEventWrapper event, [_]) {
    Map<String, dynamic> detail = event.detail;

    if (_routeTester.isNotEmpty) {
        if (detail["active"]) {
        _routeTester.isEmpty;
      } else {
        _routeTester[detail["name"] as String] = true;
      }
      if (_routeTester.values.every((bool t) => t)) {
        selected = polyceRouter.getRouteName(route);
      }
    }
  }

  initRouter() {
    polyceRouter.initRouter(this);
  }
}
