import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'visitors_event.dart';
part 'visitors_state.dart';

class VisitorsBloc extends Bloc<VisitorsEvent, VisitorsState> {
  @override
  VisitorsState get initialState => VisitorsInitial();

  @override
  Stream<VisitorsState> mapEventToState(
    VisitorsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
