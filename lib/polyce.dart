/**
 * Created by lejard_h on 23/03/16.
 */

library polyce;

import "dart:async";
import "dart:convert";
import "dart:html";

import 'package:http/http.dart';
import "package:http/browser_client.dart";
import "package:polymer/polymer.dart";
import "package:reflectable/reflectable.dart";
import "package:initialize/initialize.dart" as init;
import "package:route_hierarchical/client.dart";
import "package:polymer_app_router/polymer_app_router.dart";
import "package:serializer/serializer.dart";
import "package:observe/observe.dart";
import "package:polymer_autonotify/polymer_autonotify.dart";

export 'package:polymer/polymer.dart';
export "package:polymer_app_router/polymer_app_router.dart";
export "package:route_hierarchical/client.dart";
export "package:serializer/serializer.dart";
export "package:observe/observe.dart";
export "package:polymer_autonotify/polymer_autonotify.dart";
export "dart:html";
export "package:web_components/web_components.dart" show HtmlImport;

part "src/polyce_model.dart";
part "src/polyce_route.dart";
part "src/polyce_router.dart";
part "src/polyce_service.dart";
part "src/manager.dart";
part "src/services/http_service.dart";
part "src/utils.dart";


initPolyce() async {
    await initSerializer(max_superclass: PolyceModel);
    await initServices();
    await initPolymer();
}