
import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/utils/new_utils/constants.dart';

class ResidentServicesUnitsWidget extends StatefulWidget {
  final List<String> residentServicesUnits;

  const ResidentServicesUnitsWidget({
    super.key,
    required this.residentServicesUnits,
  });

  @override
  State<ResidentServicesUnitsWidget> createState() =>
      _ResidentServicesUnitsWidgetState();
}

class _ResidentServicesUnitsWidgetState
    extends State<ResidentServicesUnitsWidget> {
  var _displayAll = false;
  List<String> showList = [];

  @override
  void initState() {
    showList = widget.residentServicesUnits;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = _displayAll ? widget.residentServicesUnits.length : 6;
    showList = widget.residentServicesUnits.sublist(0, size);
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        children: showList
            .asMap()
            .entries
            .map((e) => _buildResidentServicesUnit(
                context, widget.residentServicesUnits[e.key]))
            .toList()
          ..add(_seeNoSeeMore(context)));
  }

  Widget _seeNoSeeMore(context) {
    return InkWell(
      onTap: () => setState(() => _displayAll = !_displayAll),
      child: Text(
        _displayAll ?" S.of(context).seeLess" : "S.of(context).seeMoreDot",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: ColorSchemes.primary,
              fontWeight: Constants.fontWeightMedium,
              letterSpacing: -0.24,
            ),
      ),
    );
  }

  Widget _buildResidentServicesUnit(
    BuildContext context,
    String residentServices,
  ) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: ColorSchemes.iconBackGround,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          residentServices,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ColorSchemes.primary,
                letterSpacing: -0.13,
              ),
        ),
      );
}
