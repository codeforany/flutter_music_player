import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class AlbumCell extends StatelessWidget {
  final Map aObj;
  final VoidCallback onPressed;
  final Function(int) onPressedMenu;
  const AlbumCell({
    super.key,
    required this.aObj,
    required this.onPressed,
    required this.onPressedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.asset(
              aObj["image"],
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  aObj["name"],
                  maxLines: 1,
                  style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              SizedBox(
                width: 12,
                height: 12,
                child: PopupMenuButton<int>(
                    color: const Color(0xff383B49),
                    offset: const Offset(-10, 15),
                    elevation: 1,
                    icon: Image.asset(
                      "assets/img/more_btn.png",
                      width: 12,
                      height: 12,
                      color: Colors.white,
                    ),
                    
                    padding: EdgeInsets.zero,
                    onSelected: onPressedMenu,
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 1,
                          height: 30,
                          child: Text(
                            "Play",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 2,
                           height: 30,
                          child: Text(
                            "Play next",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 3,
                          height: 30,
                          child: Text(
                            "Add to playing queue",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 4,
                           height: 30,
                          child: Text(
                            "Add to playlist...",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 5,
                          height: 30,
                          child: Text(
                            "Rename",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 6,
                          height: 30,
                          child: Text(
                            "Tag editor",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                         const PopupMenuItem(
                          value: 7,
                          height: 30,
                          child: Text(
                            "Go to artist",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 8,
                          height: 30,
                          child: Text(
                            "Delete from device",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 9,
                          height: 30,
                          child: Text(
                            "Share",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ];
                    }),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  aObj["artists"],
                  maxLines: 1,
                  style: TextStyle(color: TColor.lightGray, fontSize: 11),
                ),
              ),
              Text(
                " • ",
                maxLines: 1,
                style: TextStyle(color: TColor.lightGray, fontSize: 11),
              ),
              Text(
                aObj["songs"],
                maxLines: 1,
                style: TextStyle(color: TColor.lightGray, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
