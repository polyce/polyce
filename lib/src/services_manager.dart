/**
 * Created by lejard_h on 23/03/16.
 */

part of polyce;

class ServicesManager {
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

  static initAllServices() {
    _services.forEach((type, PolyceService service) {
      service.init();
    });
  }
}

initServices() async {
  ServicesManager.reset();
  service.annotatedClasses.forEach((classMirror) {
    if (classMirror != null &&
        classMirror.simpleName != null &&
        classMirror.reflectedType != PolyceModel &&
        !classMirror.isAbstract) {
      var obj = classMirror.newInstance('', []);
      var instance = service.reflect(obj);
      var ref = instance.reflectee;
      if (ref is PolyceService) {
        ServicesManager.registerService(classMirror.reflectedType, ref);
      }
    }
  });
  ServicesManager.initAllServices();
}
