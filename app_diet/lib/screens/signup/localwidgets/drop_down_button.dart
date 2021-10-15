import 'package:flutter/material.dart';

class OurDropDownButton extends StatefulWidget {
  const OurDropDownButton({Key? key}) : super(key: key);

  @override
  _OurDropDownButtonState createState() => _OurDropDownButtonState();
}

class _OurDropDownButtonState extends State<OurDropDownButton> {
  String dropdownValue = 'Paciente';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Paciente', 'Nutricionista']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
