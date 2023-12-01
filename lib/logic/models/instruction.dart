import 'package:flavor_ai_testing/logic/models/step.dart';

class Instruction {
    final String name;
    final List<Step> steps;

    Instruction({
        required this.name,
        required this.steps,
    });

    factory Instruction.fromMap(Map<String, dynamic> map) {
        return Instruction(
            name: map['name'],
            steps: List<Step>.from(map['steps'].map((x) => Step.fromMap(x))),
        );
    }
}