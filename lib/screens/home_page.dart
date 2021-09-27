import 'package:arkscript_editor_installer/installer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
        child: const Text('Install'),
        onPressed: () {
          Installer.setupFolder();
        },
      ),
    ));
  }
}
