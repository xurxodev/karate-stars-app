import 'package:karate_stars_app/src/common/presentation/states/option.dart';

class NewsFilterState {
  final List<Option> typeOptions;
  final String selectedType;

  NewsFilterState({required this.typeOptions, required this.selectedType});

  NewsFilterState copyWith({final String? selectedType}) {
    return NewsFilterState(
        typeOptions: typeOptions,
        selectedType: selectedType ?? this.selectedType);
  }

  bool get anyFilter {
    return typeOptions.isNotEmpty && selectedType != typeOptions[0].id;
  }
}
