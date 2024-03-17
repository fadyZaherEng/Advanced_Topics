import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'badge_identity_event.dart';
part 'badge_identity_state.dart';

class BadgeIdentityBloc extends Bloc<BadgeIdentityEvent, BadgeIdentityState> {
  BadgeIdentityBloc() : super(BadgeIdentityInitial()) {
    on<BadgeIdentityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
