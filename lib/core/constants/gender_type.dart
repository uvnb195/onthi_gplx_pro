enum GenderType {
  male(0),
  female(1);

  final int id;
  const GenderType(this.id);

  String get label {
    switch (this) {
      case GenderType.male:
        return 'Nam';
      case GenderType.female:
        return 'Nữ';
    }
  }

  static GenderType fromInt(int id) {
    return GenderType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => GenderType.male,
    );
  }

  bool get isMale => this == GenderType.male;
}
