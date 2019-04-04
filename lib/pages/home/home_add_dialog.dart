import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:brokali/blocs/_blocs.dart'
    show BroStacksBloc, BroStacksCreateEvent;

class BroHomeAddDialog extends StatefulWidget {
  @override
  _BroHomeAddDialogState createState() => _BroHomeAddDialogState();
}

class _BroHomeAddDialogState extends State<BroHomeAddDialog> {
  List<DropdownMenuItem<String>> list = [
    DropdownMenuItem(child: Text('Tomorrow'), value: 'item1'),
    DropdownMenuItem(child: Text('After tomorrow'), value: 'item2'),
    DropdownMenuItem(child: Text('Today'), value: 'item3'),
    DropdownMenuItem(child: Text('None'), value: 'item4')
  ];

  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    BroStacksBloc stacksBloc = BlocProvider.of<BroStacksBloc>(context);
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        width: size.width - 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'List 1',
                icon: Container(
                    decoration: ShapeDecoration(
                        color: Colors.green, shape: CircleBorder()),
                    width: 42,
                    height: 42,
                    child:
                        Icon(Icons.fastfood, color: Colors.white, size: 22.0)),
              ),
              controller: _nameController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  DropdownButton(
                    hint: Text('None'),
                    items: list,
                    onChanged: (String value) {
                      print('chane');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Select a day'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'CANCEL',
            style: TextStyle(color: Color.fromRGBO(255, 0, 0, 0.5)),
          ),
          onPressed: () {
            Navigator.pop(context, 'CANCEL');
          },
        ),
        FlatButton(
          child: Text(
            'CREATE',
            style: TextStyle(color: Color(0xFF256600)),
          ),
          onPressed: () {
            stacksBloc
                .dispatch(BroStacksCreateEvent(name: _nameController.text));
            Navigator.pop(context, 'CREATE');
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }
}
