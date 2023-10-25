import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchBarRecipes extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  const SearchBarRecipes({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  _SearchBarRecipesState createState() => _SearchBarRecipesState();
}

class _SearchBarRecipesState extends State<SearchBarRecipes> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  widget.onSubmitted(value);
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: Icon(
                  Icons.search,
                  color: primaryColor,
              ),
              onPressed: () {
                widget.onSubmitted(_textEditingController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
