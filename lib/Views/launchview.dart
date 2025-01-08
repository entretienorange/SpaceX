import 'package:flutter/material.dart';
import 'package:spacex/ViewModels/launchViewmodels.dart';
import 'package:spacex/views/launchDetailsView.dart';
import 'package:provider/provider.dart';
import 'package:spacex/Widget/SideMenu.dart';

class LaunchView extends StatelessWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LaunchViewModel>(
      create: (_) => LaunchViewModel()..fetchLaunches(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List of Launch', textAlign: TextAlign.center),
          centerTitle: true, 
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () async {
                showSearch(
                  context: context,
                  delegate: LaunchSearchDelegate(),
                );
              },
            ),
          ],
        ),
        drawer: SideMenu(),
        body: Consumer<LaunchViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (viewModel.launches.isEmpty) {
              return const Center(child: Text('No launches available'));
            } else {
              return LayoutBuilder(
                builder: (context, constraints) {
                  double cardWidth = constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9;
                  double fontSize = constraints.maxWidth > 600 ? 22 : 16;

                  return ListView.builder(
                    itemCount: viewModel.launches.length,
                    itemBuilder: (context, index) {
                      final launch = viewModel.launches[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LaunchDetailsView(
                                  launchId: launch.id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: cardWidth, 
                                    child: Text(
                                      launch.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: cardWidth,
                                    child: Text(
                                      launch.date,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: fontSize - 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class LaunchSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search by name';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; 
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); 
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final viewModel = Provider.of<LaunchViewModel>(context, listen: false);

    final filteredLaunches = viewModel.launches
        .where((launch) => launch.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredLaunches.length,
      itemBuilder: (context, index) {
        final launch = filteredLaunches[index];
        return ListTile(
          title: Text(
            launch.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            launch.date,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LaunchDetailsView(
                  launchId: launch.id,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final viewModel = Provider.of<LaunchViewModel>(context, listen: false);

    final filteredLaunches = viewModel.launches
        .where((launch) => launch.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredLaunches.length,
      itemBuilder: (context, index) {
        final launch = filteredLaunches[index];
        return ListTile(
          title: Text(
            launch.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            launch.date,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LaunchDetailsView(
                  launchId: launch.id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
