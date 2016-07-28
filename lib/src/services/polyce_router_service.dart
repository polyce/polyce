/**
 * Created by lejard_h on 23/12/15.
 */

import "package:polyce/polyce.dart";

@Service()
class PolyceRouter extends PolyceService {
  Map<String, PolyceRouteBehavior> routes = {};
  PolyceRouteBehavior defaultRoute;
  PolyceRouterBehavior _router;

  HttpService get httpService => PolyceService.getService(HttpService);

  initRouter(PolyceRouterBehavior router) {
    _router = router;
  }

  PolyceRouter();

  goToPath(String path, {Map<String, dynamic> parameters, Map<String, dynamic> queryParameters}) {
    path = httpService.replaceParameters(path, parameters);
    // path = http_service.addQueryParameters(path, parameters);
    _router.route = {"prefix": "", "path": path, "__queryParams": queryParameters ?? {}};
  }

  goToDefault({Map parameters, Map queryParameters}) {
    String name = routes.values.firstWhere((PolyceRouteBehavior r) => r.routeIsDefault, orElse: () => null)?.routeName;
    goToName(name, parameters: parameters, queryParameters: queryParameters);
  }

  goToName(String name, {Map parameters, Map queryParameters}) {
    if (routes.containsKey(name)) {
      String path = routes[name].routePattern;
      goToPath(path, parameters: parameters, queryParameters: queryParameters);
    }
  }

  String getRouteName(dynamic route) {
    if (routes.values.any((PolyceRouteBehavior _route) => _route.routeActive)) {
      PolyceRouteBehavior r = routes.values.firstWhere((PolyceRouteBehavior _route) => _route.routeIsDefault, orElse: () => null);
      if (r.routeName != null) {
        return r.routeName;
      }
    }
    return routes.values.firstWhere((PolyceRouteBehavior _route) => _route.routeIsDefault, orElse: () => null)?.routeName;
  }

  addRoute(String name, PolyceRouteBehavior route) {
    routes[name] = route;
  }
}
