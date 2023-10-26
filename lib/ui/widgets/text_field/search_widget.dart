import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextFormField textFormField;

  const SearchWidget({
    super.key,
    required this.textFormField,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black26,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: textFormField,
          ),
        ],
      ),
    );
  }
}