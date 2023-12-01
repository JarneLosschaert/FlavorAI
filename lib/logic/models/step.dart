class Step {
  final int number;
  final String step;

  Step({
    required this.number,
    required this.step,
  });

  factory Step.fromMap(Map<String, dynamic> map) {
    return Step(
      number: map['number'],
      step: map['step'],
    );
  }
}