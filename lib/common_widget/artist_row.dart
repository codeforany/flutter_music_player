import 'package:flutter/material.dart';
import '../common/color_extension.dart';

class ArtistRow extends StatelessWidget {
  final Map aObj;
  final Function(int select) onPressedMenuSelect;
  final VoidCallback onPressed;
  const ArtistRow({
    super.key,
    required this.aObj,
    required this.onPressed,
    required this.onPressedMenuSelect,
  });

  @override
  Widget build(BuildContext context) {
    return 
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: onPressed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRect(
                      child: Image.asset(
                        aObj["image"],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: TColor.primaryText28),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aObj["name"],
                      maxLines: 1,
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
          
                    const SizedBox(height: 8,),
                    Text(
                      "${ aObj["albums"] } \t•\t${aObj["songs"]}",
                      maxLines: 1,
                      style: TextStyle(color: TColor.primaryText80, fontSize: 11),
                    )
                  ],
                )),
                SizedBox(
                  width: 25,
                  height: 25,
                  child: PopupMenuButton<int>(
                      color: const Color(0xff383B49),
                      offset: const Offset(-10, 15),
                      elevation: 1,
                      icon: Image.asset(
                        "assets/img/more_btn.png",
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                      onSelected: onPressedMenuSelect,
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
          ),
        );
  }
}
