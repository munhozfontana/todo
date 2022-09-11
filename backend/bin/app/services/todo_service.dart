import '../../core/errors/errors.dart';
import '../apis/dto/todo/todo_dto.dart';
import '../dao/todo_dao.dart';
import '../entities/todo_entity.dart';
import 'utils/generic_service.dart';

class TodoService implements GenericService<TodoEntity> {
  final TodoDao _dao;

  TodoService(this._dao);

  @override
  Future<bool> delete(int id) {
    return _dao.delete(id);
  }

  @override
  Future<List<TodoDto>> findAll() async {
    final result = await _dao.findAll();
    return result.map((e) => TodoDto.fromMap(e.toMap())).toList();
  }

  @override
  Future<TodoDto> findOne(int id) async {
    final result = await _dao.findOne(id);
    if (result == null) {
      throw IBusinessException('task not exists');
    }
    return TodoDto.fromMap(result.toMap());
  }

  @override
  Future<TodoDto> save(TodoEntity value) async {
    if (value.id != null) {
      await _dao.update(value);
      return (await findOne(value.id!));
    } else {
      value.id = await _dao.create(value);
      return (await findOne(value.id!));
    }
  }
}
