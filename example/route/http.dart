/**
 * Created by lejard_h on 28/03/16.
 */

@HtmlImport("http.html")
library http;

import "package:polyce/polyce.dart";
import "../service/post_service.dart";
import "../model/post.dart";

@PolyceRoute("Http", "http")
@PolymerRegister("http-route")
class HttpRoute extends PolymerElement
    with AutonotifyBehavior, Observable, PolymerAppRouteBehavior {
    HttpRoute.created() : super.created();

    PostService get post_service => Polyce.getService(PostService);

    @property @observable Post post;

    @reflectable
    request(event, [_]) async {
        if (post == null) {
            post = await post_service.get();
        }
    }

    enter(RouteEnterEvent event, [Map params]) {}
}