import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';

class QrScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).height;
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
                    height: MediaQuery.sizeOf(context).height / 16,
                  ),
                  Image.asset(
                    "assets/bhim.png",
                    width: MediaQuery.sizeOf(context).width / 4.5,
                  ),
                  SizedBox(height: h / 20),
                  Image.asset(
                    "assets/qr.png",
                    height: (h * w) / 2800,
                    width: (h * w) / 600,
                  ),
                  SizedBox(
                    height: h / 38,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: AppColors.border, width: 1.5),
                        color: Colors.white),
                    height: h / 3.8,
                    width: w / 4.3,
                    child: Center(
                        child: Text(
                      "QR Scan",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 18,
                        color: AppColors.fontColour,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
