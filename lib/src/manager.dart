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
      service.initialize();
    });
  }

  static String encode(PolyceModel model) => model?.encode();
  static Map encodeToMap(PolyceModel model) => model?.toMap();

  static PolyceModel decode(String json, Type type, [Serializer _serializer]) => _serializer == null ? serializer.decode(json, type) : _serializer.decode(json, type);
  static PolyceModel decodeMap(Map map, Type type, [Serializer _serializer]) => _serializer == null ? serializer.fromMap(map, type) : _serializer.fromMap(map, type);
  static List<PolyceModel> decodeList(List list, Type type, [Serializer _serializer]) => (_serializer == null ? serializer.fromList(list, type) : serializer.fromList(list, type)) as List<PolyceModel>;

  static final HttpService http_service = new HttpService();

  static Serializer serializer = new Serializer.TypedJson();

}

@Deprecated("Only use initPolymer")
initServices() async {
  Polyce.reset();
  service.annotatedClasses.forEach((classMirror) {
    if (!classMirror.isAbstract &&
        classMirror.reflectedType != PolyceModel) {
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
