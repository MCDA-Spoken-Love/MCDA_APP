import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/custom_scaffold/custom_scaffold.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold.withChild(
      appBarChild: GoBack(title: 'App Info'),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            children: [
              Text(
                'MCDA - Spoken Love',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Version: 1.0.0', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              const Image(image: AssetImage('assets/full_logo.png')),
              SizedBox(height: 20),
              Text(
                'Developed by: Matheus Salles Blanco',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
