import 'dart:developer';

import 'package:password_dart/password_dart.dart';

import '../../core/errors/errors.dart';
import '../apis/dto/i_dto.dart';
import '../apis/dto/user/user_dto.dart';
import '../dao/user_dao.dart';
import '../entities/user_entity.dart';
import 'utils/generic_service.dart';

class UserService implements GenericService<UserModel> {
  final UserDao _dao;
  UserService(this._dao);

  Future<UserModel?> authenticate(UserModel dto) async {
    try {
      var user = await _dao.findByEmail(dto.email);
      if (user == null) {
        throw IBusinessException('User not found');
      }
      if (Password.verify(dto.password, user.password)) {
        return user;
      } else {
        throw IBusinessException('User not authorized');
      }
    } catch (e) {
      log('[ERROR] -> in Authenticate method by email ${dto.email}');
    }
    return null;
  }

  @override
  Future<bool> delete(int id) async => _dao.delete(id);

  @override
  Future<List<UserDto>> findAll() async {
    final result = await _dao.findAll();
    return result.map((e) => UserDto.fromMap(e.toMap())).toList();
  }

  @override
  Future<UserDto> findOne(int id) async {
    final result = await _dao.findOne(id);
    if (result == null) {
      throw IBusinessException('task not exists');
    }
    return UserDto.fromMap(result.toMap());
  }

  @override
  Future<IDto> save(UserModel value) async {
    if (value.id != null) {
      await _emailValidate(value);
      UserModel oldModel = (await _dao.findOne(value.id!))!;
      final refreshModel = oldModel.copyWith(
        email: value.email,
        password: value.password,
      );
      await _dao.update(refreshModel);
      return UserDto.fromMap(refreshModel.toMap());
    } else {
      await _emailValidate(value);
      final hash = Password.hash(value.password, PBKDF2(iterationCount: 20));
      value.password = hash;
      value.id = await _dao.create(value);
      return (await findOne(value.id!));
    }
  }

  Future<void> _emailValidate(UserModel value) async {
    if ((await _dao.findByEmail(value.email)) != null) {
      throw UniqueValuesException("Email already registered");
    }
  }
}
