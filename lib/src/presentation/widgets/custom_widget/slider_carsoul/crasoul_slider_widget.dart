import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:skeletons/skeletons.dart';

class Offer {
  final String attachment;
  Offer({
    required this.attachment,
  });
}

class SliderWidget extends StatefulWidget {
  final List<Offer> offers;
  final double? height;
  final Function(Offer)? onTap;

  const SliderWidget({
    Key? key,
    required this.offers,
    this.onTap,
    this.height = 200,
  }) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          clipBehavior: Clip.none,
          height: widget.height,
          width: double.infinity,
          child: CarouselSlider(
            items: widget.offers.map((offer) {
              return _sliderImage(offer);
            }).toList(),
            carouselController: _controller,
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              scrollPhysics: const BouncingScrollPhysics(),
              enableInfiniteScroll: false,
              disableCenter: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.offers.asMap().entries.map((entry) {
              return _sliderIndicator(entry);
            }).toList())
      ],
    );
  }

  Widget _sliderImage(Offer offer) {
    return InkWell(
      onTap: () => widget.onTap!(offer),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        child: offer.attachment.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: offer.attachment,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _buildPlaceHolderImage(),
                placeholder: (context, url) {
                  return const SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          shape: BoxShape.rectangle,
                        ),
                      ));
                },
              )
            : _buildPlaceHolderImage(),
      ),
    );
  }

  Widget _sliderIndicator(MapEntry<int, Offer> entry) {
    return InkWell(
      onTap: () {
        _controller.animateToPage(entry.key);
      },
      child: Container(
        height: 8,
        width: 8,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _currentIndex == entry.key
              ? ColorSchemes.primary
              : ColorSchemes.lightGray,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.imagePlaceHolder,
      fit: BoxFit.fill,
    );
  }
}
