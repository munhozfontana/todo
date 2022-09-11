abstract class ITaskExternal {
  Future<int> add(Map entity);
  Future<bool> update(Map entity);
  Future<List<Map>> findAll();
  Future<bool> delete(int id);
}
