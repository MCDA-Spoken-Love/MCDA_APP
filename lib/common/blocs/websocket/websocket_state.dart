abstract class WebSocketState {}

class WebSocketInitial extends WebSocketState {}

class WebSocketConnecting extends WebSocketState {}

class WebSocketConnected extends WebSocketState {}

class WebSocketDisconnected extends WebSocketState {}

class WebSocketMessage extends WebSocketState {
  final dynamic data;
  WebSocketMessage({required this.data});
}

class WebSocketError extends WebSocketState {
  final String message;
  WebSocketError(this.message);
}
