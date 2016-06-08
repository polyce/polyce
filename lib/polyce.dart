/**
 * Created by lejard_h on 23/03/16.
 */

library polyce;

import "dart:html";

import "package:polymer/polymer.dart";
import "package:reflectable/reflectable.dart";
import "package:initialize/initialize.dart" as init;
import "package:route_hierarchical/client.dart";
import "package:polymer_app_router/polymer_app_router.dart";
import "package:observe/observe.dart";
import "package:polymer_autonotify/polymer_autonotify.dart";


export "package:observe/observe.dart";
export 'package:polymer/polymer.dart';
export "package:polymer_app_router/polymer_app_router.dart";
export "package:route_hierarchical/client.dart";
export "package:polymer_autonotify/polymer_autonotify.dart";
export "package:web_components/web_components.dart" show HtmlImport;

export "src/services/http_service.dart";

part "src/polyce_model.dart";
part "src/polyce_route.dart";
part "src/polyce_router.dart";
part "src/polyce_service.dart";


class Polyce {
    static reset() {
        _services.clear();
    }

    static Map<Type, PolyceService> _services = new Map();

    static PolyceService getService(Type type) {
        if (_services.containsKey(type)) {
            return _services[type];
        }
        return null;
    }

    static registerService(Type type, PolyceService service) {
        if (_services.containsKey(type)) {
            throw "$type already exist";
        }
        _services[type] = service;
    }

    static initAllServices() async {
        for (var type in _services.keys) {
            await _services[type].initialize();
        }
    }

}


initServices() async {
    Polyce.reset();
    for (var classMirror in service.annotatedClasses) {
        if (!classMirror.isAbstract && classMirror.reflectedType != PolyceModel) {
            classMirror.newInstance('', []);
        }
    }
    await Polyce.initAllServices();
}


initPolyce() async {
    await initServices();
    await initPolymer();
}