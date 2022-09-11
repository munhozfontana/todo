import 'package:todo/app/data/external/interfaces/i_user_external.dart';
import 'package:todo/app/data/models/user_model.dart';
import 'package:todo/core/adapters/api_adapter.dart';
import 'package:todo/core/adapters/i_api_adapter.dart';
import 'package:todo/core/environment.dart';
import 'package:todo/core/errors/i_business_exception.dart';

class UserExternal implements IUserExternal {
  final IApiAdapter iApiAdapter;

  UserExternal({
    required this.iApiAdapter,
  });

  @override
  Future<String> signIn(UserModel model) async {
    final res = await iApiAdapter.postHttp(
      '${Environment.host.value}/user/sign-in',
      body: model.toJson(),
    );

    if (res.body == null) {
      throw ExternalException('body not found');
    }

    return toMap(res)['token'];
  }

  @override
  Future<void> signUp(UserModel model) async {
    await iApiAdapter.postHttp(
      '${Environment.host.value}/user/sign-up',
      body: model.toJson(),
    );
  }
}
