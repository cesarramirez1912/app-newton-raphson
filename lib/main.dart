import 'package:calculo_numerico_app/metodo_de_newton.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.red,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = 0.toString();
  String thisText = "";
  int pinLength = 1;
  String _iteracoes = 0.toString();

  bool hasError = false;
  String errorMessage;

  void _limpa() {
    setState(() {
      listaNumeros = [];
      listaNumeros2 = [];
      _counter = 0.toString();
      _iteracoes = 0.toString();
    });
  }

  void _calcula() {
    print(myControllerChute.text);
    // expression == x^3 - 18*x -83
    // expression == x^3 - 2*x^2 -x + 37/500
    // expression == x^2 - 5 ok 2.236067977
    // expression == x^3 - 2*x - 5
    final n = NewtonsMethod(listaNumeros2, listaNumeros);
    print(n.upperLimit()); // 84.0
    print(n.lowerLimit()); // -84.0
    print(n.findSignChange()); // [5.040000000000064, 6.720000000000064]
    print(n.calculateFrom(int.parse(myControllerChute.text)));
    // double teste = n.upperLimit();// 5.705115796346382
//    while(teste>=n.lowerLimit()){
//      print('x'+teste.toString());
//      print('raiz' + n.calculateFrom(teste).toString());
//      teste--;
//    }
    setState(() {
      _counter = n.calculateFrom(int.parse(myControllerChute.text))[0].toString();
      _iteracoes = n.calculateFrom(int.parse(myControllerChute.text))[1].toString();
      // _counter = n.calculateFrom(int.parse(myControllerChute.text)).toString();
    });
  }

  void _incrementCounter() {
    setState(() {
      listaNumeros.add(int.parse(myControllerInt.text));
      listaNumeros2.add(num.parse(myControllerNum.text));
    });
    myControllerNum.clear();
    myControllerInt.clear();
  }

  List<int> listaNumeros = new List<int>();
  List<num> listaNumeros2 = new List<num>();
  final myControllerInt = TextEditingController();
  final myControllerNum = TextEditingController();
  final myControllerChute = TextEditingController(text: 10.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 250, 1.0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Text(
                'Metodo de \nNewton Raphson',
                style: TextStyle(fontFamily: 'Rubik', color: Colors.black, fontSize: 34, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 10, top: 20, bottom: 0),
              child: Text(
                'Crie a sua função completando o multiplicador e o expoente do X:',
                style: TextStyle(fontFamily: 'Rubik', color: Colors.black, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 10),
              padding: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 30),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6), topRight: Radius.circular(60))),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 90,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listaNumeros.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (listaNumeros.length == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: caixaDoX(),
                                  );
                                }
                                if (index == listaNumeros.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: caixaDoX(),
                                  );
                                } else {
                                  return Center(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 8),
                                          width: listaNumeros2[index] >= 10 && listaNumeros2[index] < 100 ? 68 : listaNumeros2[index] > 100 ? 80 : 56,
                                          height: 38,
                                          child: variavelDoX(listaNumeros2[index], index),
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: listaNumeros2[index] >= 10 && listaNumeros2[index] < 100 ? 30 : listaNumeros2[index] > 99 ? 36 : 18,
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            height: 20,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 25.0),
                                              child: Text(
                                                listaNumeros[index].toString(),
                                                style: Theme.of(context).textTheme.subhead,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: FlatButton(
                    child: Text(
                      'Limpar',

                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
                    ),
                    color: Color.fromRGBO(239, 48, 36, 1.0),
                    onPressed: () {
                      _limpa();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 10, top: 10, bottom: 0),
                  child: Text(
                    'Insira um chute inicial:',
                    style: TextStyle(fontFamily: 'Rubik', color: Colors.black, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6), bottomLeft: Radius.circular(6), topLeft: Radius.circular(6), topRight: Radius.circular(60))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: 40,
                      height: 50,
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.green,
                          primaryColorDark: Colors.red,
                        ),
                        child: new TextField(
                          controller: myControllerChute,
                          showCursor: true,
                          cursorColor: Colors.deepPurple,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                              suffixStyle: const TextStyle(color: Colors.green)),
                          style: TextStyle(height: 1.2, fontSize: 30.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10.0),
                  child: Text(
                    'Raiz',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10.0),
                  child: FlatButton(
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      _calcula();
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '=',
                    style: TextStyle(color: Colors.grey[400], fontSize: 50),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '$_counter',
                        style: TextStyle(color: Colors.grey[800], fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10.0),
                  child: Text(
                    'Iterações',
                    style: TextStyle(color: Colors.grey[600], fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '=',
                    style: TextStyle(color: Colors.grey[400], fontSize: 50),
                  ),
                  Text(
                    '$_iteracoes',
                    style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

//              Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: new TextField(
//                  controller: myControllerInt,
//                  keyboardType: TextInputType.number, // Use email input type for emails.
//                  decoration: new InputDecoration(hintText: ' ', labelText: 'Numero expoente x')),
//            ),
  Widget caixaDoX() {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                height: 95,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      width: 40,
                      height: 40,
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.green,
                          primaryColorDark: Colors.red,
                        ),
                        child: new TextField(
                          controller: myControllerNum,
                          showCursor: true,
                          cursorColor: Colors.deepPurple,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                              suffixStyle: const TextStyle(color: Colors.green)),
                          style: TextStyle(height: 1.0, fontSize: 35.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      'x',
                      style: TextStyle(fontFamily:'Rubik', fontSize: 83, fontWeight: FontWeight.w500, color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(top: 6),
                padding: EdgeInsets.all(2),
                child: Container(
                  width: 20,
                  height: 20,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.green,
                      primaryColorDark: Colors.red,
                    ),
                    child: new TextField(
                      controller: myControllerInt,
                      showCursor: true,
                      cursorColor: Colors.deepPurple,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(top: 6),
                          border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                          suffixStyle: const TextStyle(color: Colors.green)),
                      style: TextStyle(height: 1.2, fontSize: 14.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),  InkWell(
          onTap: (){
            _incrementCounter();
          },
          child: Container(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(left: 2,top: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Center(
              child: Icon(Icons.add,color: Colors.white,)
            ),
          ),
        ),
      ],
    );
  }

  Widget variavelDoX(num variavel, int index) {
    if (index == 0) {
      if (variavel > 10) {
        return Text(' ' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
      } else {
        return Text('  ' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
      }
    } else if (variavel > 0) {
      return Text('+' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
    } else {
      return Text(variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
    }
  }
}
