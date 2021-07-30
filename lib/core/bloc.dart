import 'dart:async';

abstract class Bloc<Event, State> {
  late State state;

  Bloc({required State initial}) {
    state = initial;
    _eventOutput.asyncExpand(mapEventToState).listen(_update);
  }

  final StreamController<State> _streamState = StreamController<State>();
  final StreamController<Event> _streamEvent = StreamController<Event>();

  Stream<Event> get _eventOutput => _streamEvent.stream;

  Sink<Event> get _eventInput => _streamEvent.sink;

  Stream<State> get stream => _streamState.stream;

  Sink<State> get _stateInput => _streamState.sink;

  void add(Event event) => _eventInput.add(event);

  void _update(State state) {
    this.state = state;
    _stateInput.add(state);
  }

  Stream<State> mapEventToState(Event event);

  void dispose() {
    _streamEvent.close();
    _streamState.close();
  }
}
