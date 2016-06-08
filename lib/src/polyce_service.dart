/**
 * Created by lejard_h on 15/01/16.
 */

part of polyce;

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