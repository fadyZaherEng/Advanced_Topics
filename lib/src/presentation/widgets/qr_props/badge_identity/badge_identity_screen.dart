import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/core/utils/new/show_massage_dialog_widget.dart';
import 'package:flutter_advanced_topics/src/di/injector.dart';
import 'package:flutter_advanced_topics/src/domain/use_case/internet/get_no_internet_use_case.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/advanced_way_to_fix_internet/network_connectivity.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/badge_identity_bloc/badge_identity_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/qr_props/badge_identity/skeleton/badge_identity_skeleton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

//ACCELERATION VALUE
//The value of acceleration of a body that is not moving is zero.
// Acceleration is defined as the rate of change of velocity with respect to time.
// If an object is not changing its velocity, then its acceleration is zero.
// This means that the object is either at rest or moving at a constant velocity.
//العجلة معدل التغير في السرعه فلة الجسم ماشي بسرعه منتظمه العجله تساوي صفر
//او لو الجسم ساكن او واقف فهنا لما احرك ال فون حركة شديده فيمه العجله بتتغير
// من صفر ل value قيمتها على حسب قوة حركه الفون فهو هنا بيسمع لل قيمه لو وصلت 30 بيدخل على ال dentifyومحدد فيمه كبيره
// عشان ميدخلش الا لما اليوزر يهز الفون هزه قوه ميدخلش على الفاضي والمليان

class BadgeIdentityScreen extends BaseStatefulWidget {
  const BadgeIdentityScreen({super.key});

  @override
  BaseState<BaseStatefulWidget> baseCreateState() =>
      _BadgeIdentityScreenState();
}

