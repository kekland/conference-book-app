import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimePicker extends StatelessWidget {
  final Function(TimeOfDay) onDateSelected;
  final TimeOfDay time;
  final String hint;

  const TimePicker({Key key, this.onDateSelected, this.time, this.hint}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black54, width: 1.0),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: () async {
            TimeOfDay newTime = await showTimePicker(context: context, initialTime: time);
            if(newTime != null) {
              onDateSelected(newTime);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.solidClock,
                    size: 18.0, color: Colors.black38),
                SizedBox(width: 12.0),
                Text(
                  hint,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                ),
                Text(
                  time.format(context),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
