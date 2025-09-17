import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebsocketClient {
  final String uri;
  WebSocketChannel? _channel;
  Stream get stream => _channel!.stream;
  bool get isConnected => _channel != null;

  WebsocketClient(this.uri);

  static String baseURL = dotenv.env["MCDA_API_SERVER"] ?? '';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> connect() async {
    final token = await _getToken();

    if (isConnected || token == null) return;
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://$baseURL$uri/?token=$token'),
    );
  }

  void send(dynamic data) {
    if (!isConnected) return;
    _channel!.sink.add(data);
  }

  Future<void> disconnect() async {
    if (!isConnected) return;
    await _channel!.sink.close(ws_status.normalClosure);
    _channel = null;
  }
}
