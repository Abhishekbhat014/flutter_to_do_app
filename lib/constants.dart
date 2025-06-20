import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

class Constants {
  static const Color buttonColor = Color.fromRGBO(27, 30, 50, 1);
  static const Color whiteColor = Colors.white;
  static const Color textColor = Color.fromRGBO(45, 47, 68, 1);
  static const Color containerColor = Color.fromRGBO(44, 47, 71, 1);
}

final Map<String, IconData> iconOptions = {
  "Work": FontAwesomeIcons.listUl,
  "Office": FontAwesomeIcons.briefcase,
  "Study": FontAwesomeIcons.bookOpenReader,
  "Love": FontAwesomeIcons.solidHeart,
  "Star": FontAwesomeIcons.star,
  "Fitness": FontAwesomeIcons.dumbbell,
};
