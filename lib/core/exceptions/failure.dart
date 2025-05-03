class RouteFailures {}

class RemoteFailures extends RouteFailures {
  final String message;
  RemoteFailures(this.message);
  @override
  String toString() {
    return message;
  }
}

class localFailures extends RouteFailures {
  final String message;
  localFailures(this.message);
  @override
  String toString() {
    return message;
  }
}
