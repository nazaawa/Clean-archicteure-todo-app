import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'file_memory_impl.dart';
import 'files.dart';

final filesProvider = Provider<Files>((ref) {
  return FilesMemoryImpl();
});
