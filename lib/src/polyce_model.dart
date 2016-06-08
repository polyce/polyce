/**
 * Created by lejard_h on 23/12/15.
 */

part of polyce;

abstract class PolyceModel extends Observable {

  Map<dynamic, dynamic> encode();

  @override
  String toString() => encode()?.toString();
}
