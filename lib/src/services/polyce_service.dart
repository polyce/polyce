/**
 * Created by lejard_h on 15/01/16.
 */

library polyce.service;

import 'dart:async';
import "package:reflectable/reflectable.dart";

class Service extends Reflectable  {
  const Service()
      : super.fromList(const [
          invokingCapability,
          typeCapability,
          typingCapability,
          superclassQuantifyCapability,
          newInstanceCapability,
          reflectedTypeCapability,
          instanceInvokeCapability
        ]);
}

const service = const Service();

abstract class PolyceService {

  static Map<Type, PolyceService> _services = <Type, PolyceService>{};

  static resetServices() {
    _services.clear();
  }

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

  static initServices() async {
    for (PolyceService service in _services.values) {
      await service.initialize();
    }
  }

  Future initialize();

}