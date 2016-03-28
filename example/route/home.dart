/**
 * Created by lejard_h on 27/03/16.
 */

@HtmlImport("home.html")
library home;

import "package:polyce/polyce.dart";
import "../service/my_service.dart";
import "../model/data.dart";

@PolyceRoute("Home", "home", isDefault: true)
@PolymerRegister("home-route")
class HomeRoute extends PolymerElement
    with AutonotifyBehavior, Observable, PolymerAppRouteBehavior {
  HomeRoute.created() : super.created();

  MyService get service => Polyce.getService(MyService);

  @property
  @observable
  List<String> get data => service?.data;

  @property
  @observable
  Data get model => service?.model;

  enter(RouteEnterEvent event, [Map params]) {
    service?.data?.addAll(["truc", "plop", "test"]);
  }
}
