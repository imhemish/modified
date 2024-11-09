import 'package:flutter/material.dart';
import 'package:orbcura_app/utils/colors.dart';

const borderRadius = Radius.circular(20);
const double primaryPadding = 15;
const double secondaryPadding = 12;
const double borderWidth = 1.5;

class CornerChild {
  final Widget enclosedWidget;
  final void Function() onPressed;
  CornerChild(this.enclosedWidget, this.onPressed);
}

class CornerSquare extends StatelessWidget {
  final BorderRadiusGeometry borderRadiusGeometry;
  final EdgeInsets padding;
  final Border border;
  final CornerChild child;

  const CornerSquare(
      this.borderRadiusGeometry, this.padding, this.border, this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: borderRadiusGeometry,
          color: const Color(0xffffffff),
          border: border),
      child: InkWell(
          onTap: child.onPressed,
          child: Padding(
            padding: padding,
            child: child.enclosedWidget,
          )),
    );
  }
}

class FourCornerScreen extends StatelessWidget {
  final CornerChild topLeft;
  final CornerChild topRight;
  final CornerChild bottomLeft;
  final CornerChild bottomRight;
  final Widget content;

  const FourCornerScreen(this.topLeft, this.topRight, this.bottomLeft,
      this.bottomRight, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xeeeeeeff),
      body: Stack(
        children: [
          content,
          Positioned(
              left: 0,
              top: 0,
              child: CornerSquare(
                  BorderRadius.only(bottomRight: borderRadius),
                  EdgeInsets.only(
                      bottom: primaryPadding,
                      right: primaryPadding,
                      top: secondaryPadding,
                      left: secondaryPadding),
                  Border(
                      bottom: BorderSide(
                          color: AppColors.border, width: borderWidth),
                      right: BorderSide(
                          color: AppColors.border, width: borderWidth)),
                  topLeft)),
          Positioned(
              top: 0,
              right: 0,
              child: CornerSquare(
                  BorderRadius.only(bottomLeft: borderRadius),
                  EdgeInsets.only(
                      bottom: primaryPadding,
                      left: primaryPadding,
                      top: secondaryPadding,
                      right: secondaryPadding),
                  Border(
                      bottom: BorderSide(
                          color: AppColors.border, width: borderWidth),
                      left: BorderSide(
                          color: AppColors.border, width: borderWidth)),
                  topRight)),
          Positioned(
              bottom: 0,
              left: 0,
              child: CornerSquare(
                  BorderRadius.only(topRight: borderRadius),
                  EdgeInsets.only(
                      top: primaryPadding,
                      right: primaryPadding,
                      bottom: secondaryPadding,
                      left: secondaryPadding),
                  Border(
                      top: BorderSide(
                          color: AppColors.border, width: borderWidth),
                      right: BorderSide(
                          color: AppColors.border, width: borderWidth)),
                  bottomLeft)),
          Positioned(
              bottom: 0,
              right: 0,
              child: CornerSquare(
                  BorderRadius.only(topLeft: borderRadius),
                  EdgeInsets.only(
                      top: primaryPadding,
                      left: primaryPadding,
                      bottom: secondaryPadding,
                      right: secondaryPadding),
                  Border(
                      top: BorderSide(
                          color: AppColors.border, width: borderWidth),
                      left: BorderSide(
                          color: AppColors.border, width: borderWidth)),
                  bottomRight)),
        ],
      ),
    );
  }
}
