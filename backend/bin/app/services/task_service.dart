import '../apis/dto/task/task_dto.dart';
import '../dao/task_dao.dart';
import '../entities/task_entity.dart';
import 'utils/generic_service.dart';

class TaskService implements GenericService<TaskEntity> {
  final TaskDao _dao;

  TaskService(this._dao);

  @override
  Future<bool> delete(int id) {
    return _dao.delete(id);
  }

  @override
  Future<List<TaskDto>> findAll() async {
    final result = await _dao.findAll();
    return result.map((e) => TaskDto.fromMap(e.toMap())).toList();
  }

  @override
  Future<TaskDto?> findOne(int id) async {
    final result = await _dao.findOne(id);
    if (result != null) {
      return TaskDto.fromMap(result.toMap());
    }
  }

  @override
  Future<TaskDto> save(TaskEntity value) async {
    if (value.id != null) {
      await _dao.update(value);
      return (await findOne(value.id!))!;
    } else {
      value.id = await _dao.create(value);
      return (await findOne(value.id!))!;
    }
  }
}
