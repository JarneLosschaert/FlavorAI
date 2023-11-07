class FilterState {
  String filter;
  bool displayed = false;
  String value = '...';
  List<String> items = [];

  FilterState(this.filter, this.items){
    items = ['...'] + items;
  }
}