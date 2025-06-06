import 'package:flutter/material.dart';
import 'package:mcda_app/common/widgets/routing/go_back/go_back.dart';

class AccountData extends StatefulWidget {
  const AccountData({super.key});

  @override
  State<AccountData> createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBack(title: 'Account Data'),
      body: SingleChildScrollView(child: Column(children: [])),
    );
  }
}
