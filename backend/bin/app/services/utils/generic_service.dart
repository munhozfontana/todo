import '../../apis/dto/i_dto.dart';

abstract class GenericService<T> {
  Future<IDto?> findOne(int id);
  Future<List<IDto>> findAll();
  Future<IDto> save(T value);
  Future<bool> delete(int id);
}
