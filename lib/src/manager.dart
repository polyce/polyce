/**
 * Created by lejard_h on 23/03/16.
 */

part of polyce;

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

  static initAllServices() {
    _services.forEach((type, PolyceService service) {
      service.init();
    });
  }

  static String encode(PolyceModel model) => model?.toJson;
  static Map encodeToMap(PolyceModel model) => model?.toMap;

  static PolyceModel decode(String json, Type type) => Serializer.fromJson(json, type);
  static PolyceModel decodeMap(Map map, Type type) => Serializer.fromMap(map, type);
  static List<PolyceModel> decodeList(List list, Type type) => Serializer.fromList(list, type);

}

initServices() async {
  Polyce.reset();
  service.annotatedClasses.forEach((classMirror) {
    if (classMirror != null &&
        classMirror.simpleName != null &&
        classMirror.reflectedType != PolyceModel &&
        !classMirror.isAbstract) {
      var obj = classMirror.newInstance('', []);
      var instance = service.reflect(obj);
      var ref = instance.reflectee;
      if (ref is PolyceService) {
        Polyce.registerService(classMirror.reflectedType, ref);
      }
    }
  });
  Polyce.initAllServices();
}
