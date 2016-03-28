/**
 * Created by lejard_h on 28/03/16.
 */

library post;

import "package:polyce/polyce.dart";

@serializable
class Post extends PolyceModel {
    @observable int userId;
    @observable int id;
    @observable String title;
    @observable String body;
}