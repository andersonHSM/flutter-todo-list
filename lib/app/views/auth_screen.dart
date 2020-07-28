import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/controllers/auth_controller.dart';
import 'package:todo/exceptions/auth_exception.dart';
import 'package:todo/utils/form_validations.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.blue[400], Colors.blue[800]],
          )),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[AuthCard()],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool _signIn = true;
  bool _isLoading = false;

  TextEditingController _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showDialogError(String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ocorreu um erro'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    _form.currentState.save();

    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    final authController = Provider.of<AuthController>(context, listen: false);

    try {
      if (_signIn) {
        await authController.signin(
            _authData['email'], _authData['password'].toString());
      } else {
        await authController.signup(
            _authData['email'], _authData['password'].toString());
      }
    } on AuthException catch (e) {
      _showDialogError(e.toString());
    } catch (e) {
      _showDialogError('Erro desconhecido');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _validatePasswordConfirm(String value) {}

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Container(
      width: mediaQueryData.size.width * 0.8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onSaved: (newValue) {
                    _authData['email'] = newValue;
                  },
                  validator: (value) {
                    return FormValidators.requiredFieldValidator(value);
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    alignLabelWithHint: true,
                  ),
                  onFieldSubmitted: (_) => _passwordNode.requestFocus(),
                ),
                SizedBox(height: 10),
                TextFormField(
                  focusNode: _passwordNode,
                  obscureText: true,
                  onSaved: (newValue) {
                    _authData['password'] = newValue;
                  },
                  validator: (value) {
                    return FormValidators.requiredFieldValidator(value);
                  },
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    alignLabelWithHint: true,
                  ),
                  onFieldSubmitted: (value) {
                    if (_signIn) {
                      _submit();
                    } else {
                      _confirmPasswordNode.requestFocus();
                    }
                  },
                ),
                SizedBox(height: 10),
                if (!_signIn)
                  TextFormField(
                    onFieldSubmitted: (_) => _submit(),
                    focusNode: _confirmPasswordNode,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      print(value);
                      return FormValidators.passwordsMatchValidator(
                          _passwordController.text, value);
                    },
                  ),
                SizedBox(height: 10),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _signIn = !_signIn;
                          });
                        },
                        child: Text("${_signIn ? 'Sign up' : 'Sign in'} "),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: _submit,
                        child: Text(
                          "${_signIn ? 'Login' : 'Register'}",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
