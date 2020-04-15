abstract class BaseRepository<T> {
  List<T> DATA = [];

  set(List<T> data){
    DATA = data;
  }

  bool add(T data);

  bool remove(T data){
    try{
      DATA.remove(data);
      return true;
    }catch(e){
      return false;
    }
  }

  seed();
}
