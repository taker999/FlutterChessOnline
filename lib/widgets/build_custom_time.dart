import 'package:flutter/material.dart';

class BuildCustomTime extends StatelessWidget {
  const BuildCustomTime({
    super.key,
    required this.time,
    required this.onLeftArrowClicked,
    required this.onRightArrowClicked,
  });

  final String time;
  final void Function()? onLeftArrowClicked;
  final void Function()? onRightArrowClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onLeftArrowClicked,
          child: const Icon(Icons.arrow_back),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(6.0),
          height: 40,
          decoration: BoxDecoration(
            border:
            Border.all(width: 0.5, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(time,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ),
        ),
        InkWell(
          onTap: onRightArrowClicked,
          child: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
