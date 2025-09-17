import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_bloc.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_event.dart';
import 'package:mcda_app/core/network/websocket_client.dart';
import 'package:mcda_app/presentation/onboarding/widgets/onboarding.dart';

class AddRelationship extends StatelessWidget {
  const AddRelationship({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              WebsocketBloc(WebsocketClient('ws/relationship-requests'))
                ..add(WebSocketConnect()),
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pink_hearts_logo_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              minimum: const EdgeInsets.only(
                top: 0,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Spacer(), Onboarding()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
