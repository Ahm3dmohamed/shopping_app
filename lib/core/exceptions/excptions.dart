abstract class RouteException {}

class RemoteException extends RouteException {
  final String message;
  RemoteException(this.message);
  @override
  String toString() {
    return message;
  }
}

class localException extends RouteException {
  final String message;
  localException(this.message);
  @override
  String toString() {
    return message;
  }
}
