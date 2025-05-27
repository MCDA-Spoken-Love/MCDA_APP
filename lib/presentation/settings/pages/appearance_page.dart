import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/button/button_state.dart';
import 'package:mcda_app/common/blocs/button/button_state_cubit.dart';
import 'package:mcda_app/common/widgets/button/besty_button.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/core/provider/theme.dart';
import 'package:provider/provider.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Appearance'),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocBuilder<ButtonStateCubit, ButtonState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder:
                        (context, ThemeNotifier themeNotifier, child) =>
                            SwitchListTile(
                              title: Text("Dark Mode"),
                              onChanged: (val) {
                                themeNotifier.toggleTheme();
                              },
                              value:
                                  themeNotifier.theme == 'dark' ? true : false,
                            ),
                  ),
                  Consumer(
                    builder:
                        (context, ThemeNotifier themeNotifier, child) =>
                            FloatingActionButton(
                              heroTag: 'appColorSchemeDynamic',
                              onPressed: () {
                                themeNotifier.toggleColorScheme('dynamic');
                              },
                              child: Icon(Icons.add),
                            ),
                  ),
                  Consumer(
                    builder:
                        (context, ThemeNotifier themeNotifier, child) =>
                            FloatingActionButton(
                              heroTag: 'appColorSchemeMain',
                              onPressed: () {
                                themeNotifier.toggleColorScheme('main');
                              },
                              child: Icon(Icons.add),
                            ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Consumer(
                      builder: (context, ThemeNotifier themeNotifier, child) {
                        return BestyButton(
                          title: 'Retornar',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
