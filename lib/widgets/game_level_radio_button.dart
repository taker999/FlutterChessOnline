import 'package:flutter/material.dart';

import '../helper/constants.dart';

class GameLevelRadioButton extends StatelessWidget {
  const GameLevelRadioButton({
    super.key,
    required this.title,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  final String title;
  final GameDifficulty value;
  final GameDifficulty? groupValue;
  final void Function(GameDifficulty?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final capitalizedTitle = title[0].toUpperCase() + title.substring(1);
    return Expanded(
      child: RadioListTile<GameDifficulty>(
        title: Text(
          capitalizedTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        dense: true,
        contentPadding: EdgeInsets.zero,
        tileColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
