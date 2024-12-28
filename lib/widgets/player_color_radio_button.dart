import 'package:flutter/material.dart';

import '../helper/constants.dart';

class PlayerColorRadioButton extends StatelessWidget {
  const PlayerColorRadioButton({
    super.key,
    required this.title,
    required this.value,
    this.groupValue,
    this.onChanged,
  });

  final String title;
  final PlayerColor value;
  final PlayerColor? groupValue;
  final void Function(PlayerColor?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<PlayerColor>(
      title: Text(
        title,
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
    );
  }
}
