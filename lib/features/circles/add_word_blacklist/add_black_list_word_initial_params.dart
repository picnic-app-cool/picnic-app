import 'package:picnic_app/features/chat/domain/model/id.dart';

class AddBlackListWordInitialParams {
  const AddBlackListWordInitialParams({
    required this.circleId,
    this.word = '',
  });

  final Id circleId;
  final String word;
}
