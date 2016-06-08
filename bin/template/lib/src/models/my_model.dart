library __projectName__.models.my_model;

import "package:polyce/polyce.dart";
import 'package:__projectName__/convert.dart';

class MyModel extends PolyceModel {
  @observable
  String foo;

  MyModel();

  @override
  Map<dynamic, dynamic> encode() => new MyModelEncoder().convert(this);

  factory MyModel.decode(Map<dynamic, dynamic> data) =>
      new MyModelDecoder().convert(data);
}
