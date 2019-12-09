import 'package:flutter/material.dart';


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}
class _MyFormState extends State<MyForm> {
  // Create a text controller and use it to retrieve the current value.
  // of the TextField!
  final myController = TextEditingController();
  //由于 focus node 是长寿命对象，我们需要使用 State 类来管理生命周期。
  //为此，需要在 State 类的 initState 方法中创建 FocusNode 实例，并在 dispose 方法中清除它们。
  final myfouceNode = FocusNode();
  
  String _errorText;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when disposing of the Widget.
    myController.dispose();
    myfouceNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Text Inputa'),
      ),
      body: Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: '一个普通的输入框'),
                onChanged: (text) {
                  print("First text field: $text");
                },
              ),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "请输入邮箱", errorText: _getErrorText()),
                controller: myController,
                onSubmitted: (String text){
                  if (isEmail(text)){
                    setState(() {
                      _errorText = null;
                    });
                  }else{
                    setState(() {
                      _errorText = "邮箱格式不正确。";
                    });
                  }
                },
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  focusNode: myfouceNode,
                  decoration: InputDecoration(hintText: "请输入另一个邮箱"),
                  validator: (value) {
                    if (isEmail(value)){
                      return "邮箱格式不正确。";
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text('聚焦该输入框'),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(myfouceNode);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    RaisedButton(
                      child: Text('检验第二个邮箱'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('第二个邮箱错误'),));
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog with the
        // text the user has typed into our text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has typed in using our
                // TextEditingController
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }

  _getErrorText() {
    return _errorText;
  }

  bool isEmail(String emailString) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailRegexp);

    return regExp.hasMatch(emailString);
  }
}