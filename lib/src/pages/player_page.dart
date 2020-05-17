import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Row(
            children: [
              DiscImage(),
              // TODO: Disc duration widget
            ],
          ),
        ],
      ),
    );
  }
}

class DiscImage extends StatelessWidget {
  const DiscImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      padding: EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/saturation.jpg'),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        gradient: LinearGradient(
          colors: const [Color(0xff484750), Color(0xff1e1c24)],
        ),
      ),
    );
  }
}
