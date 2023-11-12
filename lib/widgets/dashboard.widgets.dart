import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final Image image;
  final String text;
  final Color color;
  final Function onPress;

  const Grid(
      {super.key,
      required this.image,
      required this.text,
      required this.color,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          color: color,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(text,
                        style: const TextStyle(
                          fontSize: 14,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
