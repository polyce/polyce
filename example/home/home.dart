/**
 * Created by lejard_h on 27/03/16.
 */

@HtmlImport("home.html")
library home;

import "package:polyce/polyce.dart";

@PolyceRoute("Home", "home", isDefault: true)
@PolymerRegister("home-route")
class HomeRoute extends PolymerElement
    with AutonotifyBehavior, Observable, PolymerAppRouteBehavior {
    HomeRoute.created() : super.created();

    enter(RouteEnterEvent event, [Map params]) {

    }
}
