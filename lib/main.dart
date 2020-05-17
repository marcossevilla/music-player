import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/theme/theme.dart';
import 'src/pages/player_page.dart';

void main() => runApp(MusicPlayerApp());

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: appTheme,
      home: PlayerPage(),
    );
  }
}
