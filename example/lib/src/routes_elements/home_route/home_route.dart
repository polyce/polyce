@HtmlImport("home_route.html")
library example.routes.home_route;

import "package:polyce/polyce.dart";

@PolymerRegister("home-route")
class HomeRoute extends PolymerElement with AutonotifyBehavior, Observable, PolyceRouteBehavior {
  HomeRoute.created() : super.created() {
    initRoute("Home","/", isDefault: true);
  }

  /// Called when an instance of home-route is inserted into the DOM.
  attached() {
    super.attached();
  }

  /// Called when an instance of home-route is removed from the DOM.
  detached() {
    super.detached();
  }

  /// Called when an attribute (such as  a class) of an instance of home-route is added, changed, or removed.
  attributeChanged(String name, String oldValue, String newValue) {
    super.attributeChanged(name, oldValue, newValue);
  }

  /// Called when home-route has been fully prepared (Shadow DOM created, property observers set up, event listeners attached).
  ready() {

  }

  /// Called when PolyceRouter enter on home-route
  enterRoute([Map parameters]) {
  }
}
