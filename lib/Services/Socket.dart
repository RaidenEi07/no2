import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect() {
    socket = IO.io('wss://trading.agr.vn/market/socket.io', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket!.onConnect((_) {
      print('Connected');
    });

    socket!.on('data', (data) {
      // Xử lý dữ liệu nhận được từ server
    });

    socket!.onDisconnect((_) => print('Disconnected'));
  }

  void disconnect() {
    socket?.disconnect();
  }
}