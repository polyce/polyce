library polyce.core;

import "package:polyce/polyce.dart";

class PolymerRoute extends JsProxy {
  @reflectable
  String name;

  @reflectable
  String pattern;

  @reflectable
  String prefix;

  @reflectable
  Map<String, dynamic> queryParams;

  @reflectable
  bool isDefault;

  @reflectable
  String element;

  @reflectable
  bool active = false;

  PolymerRoute(this.name, this.pattern, {this.isDefault, this.element});
}


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
    if (!classMirror.isAbstract && classMirror.instanceMembers.keys.contains("initialize")) {
      classMirror.newInstance('', []);
    }
  }
  await Polyce.initAllServices();
}

initPolyce() async {
  await initServices();
  await initPolymer();
}