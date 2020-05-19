import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'src/theme/theme.dart';
import 'src/pages/player_page.dart';
import 'src/providers/player_provider.dart';

void main() => runApp(MusicPlayerApp());

class MusicPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return ChangeNotifierProvider(
      create: (context) => PlayerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music Player',
        theme: appTheme,
        home: PlayerPage(),
      ),
    );
  }
}
