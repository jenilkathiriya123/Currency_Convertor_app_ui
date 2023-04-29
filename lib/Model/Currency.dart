class Currency {
  final double result;
  final double rate;

  Currency({required this.result, required this.rate});

  factory Currency.fromMap({required Map data}) {
    return Currency(
      result: data['result'],
      rate: data['info']['rate'],
    );
  }
}
