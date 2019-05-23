import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/adddata.dart';
import 'package:flutterapitut/view/login.dart';
import 'package:flutterapitut/view/showdata.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Dashboard extends StatefulWidget{

  Dashboard({Key key , this.title}) : super(key : key);
  final String title;

  @override
  DashboardState  createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  DatabaseHelper databaseHelper = new DatabaseHelper();



  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Dashboard'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: (){
                _save('0');
                Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage(),
                    )
                );
              },
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new AddData(),
              )
          ),
        ),
        body: new FutureBuilder<List>(
          future: databaseHelper.getData(),
          builder: (context ,snapshot){
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(list: snapshot.data)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )
      ),
    );
  }


}

class ItemList extends StatelessWidget {

  List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: list==null?0:list.length,
        itemBuilder: (context,i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ShowData(list:list , index:i,) ),

            ) ,
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['name']),
                leading: new Icon(Icons.apps),
                subtitle: new Text('Price : ${list[i]['price']}'),
              ),
            )
            ,
          ),
        );

        }
    );
  }

}















