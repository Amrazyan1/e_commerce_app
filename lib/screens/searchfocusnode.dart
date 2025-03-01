import 'package:flutter/cupertino.dart';

class SearchFocusService {
  static final SearchFocusService _instance = SearchFocusService._internal();
  factory SearchFocusService() => _instance;

  SearchFocusService._internal();

  final FocusNode searchFocusNode = FocusNode();
}

final searchFocusService = SearchFocusService();
