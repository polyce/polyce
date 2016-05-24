/**
 * Created by lejard_h on 23/12/15.
 */

part of polyce;

@serializable
abstract class PolyceModel extends Serialize with Observable {

  static Serializer serializer = Polyce.serializer;

  @override
  String toString() => toMap().toString();

  @override
  String encode() => PolyceModel.serializer.encode(this);

  @override
  Map toMap() => PolyceModel.serializer.toMap(this);
}
