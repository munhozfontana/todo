import 'package:todo/core/errors/i_business_exception.dart';
import 'package:todo/injection.dart';
import 'package:todo/main_controller.dart';

mixin ErrorHelperMixin {
  MainController mainController = inject<MainController>();
  onError(IBusinessException error) {
    return mainController.onError(error);
  }

  onMessage(String message) {
    return mainController.onMessage(message);
  }
}
