import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Calculator',
      home: const MyHomePage(title: 'Time Difference'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num minFirst = 0, minLast = 0, secFirst = 0, secLast = 0;
  num minutes = 0, fSeconds = 0, lSeconds = 0;
  String time = "";
  final _formKey = GlobalKey<FormState>();

  num convertToSeconds(time) {
    return time * 60;
  }

  void convertToMinutes(seconds) {
    String mins, secs;
    mins = (seconds / 60).floor().toString();
    secs = (seconds % 60).toString().padLeft(2, '0');

    time = "$mins:$secs";
  }

  num totalSeconds(min, sec) {
    return min + sec;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Starting Minutes"),
                    onChanged: (value) {
                      minFirst = convertToSeconds(int.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Starting Seconds"),
                    onChanged: (value) {
                      secFirst = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Ending Minutes"),
                    onChanged: (value) {
                      minLast = convertToSeconds(int.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Ending Seconds"),
                    onChanged: (value) {
                      secLast = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () => setState(
                      () {
                        fSeconds = minFirst + secFirst;
                        lSeconds = minLast + secLast;

                        convertToMinutes(lSeconds - fSeconds);
                      },
                    ),
                  ),
                  if (time != "")
                    Text(
                      "Time: $time",
                      style: TextStyle(fontSize: 30),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
