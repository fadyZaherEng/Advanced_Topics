class VisibiltyDetectorScreen extends StatefulWidget {
  const VisibiltyDetectorScreen({super.key});

  @override
  State<VisibiltyDetectorScreen> createState() =>
      _VisibiltyDetectorScreenState();
}

class _VisibiltyDetectorScreenState extends State<VisibiltyDetectorScreen> {
  bool _isFooterVisible = true;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('footer'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 0) {
          _isFooterVisible = false;
        } else if (info.visibleFraction == 1) {
          _isFooterVisible = true;
        } else {
          _isFooterVisible = true;
        }
        setState(() {});
      },
      child: const Text('Footer'),
    );
  }
}
