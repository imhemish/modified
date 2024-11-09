import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/utils/colors.dart';

class ChatItem extends StatelessWidget {
  final String initials;
  final String name;
  final String message;
  final String time;
  final TextStyle? nameStyle;
  final TextStyle? messageStyle;
  final TextStyle? timeStyle;
  final TextStyle? initialsStyle;


  const ChatItem({
    required this.initials,
    required this.name,
    required this.message,
    required this.time,
    this.initialsStyle,
    this.nameStyle,
    this.messageStyle,
    this.timeStyle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: Row(
        children: [
          CircleAvatar(
            radius: width * 0.07,
            backgroundColor: Color.fromARGB(217, 216, 216, 216),
            child: Text(
              initials,
              style: TextStyle(
                color: Color.fromARGB(255, 67, 67, 67),
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: width * 0.01),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: width * 0.025,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.04),
          Text(
            'On $time',
            style: TextStyle(
              fontSize: width * 0.030,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
