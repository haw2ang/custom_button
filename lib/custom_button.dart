import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'button_painter.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    this.disable = false,
    this.textStyle = const TextStyle(),
    required this.onTap,
    this.isAsync = false,
    this.circularProgressIndicator = const CircularProgressIndicator(),
    this.animationDuration = const Duration(milliseconds: 70),
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;
  final String text;
  final bool disable;
  final TextStyle textStyle;
  final void Function() onTap;
  final bool isAsync;
  final Widget circularProgressIndicator;
  final Duration animationDuration;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double right = 3;
  double bottom = 4;
  bool showLoading = false;
  final audioPlayer = AudioPlayer();

  bool get isDisabled => widget.disable;

  void _handleTapDown() async {
    await audioPlayer.play(AssetSource('click.wav'));
    setState(() {
      right = 2;
      bottom = 1;
    });
  }

  void _handleTapUp() {
    Future.delayed(
      widget.animationDuration,
      () {
        setState(() {
          right = 3;
          bottom = 4;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: showLoading
          ? null
          : isDisabled
              ? null
              : (details) => _handleTapUp(),
      onTapUp: showLoading
          ? null
          : isDisabled
              ? null
              : (details) => _handleTapUp(),
      onTapDown: showLoading
          ? null
          : isDisabled
              ? null
              : (details) => _handleTapDown(),
      onTap: widget.isAsync
          ? () async {
              widget.onTap();
              setState(() {
                showLoading = true;
              });
              await Future.delayed(
                const Duration(seconds: 3),
                () {
                  setState(() {
                    showLoading = false;
                  });
                },
              );
            }
          : widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              painter: MyCustomPainter(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: widget.animationDuration,
            width: widget.width,
            height: widget.height,
            bottom: showLoading
                ? 1
                : isDisabled
                    ? null
                    : bottom,
            right: showLoading
                ? 2
                : isDisabled
                    ? null
                    : right,
            child: CustomPaint(
              painter: MyCustomPainter(
                  color:
                      showLoading ? widget.color.withAlpha(170) : widget.color,
                  buttonText: showLoading ? null : widget.text,
                  textStyle: showLoading ? null : widget.textStyle),
            ),
          ),
          if (showLoading) widget.circularProgressIndicator
        ],
      ),
    );
  }
}