class _BadgeIdentityScreenState extends BaseState<BadgeIdentityScreen>
    with WidgetsBindingObserver {
  BadgeIdentityBloc get _bloc => BlocProvider.of<BadgeIdentityBloc>(context);

  CompoundConfiguration _compoundConfiguration = const CompoundConfiguration();
  BadgeIdentity _badgeIdentity = const BadgeIdentity();

  final _noScreenshot = NoScreenshot.instance;

  Timer? _timer;
  int _secondsRemaining = 0;

  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _setSecureFlag();
    _preventShake();
    _bloc.add(GetCompoundConfigurationEvent());
    _internetConnectionListener();
    super.initState();
  }

  void _setSecureFlag() async {
    await _noScreenshot.screenshotOff();
  }

  void _preventShake() async {
    await SetCanNavigateToBadgeScreenUseCase(injector())(false);
  }

  bool _isReadyToCallAPI = true;
  bool _isAppInBackground = false;
  bool _isFirstCall = false;

  void _internetConnectionListener() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) async {
      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.wifi:
          isOnline = _source.values.toList()[0];
          break;
        case ConnectivityResult.none:
        default:
          isOnline = false;
      }
      if (isOnline &&
          _isReadyToCallAPI &&
          _isFirstCall &&
          _secondsRemaining == 0) {
        _getBadgeIdentityEvent(isShowSkeleton: true);
        _isReadyToCallAPI = false;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _preventShake();
      _isReadyToCallAPI = true;
      _isAppInBackground = false;
      if (_secondsRemaining == 0) {
        _getBadgeIdentityEvent(isShowSkeleton: true);
      }
    } else if (state == AppLifecycleState.paused) {
      _isReadyToCallAPI = false;
      _isAppInBackground = true;
    }
  }

  void startTimer() {
    _secondsRemaining =
        7; // _compoundConfiguration.compoundSetting.badgeExpiredTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          _isReadyToCallAPI = false;
        } else {
          _timer?.cancel();
          _isReadyToCallAPI = true;
          _getBadgeIdentityEvent(isShowSkeleton: true);
        }
      });
    });
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<BadgeIdentityBloc, BadgeIdentityState>(
      listener: (context, state) {
        _timer?.cancel();
        startTimer();
        if (state is ShowLoadingState) {
          showLoading();
        } else if (state is HideLoadingState) {
          hideLoading();
        } else if (state is GetCompoundConfigurationState) {
          _compoundConfiguration = state.compoundConfiguration;
          _getBadgeIdentityEvent(isShowSkeleton: true);
          _isFirstCall = true;
          _internetConnectionListener();
        } else if (state is GetBadgeIdentitySuccessState) {
          _badgeIdentity = state.badgeIdentity;
          _timer?.cancel();
          startTimer();
        } else if (state is GetBadgeIdentityErrorState) {
          showMassageDialogWidget(
            context: context,
            text: state.errorMessage,
            icon: ImagePaths.error,
            buttonText: "OK",
            onTap: () {
              Navigator.pop(context);
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: "S.of(context).badgeIdentity",
            isHaveBackButton: true,
            onBackButtonPressed: () => Navigator.pop(context),
          ),
          body: state is ShowSkeletonState ||
                  state is GetCompoundConfigurationState
              ? _buildSkeleton()
              : _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() => SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () => _onTapImage("_badgeIdentity.users.image"),
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorSchemes.gray,
                          // color of the border
                          width: 2, // width of the border
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 8,
                            spreadRadius: 3,
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          height: 145,
                          width: 145,
                          "_badgeIdentity.users.image",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            width: 145,
                            height: 145,
                            ImagePaths.imagePlaceHolder,
                            fit: BoxFit.cover,
                          ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                                height: 145,
                                width: 145,
                                child: SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ColorSchemes.gray,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      " _badgeIdentity.users.userName",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorSchemes.primary,
                            letterSpacing: -0.24,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 60,
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ColorSchemes.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        _secondsRemaining.toString(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: ColorSchemes.white,
                              fontSize: 20,
                              letterSpacing: -0.24,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => _onTapImage(_badgeIdentity.qrImage),
                    child: Image.network(
                      _badgeIdentity.qrImage,
                      height: 240,
                      width: 240,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        ImagePaths.imagePlaceHolder,
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          width: 240,
                          height: 240,
                          child: Center(
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                height: 240,
                                width: 240,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: DottedLine(
                      dashColor: ColorSchemes.primary,
                      dashGapLength: 4,
                      dashLength: 4,
                      lineThickness: 2,
                      direction: Axis.horizontal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImagePaths.unitBadge,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "Unit",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.gray,
                                  letterSpacing: -0.24,
                                ),
                          ),
                        ),
                        Text(
                          " _badgeIdentity.compoundUnits.name",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          ImagePaths.userBadge,
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            " _badgeIdentity.userType.name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorSchemes.gray,
                                  letterSpacing: -0.24,
                                ),
                          ),
                        ),
                        Text(
                          " _badgeIdentity.users.userName",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorSchemes.black,
                                    letterSpacing: -0.24,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: SvgPicture.asset(
                      ImagePaths.logo,
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildSkeleton() => const BadgeIdentitySkeleton();

  @override
  void dispose() async {
    super.dispose();
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    await _noScreenshot.screenshotOn();
    await SetCanNavigateToBadgeScreenUseCase(injector())(true);
  }

  void _getBadgeIdentityEvent({required bool isShowSkeleton}) {
    if (GetNoInternetUseCase(injector())() ||
        !_isReadyToCallAPI ||
        _isAppInBackground) return;
    _bloc.add(GetBadgeIdentityEvent(isShowSkeleton: isShowSkeleton));
  }

  void _onTapImage(String image) {
    // Navigator.pushNamed(context, Routes.galleryImages,
    //     arguments: GalleryImages(initialIndex: 0, images: [
    //       GalleryAttachment(attachment: image),
    //     ]));
  }
}

class BadgeIdentity extends Equatable {
  final int id;
  final String qrImage;
  final int pinCode;
  final String expiredDate;

  const BadgeIdentity({
    this.id = 0,
    this.qrImage = "",
    this.pinCode = 0,
    this.expiredDate = "",
  });

  @override
  List<Object> get props => [
        id,
        qrImage,
        pinCode,
        expiredDate,
      ];
}

class CompoundConfiguration {
  final String name;
  final String description;
  const CompoundConfiguration({
    this.name = "",
    this.description = "",
  });
}

class SetCanNavigateToBadgeScreenUseCase {
  final SharedPreferences sharedPreferences;

  SetCanNavigateToBadgeScreenUseCase(this.sharedPreferences);

  Future<bool> call(bool value) {
    return sharedPreferences.setBool("isNavigationToBadge", value);
  }
}
