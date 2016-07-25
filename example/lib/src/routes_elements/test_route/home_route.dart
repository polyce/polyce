@HtmlImport("home_route.html")
library example.routes.test_route;

import "package:polyce/polyce.dart";
import "package:example/example.dart";

@PolymerRegister("test-route")
class TestRoute extends PolymerElement
    with AutonotifyBehavior, Observable,  PolyceRouteManager , PolyceRouteBehavior {


  TestRoute.created() : super.created() {
    routeName = "Test";
    routePattern = "/test";
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
  ready() {}

  /// Called when PolyceRouter enter on home-route
  enterRoute([Map parameters]) {

  }
}
