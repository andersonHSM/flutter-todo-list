import 'package:flutter/material.dart';

class FormActions extends StatelessWidget {
  final bool sendingRequest;
  final Function saveFunction;

  const FormActions({
    @required this.sendingRequest,
    @required this.saveFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        RaisedButton(
          color: Theme.of(context).errorColor,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 5),
        RaisedButton(
          color: Theme.of(context).accentColor,
          onPressed: saveFunction,
          child: sendingRequest
              ? Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
        )
      ],
    );
  }
}
