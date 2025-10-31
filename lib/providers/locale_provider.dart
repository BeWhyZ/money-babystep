import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_strings.dart';

/// 语言状态提供者
/// 默认使用中文
final localeProvider = StateProvider<Language>((ref) => Language.zh);
