/**
 * Created by lejard_h on 23/12/15.
 */

part of polyce;

@serializable
abstract class PolyceModel extends Observable {
  String toString() => toMap.toString();

  @observable String get toJson => Serializer.toJson(this);
  @observable Map get toMap => Serializer.toMap(this);
}
