import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/user/user_display_cubit.dart';
import 'package:mcda_app/common/blocs/user/user_display_state.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_bloc.dart';
import 'package:mcda_app/common/blocs/websocket/websocket_state.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/containers/custom_container.dart';
import 'package:mcda_app/common/widgets/input/besty_input.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/domain/entities/user.dart';
import 'package:mcda_app/presentation/onboarding/widgets/onboading_text.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  UserEntity? user;
  final TextEditingController _codeCon = TextEditingController();

  @override
  void initState() {
    super.initState();

    final userCubit = context.read<UserDisplayCubit>();
    if (userCubit.state is UserLoading) {
      userCubit.displayUser();
    }

    if (userCubit.state is UserLoaded) {
      user = (userCubit.state as UserLoaded).userEntity;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeColors = Theme.of(context);

    return BlocListener<WebsocketBloc, WebSocketState>(
      listenWhen:
          (prev, curr) => curr is WebSocketMessage || curr is WebSocketError,
      listener: (context, state) {
        if (state is WebSocketMessage) {
          print(state.data);
        }
        if (state is WebSocketError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('WS Error: ${state.message}')));
        }
      },
      child: CustomContainer(
        position: 'unique',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OnboadingText(),
            SizedBox(height: 28),
            BestyInput(
              label: 'Send them this code:',
              inputType: 'copy',
              controller: TextEditingController(text: user?.connection_code),
            ),
            SizedBox(height: 28),
            Text(
              'Or have them send you theirs',
              style: TextStyle(
                fontFamily: 'BestyBeige',
                color: themeColors.canvasColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 28),
            BestyInput(
              label: 'And add it here: ',
              inputType: 'text',
              controller: _codeCon,
              maxLength: 6,
            ),
            SizedBox(height: 28),
            BestyButton(
              onPressed: () {
                null;
              },
              title: 'Connect with your love!',
              titleSize: 12,
              backgroundColor:
                  themeColors.extension<MyColorsExtension>()?.submitColor,
            ),
          ],
        ),
      ),
    );
  }
}
