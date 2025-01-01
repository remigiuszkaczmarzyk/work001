import 'package:flutter/material.dart';

import 'dock/dock.dart';
import 'dock/dock_config.dart';
import 'dock/dock_item_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(
            items: dockIcons,
            itemNames: dockItemNames,
            builder: defaultDockItemBuilder,
          ),
        ),
      ),
    );
  }
}
