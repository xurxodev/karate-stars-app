import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/events/domain/boundaries/event_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class GetEventsUseCase {
  final EventRepository _eventRepository;

  GetEventsUseCase(this._eventRepository);

  Future<List<Event>> execute(ReadPolicy readPolicy) async {
    final data = await _eventRepository.getAll(readPolicy);

    data.sort((a, b) => a.name.compareTo(b.name));

    return data;
  }
}
