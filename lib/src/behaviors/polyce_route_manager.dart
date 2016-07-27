/**
 * Created by lejard_h on 24/07/16.
 */
library polyce.behaviors.route_manager;

import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouteManager {
  static Map<String, PolymerRoute> routes = {};

  dynamic _data;
  @property
  dynamic get data => _data;
  set data(val) {
    _data = val;
    notifyPath("data", val);
    routeParametersChanged(active, data, route);
  }

  bool _active = false;
  bool get active => _active;
  set active(val) {
    _active = val;
    notifyPath("active", val);
    routeChanged(active, data, route);
  }

  Map _route;

  @property
  Map get route => _route;

  set route(value) {
    _route = value;
    notifyPath("route", value);
  }

  void routeChanged(bool active, dynamic data, Map route);
  void routeParametersChanged(bool active, dynamic data, Map route);

  goToPath(String path, {Map<String, dynamic> parameters, Map<String, dynamic> queryParameters}) {
    path = http_service.replaceParameters(path, parameters);
    path = http_service.addQueryParameters(path, parameters);
    route["path"] = path;
    notifyPath("route.path", path);
  }

  goToDefault({Map parameters, Map queryParameters}) {
    String name = PolyceRouteManager.routes.values.firstWhere((PolymerRoute r) => r.isDefault, orElse: () => null)?.name;
    goToName(name, parameters: parameters, queryParameters: queryParameters);
  }

  goToName(String name, {Map parameters, Map queryParameters}) {
    String path = PolyceRouteManager.routes[name].pattern;
    goToPath(path, parameters: parameters, queryParameters: queryParameters);
  }

}
