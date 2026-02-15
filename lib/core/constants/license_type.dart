enum LicenseType {
  a1(1),
  a(2),
  b1(3),
  b(4),
  c1(5),
  c(6),
  d1(7),
  d2(8),
  d(9),
  be(10),
  c1e(11),
  ce(12),
  d1e(13),
  d2e(14),
  de(15);

  final int id;
  const LicenseType(this.id);

  static LicenseType fromInt(int id) {
    return LicenseType.values.firstWhere(
      (e) => e.id == id,
      orElse: () => LicenseType.a1,
    );
  }

  String get label => "Hạng ${name.toUpperCase()}";
}
