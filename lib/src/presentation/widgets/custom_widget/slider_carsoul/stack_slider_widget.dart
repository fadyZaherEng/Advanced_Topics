import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

class ProjectSliderWidget extends StatefulWidget {
  final List<String> projectImages;
  final double mSquare;
  final double? height;
  final Function(String)? onTap;

  const ProjectSliderWidget({
    Key? key,
    required this.projectImages,
    this.onTap,
    this.height = 200,
    required this.mSquare,
  }) : super(key: key);

  @override
  State<ProjectSliderWidget> createState() => _ProjectSliderWidgetState();
}

class _ProjectSliderWidgetState extends State<ProjectSliderWidget> {
  final CarouselController _controller = CarouselController();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          clipBehavior: Clip.none,
          height: widget.height,
          width: double.infinity,
          child: CarouselSlider(
            items: widget.projectImages.map((logo) {
              return _sliderImage(logo);
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
        PositionedDirectional(
          start: 12,
          end: 12,
          top: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorSchemes.white.withOpacity(0.8),
                  borderRadius: const BorderRadiusDirectional.all(
                    Radius.circular(240),
                  ),
                ),
                child: SvgPicture.asset(
                  ImagePaths.logo,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                height: 28,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: ColorSchemes.white.withOpacity(0.8),
                  borderRadius: const BorderRadiusDirectional.all(
                    Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "startingFrom",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ColorSchemes.black,
                        letterSpacing: -0.24,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(ImagePaths.aboutUs),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.mSquare} ${"mSquare"}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorSchemes.primary,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.projectImages.asMap().entries.map((entry) {
              return _sliderIndicator(entry);
            }).toList())
      ],
    );
  }

  Widget _sliderImage(String logo) {
    return InkWell(
      onTap: () => widget.onTap!(logo),
      child: logo.isNotEmpty
          ? Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(12),
                  topEnd: Radius.circular(12),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(12),
                  topEnd: Radius.circular(12),
                ),
                child: Image.network(
                  logo,
                  fit: BoxFit.fill,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                        ),
                        child: Image.asset(
                          ImagePaths.eventDetailsPlaceHolder,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: SkeletonLine(
                          style: SkeletonLineStyle(
                        width: double.infinity,
                        height: 200,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(12),
                          topEnd: Radius.circular(12),
                        ),
                      )),
                    );
                  },
                ),
              ),
            )
          : _buildPlaceHolderImage(),
    );
  }

  Widget _sliderIndicator(MapEntry<int, String> entry) {
    return InkWell(
      onTap: () {
        _controller.animateToPage(entry.key);
      },
      child: Container(
        height: 8,
        width: 8,
        margin: const EdgeInsetsDirectional.only(bottom: 16, start: 4, end: 4),
        decoration: BoxDecoration(
          color: _currentIndex == entry.key
              ? ColorSchemes.primary
              : ColorSchemes.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildPlaceHolderImage() {
    return Image.asset(
      ImagePaths.eventDetailsPlaceHolder,
      fit: BoxFit.fill,
    );
  }
}
