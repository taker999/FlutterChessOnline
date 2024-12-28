import 'package:flutter/material.dart';

class BuildGameType extends StatelessWidget {
  const BuildGameType({
    super.key,
    required this.label,
    this.gameTime,
    this.icon,
    this.onTap,
  });

  final String label;
  final String? gameTime;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(icon)
                : gameTime != '60+0'
                    ? Text(gameTime!)
                    : const SizedBox.shrink(),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
