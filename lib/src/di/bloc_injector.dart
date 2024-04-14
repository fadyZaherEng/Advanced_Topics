import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/presentation/boc/login/log_in_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/media/new_media/add_payment/add_payment_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer_auto_fill_and_sms/otp_bloc/otp_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/otp_all_way/otp_with_timer_auto_fill_and_sms/utils/timer_ticker.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/badge_identity_bloc/badge_identity_bloc.dart';

Future<void> initializeBlocDependencies() async {
  injector.registerFactory<LogInBloc>(
    () => LogInBloc(
      injector(),
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<AddPaymentBloc>(
    () => AddPaymentBloc(),
  );
  injector.registerSingleton<BadgeIdentityBloc>(BadgeIdentityBloc());
  injector.registerFactory<OtpBloc>(() => OtpBloc(TimerTicker()));
}
