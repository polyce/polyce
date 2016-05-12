/**
 * Created by lejard_h on 28/03/16.
 */

library post_service;

import "dart:async";
import "package:polyce/polyce.dart";
import "../model/post.dart";

@serializable
class PostService extends PolyceService {

    HttpService get _http => Polyce.http_service;

    String get _request => "http://jsonplaceholder.typicode.com/posts/1";

    @observable Post post;

    static PostService _instance;
    PostService._constructor() : super.constructor();
    factory PostService() {
        if (_instance == null) {
            _instance = new PostService._constructor();
        }
        return _instance;
    }


    Future<Post> get() async {
        HttpResponse res = await _http.get(_request, decodeType: Post);
        if (res.statusCode == 200) {
            return res.convertedBody;
        }
        return null;
    }

    initialize() {

    }

}