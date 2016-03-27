/**
 * Created by lejard_h on 27/03/16.
 */

library MyService;

import "package:polyce/polyce.dart";

@serializable
@service
class MyService extends PolyceService {
  @observable List<String> data = ["toto", "titi", "tata"];
}
