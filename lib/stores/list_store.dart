import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle ="";
  @action
  setNewTodoTitle(String value) => newTodoTitle = value;
  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;

  @observable
  ObservableList<String> todoList = ObservableList<String>();
  //List<String> todoList = [];
  @action
  setNewItemInTodoList(){
    todoList.add(newTodoTitle);
    //todoList = List.from(todoList..add(newTodoTitle));

  }
}