import 'package:flutter/material.dart';
import 'package:extended_math/extended_math.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Metodo de Newton Raphson'),
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

  TextEditingController controller = TextEditingController();
  TextEditingController __controller = TextEditingController();
  String thisText = "";
  int pinLength = 1;

  bool hasError = false;
  String errorMessage;

  void _limpa() {
    setState(() {
      listaNumeros = [];
      listaNumeros2 = [];
      _counter = 0.toString();
    });
  }

  void _calcula() {
    // expression == x^3 - 18*x -83
    // expression == x^3 - 2*x^2 -x + 37/500
    // expression == x^2 - 5 ok 2.236067977
    // expression == x^3 - 2*x - 5
    final n = NewtonsMethod(listaNumeros2, listaNumeros);
    print(n.upperLimit()); // 84.0
    print(n.lowerLimit()); // -84.0
    print(n.findSignChange()); // [5.040000000000064, 6.720000000000064]
    print(n.calculateFrom(5));
    // double teste = n.upperLimit();// 5.705115796346382
//    while(teste>=n.lowerLimit()){
//      print('x'+teste.toString());
//      print('raiz' + n.calculateFrom(teste).toString());
//      teste--;
//    }
    setState(() {
      _counter = n.calculateFrom(5).toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(100, 88, 169, 1.0),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                    height: 80,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: Theme(
                            data: new ThemeData(
                              primaryColor: Colors.green,
                              primaryColorDark: Colors.red,
                            ),
                            child: new TextField(
                              showCursor: true,
                              cursorColor: Colors.deepPurple,
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 2),
                                  border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                                  suffixStyle: const TextStyle(color: Colors.green)),
                              style: TextStyle(height: 1.2, fontSize: 40.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          'x',
                          style: TextStyle(fontSize: 83, fontWeight: FontWeight.w500, color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
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
                          showCursor: true,
                          cursorColor: Colors.deepPurple,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 2),
                              border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.black)),
                              suffixStyle: const TextStyle(color: Colors.green)),
                          style: TextStyle(height: 1.2, fontSize: 14.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Crie a sua função completando os dados abaixo:',
                style: TextStyle(color: Colors.grey[600], fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 5, left: 10),
                    padding: EdgeInsets.only(right: 8, left: 8, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: new TextField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.purple,
                        controller: myControllerNum,
                        keyboardType: TextInputType.number,
                        // Use email input type for emails.
                        decoration: new InputDecoration(
                          hintText: ' ',
                          labelText: 'multiplicador do X',
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        )),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 5),
                    padding: EdgeInsets.only(right: 8, left: 8, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: new TextField(
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.purple,
                        controller: myControllerInt,
                        keyboardType: TextInputType.number,
                        // Use email input type for emails.
                        decoration: new InputDecoration(
                          hintText: ' ',
                          labelText: 'expoente do X',
                          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      'Adicionar a Função',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      _incrementCounter();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10.0),
                  child: Text(
                    'A sua função esta ficando assim:',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 60,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listaNumeros.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
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
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Limpar',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      _limpa();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      _calcula();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '=',
                    style: TextStyle(color: Colors.grey[400], fontSize: 50),
                  ),
                  Text(
                    '$_counter',
                    style: TextStyle(color: Colors.grey[800], fontSize: 30, fontWeight: FontWeight.w700),
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
