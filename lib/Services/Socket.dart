import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect(Function(dynamic) onDataReceived) {
    socket = IO.io('wss://trading.agr.vn/market/socket.io', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket!.onConnect((_) {
      print('Connected');
    });

    socket!.on('data', (data) {
      // Call the provided callback with the received data
      onDataReceived(data);
    });

    socket!.onDisconnect((_) => print('Disconnected'));
  }

  void disconnect() {
    socket?.disconnect();
  }
}
