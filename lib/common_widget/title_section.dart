import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class TitleSection extends StatelessWidget {
  final String title;
  const TitleSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                title,
                style: TextStyle(
                    color: TColor.primaryText80,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            );
  }
}