class FilterState {
  String filter;
  bool displayed = false;
  String value = '...';
  List<String> items = [];

  FilterState(this.filter, this.items) {
    if (filter == 'includeIngredients') {
      displayed = true;
    } else {
      items = ['...'] + items;
    }
  }
}