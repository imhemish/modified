import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';

class InstaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width; // Fixed this to width

    return FourCornerScreen(
        CornerChild(
            Image.asset(
              "assets/mic.png",
              height: h / 16,
            ),
            () {}),
        CornerChild(
          Image.asset(
            "assets/communicate.png",
            height: h / 16,
          ),
          () {},
        ),
        CornerChild(
          Image.asset(
            "assets/home.png",
            height: h / 16,
          ),
          () {},
        ),
        CornerChild(
          Image.asset(
            "assets/back.png",
            height: h / 16,
          ),
          () {},
        ),
        Scaffold(
          body: Container(
            color: AppColors.white2,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: h / 11,
                  ),
                  Text(
                    "Instagram",
                    style: GoogleFonts.leagueSpartan(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.fontColour),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: h / 36,
                  ),
                  Container(
                    child: Image.asset(
                        "assets/insta_template.png", // Replace with your image path
                        height: h / 1.4,
                        width: w / 1.4 // Adjust the height as needed
                        ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
