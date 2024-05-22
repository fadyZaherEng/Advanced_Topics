import 'package:flutter/material.dart';
import 'package:flutter_advanced_topics/src/core/base/widget/base_stateful_widget.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/custom_drop_down_search/bloc/search_bottom_sheet_bloc.dart';
import 'package:flutter_advanced_topics/src/presentation/widgets/extra_fields/search_text_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBottomSheetWidget extends BaseStatefulWidget {
  final List<String> choices;
  final void Function() onClosed;
  final void Function(String value) onSearch;
  final void Function(String value) onTap;

  const SearchBottomSheetWidget({
    super.key,
    required this.choices,
    required this.onClosed,
    required this.onSearch,
    required this.onTap,
  });

  @override
  BaseState<SearchBottomSheetWidget> baseCreateState() =>
      _SearchBottomSheetWidgetState();
}

class _SearchBottomSheetWidgetState extends BaseState<SearchBottomSheetWidget> {
  final TextEditingController _controller = TextEditingController();
  List<String> _filteredChoices = [];

  SearchBottomSheetBloc get _bloc =>
      BlocProvider.of<SearchBottomSheetBloc>(context);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _bloc.add(SearchBottomSheetEvents(_controller.text, widget.choices));
    });
    _filteredChoices.addAll(widget.choices);
  }

  @override
  Widget baseBuild(BuildContext context) {
    return BlocConsumer<SearchBottomSheetBloc, SearchBottomSheetState>(
      listener: (context, state) {
        if (state is SearchBottomSheetSuccessState) {
          _filteredChoices = state.choices;
          hideLoading();
        } else if (state is SearchBottomSheetLoading) {
          showLoading();
        }
      },
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SearchTextFieldWidget(
                controller: _controller,
                onChange: (value) {
                  widget.onSearch(value);
                  _bloc.add(SearchBottomSheetEvents(value, widget.choices));
                },
                searchText: "Search",
                onClear: () {
                  _controller.clear();
                  _bloc.add(SearchBottomSheetEvents("", widget.choices));
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredChoices.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.onTap(_filteredChoices[index]);
                        widget.onClosed();
                      },
                      child: Text(
                        _filteredChoices[index],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
