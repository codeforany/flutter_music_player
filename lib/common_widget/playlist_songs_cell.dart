import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class PlaylistSongsCell extends StatelessWidget {
  final Map pObj;
  final VoidCallback onPressed;
  final VoidCallback onPressedPlay;
  const PlaylistSongsCell({
    super.key,
    required this.pObj,
    required this.onPressed,
    required this.onPressedPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          pObj["image"],
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black45,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        pObj["name"],
                        maxLines: 1,
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        pObj["songs"],
                        maxLines: 1,
                        style: TextStyle(
                            color: TColor.primaryText28, fontSize: 11),
                      ),
                    ]),
              ),
              InkWell(
                onTap: onPressedPlay,
                child: Image.asset(
                  "assets/img/play.png",
                  width: 22,
                  height: 22,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
