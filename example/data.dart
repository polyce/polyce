/**
 * Created by lejard_h on 27/03/16.
 */

library data;

import "package:polyce/polyce.dart";

@serializable
class Data extends PolyceModel with Observable {
    @observable String foo;

    Data([this.foo = "bar"]);
}