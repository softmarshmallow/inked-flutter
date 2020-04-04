abstract class BaseRepository<T> {
  List<T> DATA = [];

  set(List<T> data);

  bool add(T data);
}
