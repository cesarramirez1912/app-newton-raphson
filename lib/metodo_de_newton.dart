import 'dart:math';

class MetodoDeNewton {

  MetodoDeNewton(this._coefEquacao, this._multipliEquacao, {this.epsilon = 0.000001});

  /// Contem coeficientes da equacao
  List<num> _coefEquacao;

  /// Contem multiplicadores do x na equacao
  List<int> _multipliEquacao;

  /// Erro
  final double epsilon;




  /// Calcular valor da funcao no ponto
  num _calcValor(num ponto) {
    var value = 0.0;
    print("Numero point na funcao calcValue: "+ponto.toString());
    for (var i = 0; i < _coefEquacao.length; i++) {
      if (_multipliEquacao[i] != 0) {
        value = value + _coefEquacao[i] * pow(ponto, _multipliEquacao[i]);
      } else {
        value = value + _coefEquacao[i];
      }
    }
    return value;
  }

  /// Calcula a derivada da funcao no ponto
  num _calcDerivada(num ponto) {
    var value = 0.0;
    print("Numero point na funcao calcDerivada: "+ponto.toString());
    for (var i = 0; i < _coefEquacao.length; i++) {
      if (_multipliEquacao[i] != 0) {
        if (_multipliEquacao[i] == 1) {
          value = value + _coefEquacao[i];
        } else {
          value = value +
              _coefEquacao[i] *
                  _multipliEquacao[i] *
                  pow(ponto, _multipliEquacao[i] - 1);
        }
      }
    }
    return value;
  }

  /// Newton's algorithm for finding root from [point]
  List<num> calculateFrom(num ponto) {
    int contador = 0;
    var passo = ponto;
    var proxPasso = ponto - _calcValor(ponto) / _calcDerivada(ponto);
    while ((proxPasso - passo).abs() > epsilon) {
      passo = proxPasso;
      proxPasso = passo - _calcValor(passo) / _calcDerivada(passo);
      contador++;
    }
    return <num>[proxPasso,contador];
  }
}
