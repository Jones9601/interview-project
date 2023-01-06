import 'package:flutter/material.dart';
import 'package:interviewproject/model/first-task.model.dart';
import 'package:interviewproject/screen/second.screen.dart';

import '../utils/http-utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<firsttask> maleList = [];
  List<firsttask> feMaleList = [];

  void clickApi() async {
    firsttask value = await fetchProducts();
    if (value.results?.first.gender == 'male') {
      setState(() => maleList.add(value));
    } else {
      setState(() => feMaleList.add(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API'),
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              itemCount: maleList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                data: maleList[i],
                              )),
                    );
                    setState(() => maleList.remove(result));
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            maleList[i].results?.first.name?.first.toString() ??
                                ''),
                        Text(maleList[i].results?.first.name?.last.toString() ??
                            ''),
                        Text(
                            '${maleList[i].results?.first.location?.street?.name ?? ''} ${maleList[i].results?.first.location?.city ?? ''} ${maleList[i].results?.first.location?.state ?? ''}'),
                        Text(
                            '${maleList[i].results?.first.location?.coordinates?.latitude ?? ''} ${maleList[i].results?.first.location?.coordinates?.longitude ?? ''}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ListView.builder(
              itemCount: feMaleList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                data: feMaleList[i],
                              )),
                    ).then((value) => setState(() => feMaleList.remove(value)));
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feMaleList[i]
                                .results
                                ?.first
                                .name
                                ?.first
                                .toString() ??
                            ''),
                        Text(feMaleList[i]
                                .results
                                ?.first
                                .name
                                ?.last
                                .toString() ??
                            ''),
                        Text(
                            '${feMaleList[i].results?.first.location?.street?.name ?? ''} ${feMaleList[i].results?.first.location?.city ?? ''} ${feMaleList[i].results?.first.location?.state ?? ''}'),
                        Text(
                            '${feMaleList[i].results?.first.location?.coordinates?.latitude ?? ''} ${feMaleList[i].results?.first.location?.coordinates?.longitude ?? ''}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clickApi,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
