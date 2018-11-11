import 'package:conference/api.dart';
import 'package:conference/application.dart';
import 'package:conference/conference_room_card.dart';
import 'package:conference/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookPage extends StatefulWidget {
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  TimeOfDay from = TimeOfDay.now();
  TimeOfDay to = TimeOfDay.now();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  _calculatePrice() {
    return ((to.hour - from.hour) *
            double.parse(Application.tempBooking['cost']))
        .abs();
  }

  OverlayEntry loadingOverlay;
  _book(BuildContext context) async {
    try {
      loadingOverlay = OverlayEntry(
        builder: (context) {
          return Container(
            child: Center(
              child: SpinKitChasingDots(color: Colors.white),
            ),
            color: Colors.black38,
          );
        },
      );
      Overlay.of(context).insert(loadingOverlay);
      Map data = await API.book(from, to, _calculatePrice().toString());
      String token = data['token'];
      loadingOverlay.remove();

      Application.router.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: QrImage(
              data: token,
              size: 256.0,
              backgroundColor: Colors.white,
            ));
          });
    } catch (e) {
      loadingOverlay.remove();
      String message = e.toString();
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Book a conference room',
            style: TextStyle(fontFamily: 'Futura', color: Colors.black)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.check, size: 18.0),
            onPressed: () => _book(context),
            color: Colors.blue,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ConferenceRoomCard(
                imageURL: null,
                imageFile: null,
                capacity: Application.tempBooking['capacity'],
                closesAt: Application.tempBooking['closesAt'] != null
                    ? Application.tempBooking['closesAt']
                    : '17:00',
                cost: Application.tempBooking['cost'],
                location: Application.tempBooking['location'],
                name: Application.tempBooking['name'],
                opensAt: Application.tempBooking['opensAt'] != null
                    ? Application.tempBooking['opensAt']
                    : '8:00',
                room: Application.tempBooking['room'],
                username: Application.tempBooking['createdBy'],
                tags: [],
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TimePicker(
                      hint: 'From: ',
                      time: from,
                      onDateSelected: (date) => setState(() => from = date),
                    ),
                    SizedBox(height: 8.0),
                    TimePicker(
                      hint: 'To: ',
                      time: to,
                      onDateSelected: (date) => setState(() => to = date),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      '${_calculatePrice()}₸',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
