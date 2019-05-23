import 'package:flutter/material.dart';
import 'package:flutterapitut/Controllers/databasehelper.dart';
import 'package:flutterapitut/view/dashboard.dart';
import 'package:flutterapitut/view/register.dart';


class AddData extends StatefulWidget{

  AddData({Key key , this.title}) : super(key : key);
  final String title;



  @override
  AddDataState  createState() => AddDataState();
}

class AddDataState extends State<AddData> {
  DatabaseHelper databaseHelper = new DatabaseHelper();



  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Add Product',
      home: Scaffold(
        appBar: AppBar(
          title:  Text('Add Product'),
        ),
        body: Container(
          child: ListView(
            padding: const EdgeInsets.only(top: 62,left: 12.0,right: 12.0,bottom: 12.0),
            children: <Widget>[
              Container(
                height: 50,
                child: new TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Product Name',
                    icon: new Icon(Icons.email),
                  ),
                ),
              ),

              Container(
                height: 50,
                child: new TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Place your price',
                    icon: new Icon(Icons.vpn_key),
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 44.0),),

              Container(
                height: 50,
                child: new RaisedButton(
                  onPressed: (){
                    databaseHelper.addData(
                        _nameController.text.trim(), _priceController.text.trim());
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard(),
                        )
                    );
                  },
                  color: Colors.blue,
                  child: new Text(
                    'Add',
                    style: new TextStyle(
                        color: Colors.white,
                        backgroundColor: Colors.blue),),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }



}















