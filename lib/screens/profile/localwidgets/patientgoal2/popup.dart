import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  String documentId;
  PopUp(BuildContext context, this.documentId, {Key? key})
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


    Future<void> updatePatientCurrentWeight(
        Timestamp updateDate) async {
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .collection('weightUpdate')
          .doc()
          .set({
        'weight': double.parse(_fieldController.text),
        'updateDate': updateDate.millisecondsSinceEpoch
      });
      FirebaseFirestore.instance
          .collection('patient')
          .doc(widget.documentId)
          .update({'weight': _fieldController.text});
    }

    String str = '';
    
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
            updatePatientCurrentWeight(Timestamp.now());
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
