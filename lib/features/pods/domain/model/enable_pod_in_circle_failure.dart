import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class EnablePodInCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const EnablePodInCircleFailure.unknown([this.cause]) : type = EnablePodInCircleFailureType.unknown;

  final EnablePodInCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case EnablePodInCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'EnablePodInCircleFailure{type: $type, cause: $cause}';
}

enum EnablePodInCircleFailureType {
  unknown,
}
