import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  String documentId, str;
  PopUp(BuildContext context, this.str, this.documentId, {Key? key})
      : super(key: key);

  @override
  _PopUpState createState() => _PopUpState();
}

enum SingingCharacter { M, F }

class _PopUpState extends State<PopUp> {
  SingingCharacter? _character;
  @override
  Widget build(BuildContext context) {
    TextEditingController _fieldController = TextEditingController();

    Future<void> updatePatientDatas(String updateField) async {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .update({updateField: _fieldController.text});
    }

    Future<void> updatePatientSex(String updateField, String value) async {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .update({updateField: value});
    }

    String str = '';
    if (widget.str == 'weight') {
      str = 'peso';
    }
    if (widget.str == 'height') {
      str = 'altura';
    }
    if (widget.str == 'age') {
      str = 'idade';
    }
    if (widget.str == 'sex') {
      return AlertDialog(
        title: Text('Atualizar sexo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Masculino'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.M,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Feminino'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.F,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_character == SingingCharacter.M) {
                var sex = 'M';
                updatePatientSex(widget.str, sex);
              }
              if (_character == SingingCharacter.F) {
                var sex = 'F';
                updatePatientSex(widget.str, sex);
              }
              Navigator.of(context).pop();
            },
            child: const Text(
              'Salvar',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(240, 12, 9, 30)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text('Atualizar $str'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _fieldController,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            updatePatientDatas(widget.str);
            Navigator.of(context).pop();
          },
          child: const Text(
            'Salvar',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromRGBO(240, 12, 9, 30)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancelar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
