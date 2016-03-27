/**
 * Created by lejard_h on 27/03/16.
 */

@HtmlImport("home.html")
library home;

import "dart:async";
import "package:polyce/polyce.dart";
import "../services/my_service.dart";


@PolyceRoute("Home", "home", isDefault: true)
@PolymerRegister("home-route")
class HomeRoute extends PolymerElement
    with AutonotifyBehavior, Observable, PolymerAppRouteBehavior {
    HomeRoute.created() : super.created();

    MyService get service => Polyce.getService(MyService);

    @observable
    @property
    List<String> get data => service?.data;

    enter(RouteEnterEvent event, [Map params]) {
        new Timer(const Duration(seconds: 3), () {
            service?.data = [ "truc", "plop", "test"];
            notifyPath("data", service?.data);
        });
    }
}
