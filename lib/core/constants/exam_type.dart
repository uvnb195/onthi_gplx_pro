enum ExamType {
  theory(0),
  simulation(1);

  final int id;
  const ExamType(this.id);

  static ExamType fromInt(int id) {
    return ExamType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => ExamType.theory, // Default to theory if not found
    );
  }
}
