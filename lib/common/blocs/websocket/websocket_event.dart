abstract class WebSocketEvent {}

class WebSocketConnect extends WebSocketEvent {
  final String? token;
  WebSocketConnect({this.token});
}

class WebSocketDisconnect extends WebSocketEvent {}

class WebSocketSend extends WebSocketEvent {
  final dynamic payload;
  WebSocketSend(this.payload);
}

class WebSocketInbound extends WebSocketEvent {
  final dynamic data;
  WebSocketInbound(this.data);
}
