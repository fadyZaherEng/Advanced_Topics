class CustomImageBuilderWidget extends StatelessWidget {
  const CustomImageBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      user.image ?? '',
      fit: BoxFit.fill,
      matchTextDirection: true,
      frameBuilder:
          (context, child, frame, wasSynchronouslyLoaded) =>
          Container(
            clipBehavior: Clip.antiAlias,
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorSchemes.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              clipBehavior: Clip.antiAlias,
              child: child,
            ),
          ),
      errorBuilder: (context, error, stackTrace) => Container(
        clipBehavior: Clip.antiAlias,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorSchemes.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.asset(
            ImagePaths.profile,
            fit: BoxFit.fill,
          ),
        ),
      ),
      loadingBuilder: (context, child, loadingProgress) =>
      loadingProgress == null
          ? child
          : Container(
        clipBehavior: Clip.antiAlias,
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: ColorSchemes.gray,
          border: Border.all(
            color: ColorSchemes.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          clipBehavior: Clip.antiAlias,
          child: SkeletonLine(
            style: SkeletonLineStyle(
              width: 48,
              height: 48,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    ),
  }
}
