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

@service
@serializable
abstract class PolyceService extends PolyceModel {
  init() {}
}