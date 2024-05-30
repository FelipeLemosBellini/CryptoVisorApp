import 'package:cryptovisor/core/entity/candle_data_entity.dart';
import 'package:cryptovisor/core/entity/crypto_data/exponential_moving_average_of_days.dart';
import 'package:cryptovisor/core/entity/crypto_data/relative_strength_index_model.dart';

class DataAssetState {
  List<RelativeStrengthIndexModel> rsi = [];

  List<CandleDataEntity> candles = [];

  DataAssetState copyWith({
    List<RelativeStrengthIndexModel>? rsi,
    List<CandleDataEntity>? candles,
  }) {
    return DataAssetState()
      ..rsi = rsi ?? this.rsi
      ..candles = candles ?? this.candles;
  }
}
