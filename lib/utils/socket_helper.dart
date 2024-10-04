import 'package:scan_me_plus/export.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketHelper {
  SocketHelper._();
  static IO.Socket? _socket;

  IO.Socket get socket {
    return _socket!;
  }

  static IO.Socket getInstance() {
    _socket ??= IO.io(
        // 'http://192.168.1.48:1106/',
        'http://144.91.80.25:1106/',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());

    if (!_socket!.connected) {
      _socket?.connect();
      _socket?.on(
          'onConnection',
          (data) =>
              _socket?.emit('join', {'userId': PreferenceManager.user?.sId}));

      if (_socket!.connected) {
        debugPrint("DataInSocket ======> ");
        _socket?.on(
            'call',
                (data) {
              debugPrint("DataInSocket = $data");
            });
      }
    }
    debugPrint("SocketConnected = ${_socket?.connected}");

    return _socket!;
  }
}
