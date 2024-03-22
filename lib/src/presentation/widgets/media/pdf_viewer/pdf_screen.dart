import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_widget/build_app_bar_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  final String screenTitle;
  final String pdfLink;
  final bool showAppBar;
  final bool isNetworkPDF;

  const PDFScreen({
    Key? key,
    required this.pdfLink,
    required this.screenTitle,
    this.showAppBar = true,
    this.isNetworkPDF = true,
  }) : super(key: key);

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.showAppBar
          ? buildAppBarWidget(
              context,
              title: widget.screenTitle,
              isHaveBackButton: true,
              onBackButtonPressed: () => Navigator.pop(context),
            )
          : null,
      body: widget.isNetworkPDF
          ? SfPdfViewer.network(
              widget.pdfLink,
            )
          : SfPdfViewer.file(
              File(widget.pdfLink),
            ),
    );
  }
}
