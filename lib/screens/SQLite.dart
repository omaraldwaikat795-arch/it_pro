import 'package:flutter/material.dart';
import 'package:it_pro/core/units/db_helper.dart';

//import 'package:instagram_ui/core/units/db_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlliteScreen extends StatefulWidget {
  const SqlliteScreen({super.key});

  @override
  State<SqlliteScreen> createState() => _SqlliteScreenState();
}

class _SqlliteScreenState extends State<SqlliteScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    // 1000: implement iniState
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final rows = await DbHelper.dbHelper.getAllItems();
      print(rows);
      setState(() {
        _items = rows;
        isLoading = false;
      });
      print("items fetch");
      print(_items);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("sqlflite"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final data = {'name': "item ${_items.length + 1}", 'price': 100.0};
          try {
            await DbHelper.dbHelper.insertItem(data);
            load();
          } catch (e) {
            print(e);
          }
        },
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : _items.isEmpty
          ? Center(child: Text("No data "))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            item["item name : ${item['name']}"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            item["item price : ${item['price']}"],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
