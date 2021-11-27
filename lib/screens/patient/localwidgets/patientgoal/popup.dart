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

    Future<void> updatePatientGoal(String updateField) async {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .update({updateField: _fieldController.text});
    }

    Future<void> updatePatientCurrentWeight(
        String updateField, Timestamp updateDate) async {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .collection('weightUpdate')
          .doc()
          .set({
        updateField: double.parse(_fieldController.text),
        'updateDate': updateDate.millisecondsSinceEpoch
      });
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .update({'weight': _fieldController.text});
    }

    String str = '';
    if (widget.str == 'goalWeight') {
      return AlertDialog(
        title: const Text('Atualizar meta de peso'),
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
              updatePatientGoal(widget.str);
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
      title: const Text('Atualizar peso atual'),
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
            updatePatientCurrentWeight(widget.str, Timestamp.now());
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
