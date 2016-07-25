/**
 * Created by lejard_h on 24/07/16.
 */
library polyce.behaviors.route_manager;

import "package:polyce/polyce.dart";

@behavior
abstract class PolyceRouteManager {

  static Map<String, PolymerRoute> routes = {};

  Map _route;

  @property
  Map get route => _route;

  set route(value) {
    _route = value;
    notifyPath("route", value);
    routeChanged(get("active"), get("data"));
  }

  void routeChanged(bool active, dynamic data);

  goToPath(String path, {Map<String, dynamic> parameters, Map<String, dynamic> queryParameters}) {
    path = http_service.replaceParameters(path, parameters);
    path = http_service.addQueryParameters(path, parameters);
    route["path"] = path;
    notifyPath("route.path", path);
  }

  goToDefault(
    {Map parameters,
    Map queryParameters})  {
    String name = PolyceRouteManager.routes.values.firstWhere((PolymerRoute r) => r.isDefault, orElse: () => null)?.name;
    goToName(name, parameters: parameters, queryParameters: queryParameters);
  }

  goToName(String name,
    {Map parameters,
    Map queryParameters})  {

    String path = PolyceRouteManager.routes[name].pattern;

    goToPath(path, parameters: parameters, queryParameters: queryParameters);
  }

}