import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderDemoPage extends StatefulWidget{

  @override
  _ProviderDemoPage createState() {
    return _ProviderDemoPage();
  }
}
class _ProviderDemoPage extends State<ProviderDemoPage>{

  @override
  Widget build(BuildContext context) {
    // point 1:  将父元素用ChangeNotifierProvider包裹
    return new Scaffold(
      appBar: AppBar(
        title: Text("Provider App"),
      ),
      body: ChangeNotifierProvider<ProviderDemoModel>(
        create: (context) => ProviderDemoModel(),
        child: new Material(
          child: Column(
            children: <Widget>[
              ResultTextWidget(),
              SliderWidget()
            ],
          ),
        ),
      ),
    );
  }
}
// point 2: model 储存数据字段，及get set方法
class ProviderDemoModel with ChangeNotifier{
  static double _sliderValue = 0.2;

  double get sliderValue => _sliderValue;

  set sliderValue(double newValue) {
    _sliderValue = newValue;
    notifyListeners();
  }
}
class ResultTextWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // point 3: 子元素使用父数据方式1 用 Consumer 包裹
    return Consumer<ProviderDemoModel>(
      builder: (context, model, _) => Padding(
        padding: EdgeInsets.all(8),
        child: Text("The value is ${model.sliderValue}"),
      ),
    );
  }
}
class SliderWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // point 4: 子元素使用父数据方式2  使用Provider.of
    final model = Provider.of<ProviderDemoModel>(context);
    return Slider.adaptive(
      value: model.sliderValue,
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: '${model.sliderValue}',
      // point 5：使用set方法
      onChanged: (value) {
        model.sliderValue = value;
      },
    );
  }
}