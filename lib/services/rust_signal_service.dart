import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/bindings/signals/signals.dart';
import '../providers/bill_provider.dart';

/// Rust 信号全局监听服务
///
/// 符合 rinf 最佳实践：
/// - 在应用启动时初始化一次
/// - 全局监听所有 Rust Signal Stream
/// - 根据信号类型分发到对应的 Provider
class RustSignalService {
  final Ref ref;

  RustSignalService(this.ref);

  /// 初始化所有信号监听
  void initialize() {
    _listenCreateBillResp();
    // 在此添加其他信号监听
  }

  /// 监听创建账单的响应
  void _listenCreateBillResp() {
    CreateBillResp.rustSignalStream.listen(
      (rustSignal) {
        final bill = rustSignal.message.bill;
        print("✅ Received CreateBillResp from Rust");

        // 将响应分发到对应的 Provider
        ref.read(createBillProvider.notifier).handleResponse(bill);
      },
      onError: (error) {
        print("❌ Failed to receive CreateBillResp: $error");
        ref.read(createBillProvider.notifier).handleError(error.toString());
      },
    );
  }

  // 其他信号监听方法...
}

/// Rust 信号服务 Provider
final rustSignalServiceProvider = Provider<RustSignalService>((ref) {
  final service = RustSignalService(ref);
  service.initialize();
  return service;
});
