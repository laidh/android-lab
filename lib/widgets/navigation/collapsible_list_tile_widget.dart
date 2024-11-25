import 'package:flutter/material.dart';

class CollapsibleListTileWidget extends StatelessWidget {
  final IconData leading;
  final String title;
  final bool isSelected;
  final GestureTapCallback? onTap;

  CollapsibleListTileWidget(
      {required this.leading,
      required this.title,
      this.isSelected = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color:
                    isSelected ? Colors.white.withOpacity(0.9) : Colors.pink),
            width: constraints.maxWidth,
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  leading,
                  color: isSelected ? Colors.pink : Colors.white,
                  size: 24,
                ),
                constraints.maxWidth > 128
                    ? SizedBox(width: 16.0)
                    : Container(),
                constraints.maxWidth > 196
                    ? Text(
                        title,
                        style: isSelected
                            ? TextStyle(color: Colors.pink)
                            : TextStyle(color: Colors.white),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }
}
