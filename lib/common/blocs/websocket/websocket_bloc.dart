import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_event.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_state.dart';
import 'package:mcda_app/core/network/websocket_client.dart';

class WebsocketBloc extends Bloc<WebSocketEvent, WebSocketState> {
  final WebsocketClient client;

  StreamSubscription? _sub;

  WebsocketBloc(this.client) : super(WebSocketInitial()) {
    on<WebSocketConnect>(_onConnect);
    on<WebSocketDisconnect>(_onDisconnect);
    on<WebSocketSend>(_onSend);
    on<WebSocketInbound>(_onInbound);
  }

  void _onConnect(WebSocketConnect e, Emitter<WebSocketState> emit) async {
    emit(WebSocketConnecting()); // Emit connecting state
    try {
      await client.connect();
      _sub?.cancel(); // Cancel any existing subscription
      _sub = client.stream.listen(
        (data) => add(WebSocketInbound(data)),
        onError: (err) => emit(WebSocketError(err.toString())),
        onDone: () => emit(WebSocketDisconnected()),
      );
      emit(WebSocketConnected()); // Emit connected state
    } catch (e) {
      emit(WebSocketError('Connection failed: ${e.toString()}'));
    }
  }

  Future<void> _onDisconnect(
    WebSocketDisconnect e,
    Emitter<WebSocketState> emit,
  ) async {
    await client.disconnect();
    await _sub?.cancel(); // Ensure subscription is canceled
    emit(WebSocketDisconnected()); // Emit disconnected state
  }

  void _onSend(WebSocketSend e, Emitter<WebSocketState> emit) {
    client.send(e.payload);
  }

  void _onInbound(WebSocketInbound e, Emitter<WebSocketState> emit) {
    print(e.data);
    emit(WebSocketMessage(data: e.data));
  }

  @override
  Future<void> close() async {
    await _sub?.cancel(); // Ensure subscription is canceled
    await client.disconnect(); // Ensure client is disconnected
    return super.close();
  }
}
