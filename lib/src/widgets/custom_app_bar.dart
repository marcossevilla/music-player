import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(FontAwesomeIcons.music),
            Spacer(),
            FaIcon(FontAwesomeIcons.commentAlt),
            SizedBox(width: 10.0),
            FaIcon(FontAwesomeIcons.headphonesAlt),
            SizedBox(width: 10.0),
            FaIcon(FontAwesomeIcons.externalLinkAlt),
          ],
        ),
      ),
    );
  }
}
