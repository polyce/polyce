library polyce.core;

import "package:polyce/polyce.dart";

initServices() async {
  PolyceService.resetServices();
  for (var classMirror in service.annotatedClasses) {
    if (!classMirror.isAbstract) {
      PolyceService ser = classMirror.newInstance('', []);
      PolyceService.registerService(ser.runtimeType, ser);
    }
  }
}

initPolyce() async {
  await initServices();
  await initPolymer();
}