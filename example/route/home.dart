/**
 * Created by lejard_h on 27/03/16.
 */

@HtmlImport("home.html")
library home;

import "package:polyce/polyce.dart";
import "../service/my_service.dart";
import "../service/post_service.dart";
import "../model/data.dart";
import "../model/post.dart";

@PolyceRoute("Home", "home", isDefault: true)
@PolymerRegister("home-route")
class HomeRoute extends PolymerElement
    with AutonotifyBehavior, Observable, PolymerAppRouteBehavior {
    HomeRoute.created() : super.created();

    MyService get service => Polyce.getService(MyService);
    PostService get post_service => Polyce.getService(PostService);

    @property
    @observable
    List<String> get data => service?.data;

    @property
    @observable
    Data get model => service?.model;

    @property
    @observable
    Post post;

    enter(RouteEnterEvent event, [Map params]) async  {
        if (post == null) {
            post = await post_service.get();
        }
    }
}
