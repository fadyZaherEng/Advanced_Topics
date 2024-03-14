import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/convert_string_to_date_format.dart';
import 'package:city_eye/src/core/utils/english_numbers.dart';
import 'package:city_eye/src/core/utils/extensions/color_extension.dart';
import 'package:city_eye/src/core/utils/format_date_time.dart';
import 'package:city_eye/src/core/utils/payments_key.dart';
import 'package:city_eye/src/domain/entities/payment/payment.dart';
import 'package:city_eye/src/domain/entities/settings/compound_currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_banners/super_banners.dart';

class PaymentsWidget extends StatelessWidget {
  final List<Payment> payments;
  final void Function(Payment payment) onTapPayNowAction;
  final Function() onPullToRefresh;
  final CompoundCurrency compoundCurrency;
  final void Function(Payment payment) onPaymentCardTap;

  const PaymentsWidget({
    super.key,
    required this.payments,
    required this.onTapPayNowAction,
    required this.onPullToRefresh,
    required this.compoundCurrency,
    required this.onPaymentCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => onPullToRefresh(),
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: payments.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: InkWell(
                  onTap: () => onPaymentCardTap(payments[index]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorSchemes.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                            color: ColorSchemes.lightGray,
                            offset: Offset(0, 1),
                            blurRadius: 50,
                            spreadRadius: 0)
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: ColorSchemes.paymentCardColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    payments[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: ColorSchemes.primary,
                                            letterSpacing: -0.13),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  englishNumbers(formatDateTime(convertStringToDateFormat(
                                      payments[index].createDate))),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: ColorSchemes.black,
                                          letterSpacing: -0.13),
                                )
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          alignment:
                              Directionality.of(context) == TextDirection.ltr
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                          children: [
                            Directionality(
                              textDirection: Directionality.of(context),
                              child: CornerBanner(
                                bannerPosition: Directionality.of(context) ==
                                        TextDirection.ltr
                                    ? CornerBannerPosition.topLeft
                                    : CornerBannerPosition.topRight,
                                bannerColor: payments[index]
                                    .paymentStatus
                                    .extraValue1
                                    .toColor(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                      payments[index].paymentStatus.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: ColorSchemes.white,
                                            fontSize: 12,
                                            letterSpacing: -0.24,
                                          )),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${payments[index].amount.toString()} ${payments[index].currency.code}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: ColorSchemes.black,
                                                  letterSpacing: -0.16,
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                S.of(context).dueDate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                      color: ColorSchemes
                                                          .secondary,
                                                      letterSpacing: -0.12,
                                                    ),
                                              ),
                                              const SizedBox(width: 20),
                                              Text(
                                                formatDateTime(
                                                    convertStringToDateFormat(
                                                        payments[index]
                                                            .dueDate)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge!
                                                    .copyWith(
                                                      color: ColorSchemes
                                                          .secondary,
                                                      letterSpacing: -0.12,
                                                    ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    payments[index].description,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: ColorSchemes.gray,
                                          letterSpacing: -0.24,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        payments[index].paymentStatus.code ==
                                PaymentsKey.needPayment
                            ? InkWell(
                                onTap: () => onTapPayNowAction(payments[index]),
                                child: Column(
                                  children: [
                                    Container(
                                        height: 1,
                                        color: ColorSchemes.lightGray),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            ImagePaths.payment,
                                            fit: BoxFit.scaleDown,
                                            matchTextDirection: true,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            S.of(context).payNow,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: ColorSchemes.black,
                                                  letterSpacing: -0.24,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

//Directionality(
//                     textDirection: Directionality.of(context),
//                     child: CornerBanner(
//                       bannerPosition: Directionality.of(context) == TextDirection.ltr ? CornerBannerPosition.topLeft : CornerBannerPosition.topRight,
//                       bannerColor: payments[index].paymentStatus.extraValue1.toColor(),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2,
//                         ),
//                         child: Text(payments[index].paymentStatus.name,
//                             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                               color: ColorSchemes.white,
//                               fontSize: 14,
//                               letterSpacing: -0.24,
//                             )),
//                       ),
//                     ),
//                   ),
