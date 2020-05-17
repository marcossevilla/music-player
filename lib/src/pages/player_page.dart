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
          _DiscInfo(),
        ],
      ),
    );
  }
}

class _DiscInfo extends StatelessWidget {
  const _DiscInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DiscImage(),
          // TODO: Disc duration widget
          DiscProgressBar()
        ],
      ),
    );
  }
}

class DiscProgressBar extends StatelessWidget {
  const DiscProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('2:50'),
          SizedBox(height: 15.0),
          Stack(
            children: [
              Container(
                height: 180.0,
                width: 2.0,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 80.0,
                  width: 2.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text('1:06'),
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
