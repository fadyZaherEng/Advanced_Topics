import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/config/theme/color_schemes.dart';
import 'package:flutter_advanced_topics/src/core/resource/image_paths.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/pagination/project_model.dart';
import 'package:flutter_svg/flutter_svg.dart';




class PaginationWidget extends StatefulWidget {
  final Function(List<Project> displayList) onPageChange;
  final int itemsPerPage;
  final List<Project> projectsList;

  const PaginationWidget({
    super.key,
    required this.onPageChange,
    required this.itemsPerPage,
    required this.projectsList,
  });

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int _totalPages = 0;
  int _currentPageNumber = 0;
  int _startPage = 0;
  int _endPage = 0;
  List<Project> _displayedList = [];

  @override
  void initState() {
    super.initState();
    _totalPages = (widget.projectsList.length / widget.itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    _startPage =
        _currentPageNumber - (_currentPageNumber % widget.itemsPerPage);
    _endPage = _startPage + widget.itemsPerPage;
    if (_endPage > _totalPages) {
      _endPage = _totalPages;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (_currentPageNumber > 0) {
              _currentPageNumber--;
              int startPage = _currentPageNumber * widget.itemsPerPage;
              int endPage = startPage + widget.itemsPerPage;
              if (endPage > widget.projectsList.length) {
                endPage = widget.projectsList.length;
              }
              setState(() {
                _displayedList =
                    widget.projectsList.getRange(startPage, endPage).toList();
                // TODO: implement update displayed list
                widget.onPageChange(_displayedList);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: ColorSchemes.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImagePaths.arrowRight,
                width: 16,
                height: 16,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  (_currentPageNumber == 0)
                      ? ColorSchemes.gray
                      : ColorSchemes.primary,
                  BlendMode.srcIn,
                ),
                matchTextDirection: true,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _totalPages > 3 &&
              _currentPageNumber != 0 &&
              _currentPageNumber != 1 &&
              _currentPageNumber != 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              "...",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorSchemes.gray,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_endPage - _startPage, (index) {
            int pageIndex = _startPage + index;
            return Padding(
              padding: const EdgeInsets.all(4),
              child: InkWell(
                onTap: () {
                  _currentPageNumber = pageIndex;
                  int startPage = _currentPageNumber * widget.itemsPerPage;
                  int endPage = startPage + widget.itemsPerPage;
                  if (endPage > widget.projectsList.length) {
                    endPage = widget.projectsList.length;
                  }
                  setState(() {
                    _displayedList = widget.projectsList
                        .getRange(startPage, endPage)
                        .toList();
                    // TODO: implement update displayed list
                    widget.onPageChange(_displayedList);
                  });
                },
                child: Text(
                  '${pageIndex + 1}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _currentPageNumber == pageIndex
                        ? ColorSchemes.primary
                        : ColorSchemes.gray,
                  ),
                ),
              ),
            );
          }),
        ),
        Visibility(
          visible: _currentPageNumber != _totalPages - 1 && _totalPages > 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              "...",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorSchemes.gray,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (_currentPageNumber < _totalPages - 1) {
              _currentPageNumber++;
              int startPage = _currentPageNumber * widget.itemsPerPage;
              int endPage = startPage + widget.itemsPerPage;
              if (endPage > widget.projectsList.length) {
                endPage = widget.projectsList.length;
              }
              setState(() {
                _displayedList =
                    widget.projectsList.getRange(startPage, endPage).toList();
                // TODO: implement update displayed list
                widget.onPageChange(_displayedList);
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: ColorSchemes.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImagePaths.arrowLeft,
                width: 16,
                height: 16,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  (_currentPageNumber == _totalPages - 1)
                      ? ColorSchemes.gray
                      : ColorSchemes.primary,
                  BlendMode.srcIn,
                ),
                matchTextDirection: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// class PaginationWidget extends StatefulWidget {
//   final Function(List<Project> displayList) onPageChange;
//   final int itemsPerPage;
//   final List<Project> projectsList;
//
//   const PaginationWidget({
//     super.key,
//     required this.onPageChange,
//     required this.itemsPerPage,
//     required this.projectsList,
//   });
//
//   @override
//   State<PaginationWidget> createState() => _PaginationWidgetState();
// }
//
// class _PaginationWidgetState extends State<PaginationWidget> {
//   int _totalPages = 0;
//   int _currentPageNumber = 0;
//   int _startPage = 0;
//   int _endPage = 0;
//   List<Project> _displayedList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _totalPages = (widget.projectsList.length / widget.itemsPerPage).ceil();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _startPage =
//         _currentPageNumber - (_currentPageNumber % widget.itemsPerPage);
//     _endPage = _startPage + widget.itemsPerPage;
//     if (_endPage > _totalPages) {
//       _endPage = _totalPages;
//     }
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           onTap: () {
//             if (_currentPageNumber > 0) {
//               _currentPageNumber--;
//               int startPage = _currentPageNumber * widget.itemsPerPage;
//               int endPage = startPage + widget.itemsPerPage;
//               if (endPage > widget.projectsList.length) {
//                 endPage = widget.projectsList.length;
//               }
//               setState(() {
//                 _displayedList =
//                     widget.projectsList.getRange(startPage, endPage).toList();
//                 // TODO: implement update displayed list
//                 widget.onPageChange(_displayedList);
//               });
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: ColorSchemes.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 2),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     color: Color.fromRGBO(0, 0, 0, 0.12),
//                   ),
//                 ],
//                 shape: BoxShape.circle,
//               ),
//               child: SvgPicture.asset(
//                 ImagePaths.arrowRight,
//                 width: 16,
//                 height: 16,
//                 fit: BoxFit.fill,
//                 colorFilter: ColorFilter.mode(
//                   (_currentPageNumber == 0)
//                       ? ColorSchemes.gray
//                       : ColorSchemes.primary,
//                   BlendMode.srcIn,
//                 ),
//                 matchTextDirection: true,
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           visible: _totalPages > 3 &&
//               _currentPageNumber != 0 &&
//               _currentPageNumber != 1 &&
//               _currentPageNumber != 2,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3),
//             child: Text(
//               "...",
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorSchemes.gray,
//               ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(_endPage - _startPage, (index) {
//             int pageIndex = _startPage + index;
//             return Padding(
//               padding: const EdgeInsets.all(4),
//               child: InkWell(
//                 onTap: () {
//                   _currentPageNumber = pageIndex;
//                   int startPage = _currentPageNumber * widget.itemsPerPage;
//                   int endPage = startPage + widget.itemsPerPage;
//                   if (endPage > widget.projectsList.length) {
//                     endPage = widget.projectsList.length;
//                   }
//                   setState(() {
//                     _displayedList = widget.projectsList
//                         .getRange(startPage, endPage)
//                         .toList();
//                     // TODO: implement update displayed list
//                     widget.onPageChange(_displayedList);
//                   });
//                 },
//                 child: Text(
//                   '${pageIndex + 1}',
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: _currentPageNumber == pageIndex
//                         ? ColorSchemes.primary
//                         : ColorSchemes.gray,
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//         Visibility(
//           visible: _currentPageNumber != _totalPages - 1 && _totalPages > 3,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3),
//             child: Text(
//               "...",
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: ColorSchemes.gray,
//               ),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (_currentPageNumber < _totalPages - 1) {
//               _currentPageNumber++;
//               int startPage = _currentPageNumber * widget.itemsPerPage;
//               int endPage = startPage + widget.itemsPerPage;
//               if (endPage > widget.projectsList.length) {
//                 endPage = widget.projectsList.length;
//               }
//               setState(() {
//                 _displayedList =
//                     widget.projectsList.getRange(startPage, endPage).toList();
//                 // TODO: implement update displayed list
//                 widget.onPageChange(_displayedList);
//               });
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: ColorSchemes.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 1),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     color: Color.fromRGBO(0, 0, 0, 0.12),
//                   ),
//                 ],
//                 shape: BoxShape.circle,
//               ),
//               child: SvgPicture.asset(
//                 ImagePaths.arrowLeft,
//                 width: 16,
//                 height: 16,
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   (_currentPageNumber == _totalPages - 1)
//                       ? ColorSchemes.gray
//                       : ColorSchemes.primary,
//                   BlendMode.srcIn,
//                 ),
//                 matchTextDirection: true,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// class PaginationWidget extends StatefulWidget {
//   final Function(List<Project> displayList) onPageChange;
//   final int itemsPerPage;
//   final List<Project> projectsList;
//
//   const PaginationWidget({
//     super.key,
//     required this.onPageChange,
//     required this.itemsPerPage,
//     required this.projectsList,
//   });
//
//   @override
//   State<PaginationWidget> createState() => _PaginationWidgetState();
// }
//
// class _PaginationWidgetState extends State<PaginationWidget> {
//   int _totalPages = 0;
//   int _currentPageNumber = 0;
//   int _startPage = 0;
//   int _endPage = 0;
//   List<Project> _displayedList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _totalPages = (widget.projectsList.length / widget.itemsPerPage).ceil();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_totalPages <= widget.itemsPerPage) {
//       _startPage = 0;
//       _endPage = _totalPages - 1;
//     } else {
//       //handle first edge cases
//       if (_currentPageNumber <= 1) {
//         _startPage = 0;
//         _endPage = widget.itemsPerPage - 1;
//       //handle last edge cases
//       } else if (_currentPageNumber >= _totalPages - 2) {
//         _startPage = _totalPages - 3;
//         _endPage = _totalPages - 1;
//         //handle middle page edge cases
//       } else {
//         _startPage = _currentPageNumber - 1;
//         _endPage = _currentPageNumber + 1;
//       }
//     }
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         InkWell(
//           onTap: () {
//             if (_currentPageNumber > 1) {
//               _currentPageNumber--;
//               _updateDisplayedList();
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: ColorSchemes.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 2),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     color: Color.fromRGBO(0, 0, 0, 0.12),
//                   ),
//                 ],
//                 shape: BoxShape.circle,
//               ),
//               child: SvgPicture.asset(
//                 ImagePaths.imagesIcArrowLeft,
//                 width: 16,
//                 height: 16,
//                 fit: BoxFit.fill,
//                 colorFilter: ColorFilter.mode(
//                   (_currentPageNumber == 0)
//                       ? ColorSchemes.gray
//                       : ColorSchemes.primary,
//                   BlendMode.srcIn,
//                 ),
//                 matchTextDirection: true,
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           visible: _totalPages > widget.itemsPerPage &&
//               _currentPageNumber != 0 &&
//               _currentPageNumber != 1,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3),
//             child: Text(
//               "...",
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: ColorSchemes.gray,
//                   ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           //zero indexed so increment by 1
//           children: List.generate(widget.itemsPerPage/*or _endPage-_startPage+1*/, (index) {
//             int pageIndex = _startPage + index;
//             return Padding(
//               padding: const EdgeInsets.all(4),
//               child: InkWell(
//                 onTap: () {
//                   _currentPageNumber = pageIndex;
//                   _updateDisplayedList();
//                 },
//                 child: Text(
//                   '${pageIndex + 1}',
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: _currentPageNumber == pageIndex
//                             ? ColorSchemes.primary
//                             : ColorSchemes.gray,
//                       ),
//                 ),
//               ),
//             );
//           }),
//         ),
//         Visibility(
//           visible: _currentPageNumber != _totalPages - 1 &&
//               _totalPages > widget.itemsPerPage,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 3),
//             child: Text(
//               "...",
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: ColorSchemes.gray),
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             if (_currentPageNumber < _totalPages - 1) {
//               _currentPageNumber++;
//               _updateDisplayedList();
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(
//                 color: ColorSchemes.white,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 1),
//                     spreadRadius: 1,
//                     blurRadius: 8,
//                     color: Color.fromRGBO(0, 0, 0, 0.12),
//                   ),
//                 ],
//                 shape: BoxShape.circle,
//               ),
//               child: SvgPicture.asset(
//                 ImagePaths.imagesIcArrowRight,
//                 width: 16,
//                 height: 16,
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   (_currentPageNumber == _totalPages - 1)
//                       ? ColorSchemes.gray
//                       : ColorSchemes.primary,
//                   BlendMode.srcIn,
//                 ),
//                 matchTextDirection: true,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//   void _updateDisplayedList() {
//     if (widget.projectsList.length <= widget.itemsPerPage) {
//       _displayedList = widget.projectsList;
//     } else {
//       int startPage = _currentPageNumber * widget.itemsPerPage;
//       int endPage = startPage + widget.itemsPerPage;
//       if (endPage > widget.projectsList.length) {
//         endPage = widget.projectsList.length;
//         startPage = endPage - widget.itemsPerPage;
//       }
//       setState(() {
//         _displayedList =
//             widget.projectsList.sublist(startPage, endPage);
//         widget.onPageChange(_displayedList);
//       });
//     }
//   }
// }
