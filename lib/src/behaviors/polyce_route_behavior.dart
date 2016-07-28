library polyce.behaviors.route;

import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouteBehavior implements PolymerElement {

  PolyceRouter get polyceRouter => PolyceService.getService(PolyceRouter);

  AppRoute appRoute = new AppRoute();

  dynamic _routeData;
  @Property(notify: true, reflectToAttribute: true)
  dynamic get routeData => _routeData;
  set routeData(val) {
    _routeData = val;
    notifyPath("routeData", val);
  }

  bool _routeActive = false;
  @Property(notify: true, reflectToAttribute: true)
  bool get routeActive => _routeActive;
  set routeActive(val) {
    bool old = _routeActive;
    dynamic oldData = routeData;
    routeData = appRoute?.data;
    _routeActive = val;
    notifyPath("routeActive", val);
    showElement(routeActive);
    if (routeActive && (routeActive != old || routeData != oldData)) {
      enterRoute(routeData);
    }
  }

  String _routePattern;

  @Property(reflectToAttribute: true, notify: true)
  String get routePattern => _routePattern;
  set routePattern(value) {
    _routePattern = value;
    notifyPath("routePattern", value);
  }

  dynamic _route;

  @Property(notify: true, reflectToAttribute: true)
  dynamic get route => _route;

  set route(value) {
    _route = value;
    notifyPath("route", value);
    appRoute?.route = route;
    routeActive = appRoute?.active;
    fire('polyce-route-inactive', detail: { "name": routeName, "active": routeActive});
  }

  bool _routeIsDefault;
  @Property(notify: true, reflectToAttribute: true)
  bool get routeIsDefault => _routeIsDefault;
  set routeIsDefault(val) {
    _routeIsDefault = val;
    notifyPath("routeIsDefault", val);
  }

  String _routeName;

  set routeName(val) {
    _routeName = val;
    notifyPath("routeName", val);
  }

  @property
  String get routeName => _routeName;

  showElement([bool show = false]) {
    if (show) {
      (Polymer.dom(this) as PolymerDom).removeAttribute("hidden");
    } else {
      (Polymer.dom(this) as PolymerDom).setAttribute("hidden", "");
    }
  }

  initRoute(String name, String pattern, {bool isDefault: false}) {
    routeName = name;
    routePattern = pattern;
    routeIsDefault = isDefault;
    polyceRouter.addRoute(name, this);
  }

  bool testRoute(dynamic route) {
    appRoute.route = route;
    return routeActive;
  }

  static ready(PolyceRouteBehavior instance) {
    instance.showElement(false);
    instance.appRoute?.setAttribute("pattern", instance.routePattern);
    instance.append(instance.appRoute);
  }

  enterRoute([Map parameters]);
}
/*

class _NullSanitizer implements NodeTreeSanitizer {
  @override
  void sanitizeTree(Node node) {}
}
*/
