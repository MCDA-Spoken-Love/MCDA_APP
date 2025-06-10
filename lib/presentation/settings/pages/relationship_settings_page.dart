import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcda_app/common/blocs/relationship_termination/relationship_termation_bloc.dart';
import 'package:mcda_app/common/blocs/relationship_termination/relationship_termination_event.dart';
import 'package:mcda_app/common/blocs/relationship_termination/relationship_termination_state.dart';
import 'package:mcda_app/common/widgets/button/custom_button.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';
import 'package:mcda_app/common/widgets/snackbar.dart';
import 'package:mcda_app/common/widgets/text/section_body.dart';
import 'package:mcda_app/common/widgets/text/sections_title.dart';
import 'package:mcda_app/core/configs/theme/my_colors_extension.dart';
import 'package:mcda_app/presentation/home/home.dart';

class RelationshipSettingsPage extends StatelessWidget {
  const RelationshipSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData colors = Theme.of(context);
    MyColorsExtension myColorsExtension =
        colors.extension<MyColorsExtension>()!;

    double sheetHeight = MediaQuery.of(context).size.height * .6;
    Future openDialog() {
      return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return BlocProvider(
            create: (context) => RelationshipTermationBloc(),
            child: BlocListener<
              RelationshipTermationBloc,
              RelationshipTerminationState
            >(
              listener: (
                BuildContext context,
                RelationshipTerminationState state,
              ) {
                if (state is RelationshipTerminated) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                  GlobalSnackBar.show(
                    context,
                    state.message,
                    status: 'success',
                  );
                }
                if (state is RelationshipTerminationFailure) {
                  Navigator.pop(context);
                  GlobalSnackBar.show(context, state.message, status: 'error');
                }
              },
              child: BlocBuilder<
                RelationshipTermationBloc,
                RelationshipTerminationState
              >(
                builder: (
                  BuildContext context,
                  RelationshipTerminationState state,
                ) {
                  return Container(
                    height: sheetHeight,
                    decoration: BoxDecoration(
                      color: colors.colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        children: [
                          SectionTitle('Terminate relationship'),
                          SizedBox(height: 20),
                          SectionBody(
                            'We are so sorry to see that you wish to end your relationship. We hope this may be a click mistake, but if not, please remember to seek help and support from friends, family and professionals, if needed.',
                          ),
                          SizedBox(height: 8),
                          SectionBody(
                            'Your account will still be active, but you will have to setup a new relationship to make use of all functionalities again. We hope to see you again soon :(',
                          ),
                          SizedBox(height: 8),
                          SectionBody(
                            'Are you certain you desire to terminate your relationship?',
                          ),
                          SizedBox(height: 23),
                          CustomButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: myColorsExtension.submitColor,
                            title: 'No, I have changed my mind',
                          ),
                          SizedBox(height: 14),
                          CustomButton(
                            isLoading: state is RelationshipTerminationLoading,
                            onPressed: () {
                              BlocProvider.of<RelationshipTermationBloc>(
                                context,
                              ).add(RelationshipTerminationCallback());
                            },
                            titleColor: colors.colorScheme.error,
                            backgroundColor: Colors.transparent,
                            title: 'Yes, please terminate relationship',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: GoBack(title: 'Relationship Settings'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          onPressed: () {
            openDialog();
          },
          title: 'Terminate relationship',
          error: true,
        ),
      ),
    );
  }
}
