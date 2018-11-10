import 'package:flutter/material.dart';

class IconTextLabel extends StatelessWidget {
  final Widget icon;
  final Widget text;

  const IconTextLabel({Key key, this.icon, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconTheme(
            child: icon,
            data: IconThemeData(
              color: Theme.of(context).accentColor,
              size: 18.0,
            ),
          ),
          SizedBox(width: 9.0),
          text,
        ],
      ),
    );
  }
}
