import 'package:flutter/material.dart';
import 'package:flutter_database_sqlite/layout/item_list.dart';
import 'package:flutter_database_sqlite/layout/entry_form.dart';
import 'package:flutter_database_sqlite/database/dB_Helper.dart';
import 'package:flutter_database_sqlite/model/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => EntryForm(
                  Item('', '', 0, 0),
                  true,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('SISCA DWI RAHAYU || 2031710003'),
        ),
        body: FutureBuilder(
          future: db.getItem(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }

            var data = snapshot.data;

            return snapshot.hasData
                ? ItemList(data as List<Item>)
                : const Center(
                    child: Text('Tidak Ada Data'),
                  );
          },
        ));
  }
}
