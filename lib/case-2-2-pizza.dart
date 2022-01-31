import 'package:flutter/material.dart';
import 'package:pizza/theme.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

enum SauceName {hot, sweet, cheesy}

class _MyAppState extends State<MyApp>{
  bool _thin = false;
  double _size = 40;
  int _cost = 290;
  SauceName? _sauceName = SauceName.hot;
  bool _cheese = false;

  void _slideThin(bool val){
    setState(() {
      _thin = val;
      _calculate();
    });
  }

  void _onSizeChange(dynamic val){
    setState(() {
      _size = val;
      _calculate();
    });
  }


  void _onCheeseClick(bool? val){
    setState(() {
      _cheese = !_cheese;
      _calculate();
    });
  }

  void _onSauceClick(SauceName? val)
  {
    setState(() {
      _sauceName = val;
      _calculate();
    });
  }

  void _calculate()
  {
    _cost = 200 + (_size*2).round() + (_thin ? 1 : 0)*30 + (_cheese ? 1 : 0)*40;
    switch (_sauceName)
    {
      case SauceName.hot:
        _cost += 10;
        break;
      case SauceName.sweet:
        _cost += 20;
        break;
      case SauceName.cheesy:
        _cost += 40;
        break;
      default:
        _cost += 10;
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const headerTextStyle = TextStyle(
        fontSize: 48,
        fontFamily: 'Amatic',
        color: Colors.brown
    );
    const descriptionTextStyle = TextStyle(
        fontSize: 26,
        fontFamily: 'Yanone',
        color: Colors.brown
    );
    const elementTextStyle = TextStyle(
        fontSize: 22,
        fontFamily: 'Yanone',
        color: Colors.black
    );
    return MaterialApp(
      title: 'Калькулятор пиццы',
      theme: globalTheme(),
      home: Builder(
        builder: (context){
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.jpg'),
                    repeat: ImageRepeat.repeat,
                  )
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(width: 232, height: 123, child: Image.asset('assets/images/pizza.png'),),
                  ),
                  const SizedBox(height: 20,),
                  Text('Калькулятор пиццы',  style: Theme.of(context).textTheme.headline3),
                  const SizedBox(height: 9,),
                  Text('Выберите параметры:', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 9,),
                  SlidingSwitch(

                    value: false,
                    onChanged: _slideThin,
                    onSwipe: () {},
                    onDoubleTap: () {},
                    onTap: () {},
                    textOff: "Обычное тесто",
                    textOn: "Тонкое тесто",
                    width: 300,
                    colorOn: Theme.of(context).primaryColor,
                    colorOff: Theme.of(context).primaryColor,
                    buttonColor: Theme.of(context).backgroundColor,
                    inactiveColor: Theme.of(context).colorScheme.secondary,
                    background: Theme.of(context).canvasColor,

                  ),
                  const SizedBox(height: 20,),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Размер:', style: Theme.of(context).textTheme.headline4)),
                  const SizedBox(height: 9,),
                  SizedBox(
                    width: 300,
                    child: SfSlider(
                      value: _size,
                      min: 20,
                      max: 60,
                      interval: 20,
                      showTicks: true,
                      showLabels: true,
//                    numberFormat: NumberFormat("## см"),
                      enableTooltip: false,
                      minorTicksPerInterval: 0,
                      stepSize: 20,
                      onChanged: _onSizeChange,

                    ),
                  ),
                  const SizedBox(height: 9,),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Соус:', style: Theme.of(context).textTheme.headline4)),
                  RadioListTile<SauceName>(
                      title: Text('Острый', style: Theme.of(context).textTheme.headline5),
                      activeColor: Theme.of(context).primaryColor,
                      value: SauceName.hot,
                      groupValue: _sauceName,
                      onChanged: _onSauceClick
                  ),
                  RadioListTile<SauceName>(
                      title: Text('Кисло-сладкий', style: Theme.of(context).textTheme.headline5),
                      activeColor: Theme.of(context).primaryColor,
                      value: SauceName.sweet,
                      groupValue: _sauceName,
                      onChanged: _onSauceClick
                  ),
                  RadioListTile<SauceName>(
                      title: Text('Сырный', style: Theme.of(context).textTheme.headline5),
                      activeColor: Theme.of(context).primaryColor,
                      value: SauceName.cheesy,
                      groupValue: _sauceName,
                      onChanged: _onSauceClick
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Image.asset('assets/images/cheese.png', scale: 10,)),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text('Больше сыра!', style: Theme.of(context).textTheme.headline4)
                              )
                          ),
                          Expanded(
                            flex: 1,
                            child: Switch(
                                activeColor: Colors.brown,
                                value: _cheese,
                                onChanged: _onCheeseClick
                            ),
                          ),
                        ]),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Стоимость:', style: Theme.of(context).textTheme.headline4)),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical:10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text('$_cost руб.', style: Theme.of(context).textTheme.headline4)
                              )
                          ),
                        ]),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(width: 154, height: 60,
                    child: ElevatedButton(onPressed: () {}, child: Text('Заказать', style: Theme.of(context).textTheme.headline4),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36.0),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20,),
                ],
                ),
              ),
            ),
          );
        }
      ),

    );
  }
}
