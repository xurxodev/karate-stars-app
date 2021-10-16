import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/event_types/domain/boundaries/event_type_repository.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class GetEventTypesUseCase {
  final EventTypeRepository _eventTypeRepository;

  GetEventTypesUseCase(this._eventTypeRepository);

  Future<List<EventType>> execute(ReadPolicy readPolicy) async {
    final data = await _eventTypeRepository.getAll(readPolicy);

    data.sort((a, b) => a.name.compareTo(b.name));

    return data;
  }
}
