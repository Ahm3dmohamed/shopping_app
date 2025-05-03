import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetService {
  static final InternetService _instance = InternetService._internal();

  factory InternetService() => _instance;

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  late StreamSubscription _subscription;

  InternetService._internal() {
    _subscription = _connectivity.onConnectivityChanged.listen((_) async {
      _controller.add(await InternetConnectionChecker().hasConnection);
    });

    InternetConnectionChecker().onStatusChange.listen((status) {
      _controller.add(status == InternetConnectionStatus.connected);
    });
  }

  Stream<bool> get connectivityStream => _controller.stream;

  Future<bool> get hasConnection async =>
      await InternetConnectionChecker().hasConnection;

  void dispose() {
    _subscription.cancel();
    _controller.close();
  }
}
