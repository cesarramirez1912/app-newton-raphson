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
      listaExpoente = [];
      listaMultiplicadorX = [];
      _counter = 0.toString();
      _iteracoes = 0.toString();
    });
  }

  void _calcula() {
    final n = MetodoDeNewton(listaMultiplicadorX, listaExpoente);
    print(n.calculateFrom(int.parse(myControllerChute.text)));
    setState(() {
      _counter =
          n.calculateFrom(int.parse(myControllerChute.text))[0].toString();
      _iteracoes =
          n.calculateFrom(int.parse(myControllerChute.text))[1].toString();
    });
  }

  void _incrementCounter() {
    setState(() {
      listaExpoente.add(int.parse(myControllerInt.text));
      listaMultiplicadorX.add(num.parse(myControllerNum.text));
    });
    myControllerNum.clear();
    myControllerInt.clear();
  }

  List<int> listaExpoente = new List<int>();
  List<num> listaMultiplicadorX = new List<num>();
  final myControllerInt = TextEditingController();
  final myControllerNum = TextEditingController();
  final myControllerChute = TextEditingController(text: 10.toString());

  @override
  Widget build(BuildContext context) {
    double _altura = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 237, 237, 1.0),
      body: Stack(
        children: <Widget>[
          Container(
            height: _altura,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [Colors.deepPurpleAccent, Colors.lightBlue])),
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        right: 10, left: 10, bottom: 20, top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Metodo de \nNewton Raphson',
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 31,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Para calcular Raizes de funções',
                          style: TextStyle(
                              fontFamily: 'Rubik',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15,right: 30,left: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Crie a sua função completando o multiplicador e o expoente do X:',
                            style: TextStyle(
                                fontFamily: 'Rubik',
                                color: Colors.black,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 2.2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 90,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: listaExpoente.length + 1,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        if (listaExpoente.length == 0) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: caixaDoX(),
                                          );
                                        }
                                        if (index == listaExpoente.length) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: caixaDoX(),
                                          );
                                        } else {
                                          return Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 16),
                                                  child: variavelDoX(
                                                      listaMultiplicadorX[
                                                          index],
                                                      index,
                                                      listaExpoente[index]),
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Insira um chute inicial:',
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                              Divider(
                                height: 10.0,
                              ),
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
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.black)),
                                        suffixStyle:
                                        const TextStyle(color: Colors.green)),
                                    style: TextStyle(
                                        height: 1.2,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, left: 20.0),
                              child: Text(
                                'Raiz',
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 10.0),
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
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '=',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 50),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$_counter',
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 20.0),
                              child: Text(
                                'Iterações',
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '=',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 50),
                              ),
                              Text(
                                '$_iteracoes',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20, left: 20),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: FlatButton(
                                child: Text(
                                  'Limpar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                color: Color.fromRGBO(239, 48, 36, 1.0),
                                onPressed: () {
                                  _limpa();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              suffixStyle:
                                  const TextStyle(color: Colors.green)),
                          style: TextStyle(
                              height: 1.0,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      'x',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 83,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
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
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)),
                          suffixStyle: const TextStyle(color: Colors.green)),
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            _incrementCounter();
          },
          child: Container(
            width: 30,
            height: 30,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(left: 2, top: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
                child: Icon(
              Icons.add,
              color: Colors.white,
            )),
          ),
        ),
      ],
    );
  }

  Widget variavelDoX(num variavel, int index, num expoente) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
                height: 50,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 3, left: 3, bottom: 7),
                      child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.green,
                            primaryColorDark: Colors.red,
                          ),
                          child: Text(
                            variavel > 0
                                ? '+' + variavel.toString()
                                : variavel.toString(),
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    Text(
                      'x',
                      style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )),
            Positioned(
              top: 8,
              right: 0,
              child: Container(
                child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.green,
                      primaryColorDark: Colors.red,
                    ),
                    child: Text(expoente.toString())),
              ),
            ),
          ],
        ),
      ],
    );
  }

//  Widget variavelDoX(num variavel, int index) {
//    if (index == 0) {
//      if (variavel > 10) {
//        return Text(' ' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
//      } else {
//        return Text('  ' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
//      }
//    } else if (variavel > 0) {
//      return Text('+' + variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
//    } else {
//      return Text(variavel.toString() + 'x', style: Theme.of(context).textTheme.headline);
//    }
//  }
}
