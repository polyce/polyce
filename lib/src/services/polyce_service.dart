/**
 * Created by lejard_h on 15/01/16.
 */

library polyce.service;

import "package:reflectable/reflectable.dart";
import "package:polyce/src/core.dart";


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

  PolyceService.constructor() {
    Polyce.registerService(this.runtimeType, this);
  }

  initialize() async {

  }

}