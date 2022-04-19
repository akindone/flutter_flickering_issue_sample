import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 146),
        _buildAnim(context),
        const SizedBox(height: 46),
        GestureDetector(
          onTap: () {
            showDialog<bool>(
              context: context,
              builder: (context) => Center(
                child: BlurCard(
                  radius: 50,
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  bgColor: const Color(0x3DFEFFFE),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                      minHeight:
                          200, //modify this value to make dialog partially overlay bottom blurCard
                    ),
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'dialog title',
                            textAlign: TextAlign.center,
                          ),
                          Text('content'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: BlurCard(
            bgColor: const Color(0x40FFFFFF),
            radius: 8,
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 100,
              width: 300,
              alignment: Alignment.center,
              child: const Text('click me'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnim(BuildContext context) {
    return const SizedBox(
      height: 230,
      child: AnimatedOpacity(
        opacity: 1,
        duration: Duration(seconds: 2),
        child: ImageSequenceAnimator(
          'assets/ImageSequence',
          "Frame_",
          0,
          5,
          "png",
          60,
          key: Key("offline"),
          fps: 24,
          isLooping: true,
          isAutoPlay: true,
        ),
      ),
    );
  }
}

class BlurCard extends StatelessWidget {
  final double radius;
  final Widget? child;
  final ImageFilter filter;
  final Color? bgColor;
  final Gradient? gradient;
  final bool radiusOnlyTop;

  const BlurCard({
    Key? key,
    required this.radius,
    required this.filter,
    this.child,
    this.bgColor,
    this.gradient,
    this.radiusOnlyTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radiusOnlyTop
          ? BorderRadius.vertical(top: Radius.circular(radius))
          : BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: filter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: gradient,
            color: gradient == null ? bgColor : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
