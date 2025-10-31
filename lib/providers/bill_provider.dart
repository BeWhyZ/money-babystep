import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/bindings/signals/signals.dart';

/// 创建账单的状态
enum CreateBillStatus { initial, loading, success, error }

/// 创建账单的状态数据
class CreateBillState {
  final CreateBillStatus status;
  final Bill? bill;
  final String? errorMessage;

  const CreateBillState({required this.status, this.bill, this.errorMessage});

  const CreateBillState.initial()
    : status = CreateBillStatus.initial,
      bill = null,
      errorMessage = null;

  const CreateBillState.loading()
    : status = CreateBillStatus.loading,
      bill = null,
      errorMessage = null;

  const CreateBillState.success(this.bill)
    : status = CreateBillStatus.success,
      errorMessage = null;

  const CreateBillState.error(this.errorMessage)
    : status = CreateBillStatus.error,
      bill = null;

  CreateBillState copyWith({
    CreateBillStatus? status,
    Bill? bill,
    String? errorMessage,
  }) {
    return CreateBillState(
      status: status ?? this.status,
      bill: bill ?? this.bill,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// 创建账单的 Provider
class CreateBillNotifier extends StateNotifier<CreateBillState> {
  final Ref ref;

  CreateBillNotifier(this.ref) : super(const CreateBillState.initial());

  /// 创建账单
  Future<void> createBill({
    required int userId,
    required int bookId,
    required double amount,
    required int tagIdLv1,
    required int tagIdLv2,
  }) async {
    state = const CreateBillState.loading();

    try {
      // 发送请求到 Rust
      CreateBillReq(
        userId: Uint64(BigInt.from(userId)),
        bookId: Uint64(BigInt.from(bookId)),
        amount: amount,
        tagIdLv1: Uint64(BigInt.from(tagIdLv1)),
        tagIdLv2: Uint64(BigInt.from(tagIdLv2)),
      ).sendSignalToRust();

      // 响应会通过 rustSignalStream 自动接收
    } catch (e) {
      state = CreateBillState.error(e.toString());
    }
  }

  /// 处理来自 Rust 的响应（由全局监听器调用）
  void handleResponse(Bill bill) {
    state = CreateBillState.success(bill);
    // 同时添加账单到列表 provider
    ref.read(billListProvider.notifier).addBill(bill);
  }

  /// 处理错误
  void handleError(String errorMessage) {
    state = CreateBillState.error(errorMessage);
  }

  /// 重置状态
  void reset() {
    state = const CreateBillState.initial();
  }
}

/// 创建账单的 Provider 实例
final createBillProvider =
    StateNotifierProvider<CreateBillNotifier, CreateBillState>(
      (ref) => CreateBillNotifier(ref),
    );

/// 账单列表 Provider（用于展示所有账单）
class BillListNotifier extends StateNotifier<AsyncValue<List<Bill>>> {
  BillListNotifier() : super(const AsyncValue.data([])) {
    // 初始化为空列表，未来可以在这里加载历史数据
    // loadBills();
  }

  // TODO: 实现从 Rust 获取账单列表的逻辑
  Future<void> loadBills() async {
    state = const AsyncValue.loading();
    try {
      // 这里需要添加获取账单列表的 Rust API
      // 暂时返回空列表
      state = const AsyncValue.data([]);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 添加账单到本地列表
  void addBill(Bill bill) {
    state.whenData((bills) {
      // 将新账单添加到列表开头（最新的在前面）
      final updatedBills = [bill, ...bills];
      state = AsyncValue.data(updatedBills);
    });
  }
}

final billListProvider =
    StateNotifierProvider<BillListNotifier, AsyncValue<List<Bill>>>((ref) {
      return BillListNotifier();
    });
