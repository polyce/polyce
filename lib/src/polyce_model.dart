/**
 * Created by lejard_h on 23/12/15.
 */

part of polyce;

@serializable
abstract class PolyceModel extends Observable {
  Map get toMap => Serializer.toMap(this);
  String toString() => toMap.toString();
  String toJson() => Serializer.toJson(this);
}
