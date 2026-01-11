import 'package:drift/drift.dart';
import 'package:onthi_gplx_pro/features/user_management/domain/value_objects/license.dart';

import 'app_database.dart';

final licenseSeedData = [
  LicenseTableCompanion.insert(
    id: const Value(1),
    code: LicenseType.a1,
    description: 'Mô tô đến 125cm3 hoặc điện đến 11kW',
  ),
  LicenseTableCompanion.insert(
    id: const Value(2),
    code: LicenseType.a,
    description: 'Mô tô trên 125cm3 hoặc điện trên 11kW; gồm A1',
  ),
  LicenseTableCompanion.insert(
    id: const Value(3),
    code: LicenseType.b1,
    description: 'Mô tô 3 bánh và các loại xe hạng A1',
  ),
  LicenseTableCompanion.insert(
    id: const Value(4),
    code: LicenseType.b,
    description: 'Ô tô đến 8 chỗ; tải đến 3.5 tấn; kéo rơ moóc đến 750kg',
  ),
  LicenseTableCompanion.insert(
    id: const Value(5),
    code: LicenseType.c1,
    description: 'Tải 3.5 - 7.5 tấn; kéo rơ moóc đến 750kg; gồm hạng B',
  ),
  LicenseTableCompanion.insert(
    id: const Value(6),
    code: LicenseType.c,
    description: 'Tải trên 7.5 tấn; kéo rơ moóc đến 750kg; gồm hạng B, C1',
  ),
  LicenseTableCompanion.insert(
    id: const Value(7),
    code: LicenseType.d1,
    description: 'Ô tô 8 - 16 chỗ; kéo rơ moóc đến 750kg; gồm hạng B, C1, C',
  ),
  LicenseTableCompanion.insert(
    id: const Value(8),
    code: LicenseType.d2,
    description:
        'Ô tô 16 - 29 chỗ; kéo rơ moóc đến 750kg; gồm hạng B, C1, C, D1',
  ),
  LicenseTableCompanion.insert(
    id: const Value(9),
    code: LicenseType.d,
    description:
        'Ô tô trên 29 chỗ; giường nằm; kéo rơ moóc đến 750kg; gồm B, C1, C, D1, D2',
  ),
  LicenseTableCompanion.insert(
    id: const Value(10),
    code: LicenseType.be,
    description: 'Ô tô hạng B kéo rơ moóc trên 750kg',
  ),
  LicenseTableCompanion.insert(
    id: const Value(11),
    code: LicenseType.c1e,
    description: 'Ô tô hạng C1 kéo rơ moóc trên 750kg',
  ),
  LicenseTableCompanion.insert(
    id: const Value(12),
    code: LicenseType.ce,
    description: 'Ô tô hạng C kéo rơ moóc trên 750kg; xe đầu kéo sơ mi rơ moóc',
  ),
  LicenseTableCompanion.insert(
    id: const Value(13),
    code: LicenseType.d1e,
    description: 'Ô tô hạng D1 kéo rơ moóc trên 750kg',
  ),
  LicenseTableCompanion.insert(
    id: const Value(14),
    code: LicenseType.d2e,
    description: 'Ô tô hạng D2 kéo rơ moóc trên 750kg',
  ),
  LicenseTableCompanion.insert(
    id: const Value(15),
    code: LicenseType.de,
    description: 'Ô tô hạng D kéo rơ moóc trên 750kg; xe khách nối toa',
  ),
];
