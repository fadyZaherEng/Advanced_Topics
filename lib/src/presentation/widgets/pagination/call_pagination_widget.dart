class CallPaginationWidget extends StatefulWidget {
  const CallPaginationWidget({super.key});

  @override
  State<CallPaginationWidget> createState() => _CallPaginationWidgetState();
}

class _CallPaginationWidgetState extends State<CallPaginationWidget> {
  final int _itemsPerPage = 3;
  List<Project> _projectsList = [];
  List<Project> _displayedList = [];

  @override
  void initState() {
    super.initState();
    _projectsList = widget.projectsList;
    if(_projectsList.length <= 3){
      _displayedList = _projectsList;
    } else {
      _displayedList = _projectsList.sublist(0, _itemsPerPage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination Example'),
      ),
      body: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _displayedList
                .asMap()
                .entries
                .map((entry) {
              int index = entry.key;
              Project project = entry.value;
              return InkWell(
                onTap: () {
                  widget.onProjectTab(project);
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index % 2 == 1) ...[
                          SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1),
                        ],
                        Text(project.name),
                        if (index % 2 == 0) ...[
                          SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.1),
                        ],
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 48),
          if (_projectsList.isNotEmpty) ...[
            PaginationWidget(
              onPageChange: (List<Project> displayList) {
                _displayedList = displayList;
                setState(() {});
              },
              itemsPerPage: _itemsPerPage,
              projectsList: _projectsList,
            )
          ]
        ],
      ),
    )
  }
 void getProjectsList() {
    for (int i = 0; i < 100; i++) {
      _projectsList.add(Project(
          id: i,
          name: 'Project $i',
          description: 'Description $i',
          image: 'https://picsum.photos/id/$i/200/300'));
    }
    setState(() {});
  }
}
