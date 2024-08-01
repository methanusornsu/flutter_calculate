import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CounterArea());
  }
}

class CounterArea extends StatefulWidget {
  const CounterArea({Key? key});

  @override
  State<CounterArea> createState() => _CounterAreaState();
}

class _CounterAreaState extends State<CounterArea> {
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();

  String _total = "";
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIMPLE BMI"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text(
              _total,
              style: const TextStyle(
                  fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Text(
              _result,
              style: const TextStyle(
                  fontSize: 30.0, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(height: 30),
            Text("ความสูง(Height)",
                style: const TextStyle(fontSize: 20.0, color: Colors.blue)),
            TextField(
              controller: _height,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'กรุณาใส่ค่าความสูงเป็นเซนติเมตร',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 30),
            Text("น้ำหนัก(Weight)",
                style: const TextStyle(fontSize: 20.0, color: Colors.blue)),
            TextField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'กรุณาใส่ค่าน้ำหนักเป็นกิโลกรัม',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print(value);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calculate),
        onPressed: () {
          final double? height = double.tryParse(_height.text);
          final double? weight = double.tryParse(_weight.text);
          setState(() {
            if (height == null ||
                weight == null ||
                height <= 0 ||
                weight <= 0) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('ล้มเหลว!!'),
                    content: const Text('รับค่าเป็นตัวเลขเท่านั้น'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              _result = "";
              _total = "";
            } else {
              final heightcm = height / 100;
              final bmi = weight / (heightcm * heightcm);
              if (bmi < 18.5) {
                _result = 'ต่ำกว่าปกติ';
              } else if (bmi < 22.9) {
                _result = 'ปกติ';
              } else if (bmi < 24.9) {
                _result = 'เริ่มอ้วน';
              } else if (bmi < 29.9) {
                _result = 'น้ำหนักเกิน';
              } else {
                _result = 'อ้วนมาก';
              }
              _total = 'BMI: ${bmi.toStringAsFixed(2)}';
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
