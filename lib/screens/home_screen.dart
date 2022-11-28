import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cat_application/screens/taken_picture_screen.dart';
import 'package:cat_application/widgets/custom_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:cat_application/helpers/database_helper.dart';
import 'package:cat_application/models/cat_model.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription firstCamera;
  final String ImagePhath;

  const HomeScreen({Key? key,required this.ImagePhath, required this.firstCamera}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textControllerDescription = TextEditingController();
  final textControllerType = TextEditingController();
  final textControllerSize = TextEditingController();
  int? planetID; 
  final textControllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register a new planet"),
        backgroundColor: Color.fromARGB(255, 47, 0, 255),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: textControllerName,
              decoration: InputDecoration(
                icon: Icon(Icons.public),
                labelText:"Name of the planet."),
            ),

            TextFormField(
              controller: textControllerDescription,
              decoration: InputDecoration(
                icon: Icon(Icons.description),
                labelText:"Description."),
            ),

            TextFormField(
              controller: textControllerType,
              decoration: InputDecoration(
                icon: Icon(Icons.card_giftcard),
                labelText:"Type of planet."),
            ),

            TextFormField(
              controller: textControllerSize,
              decoration: InputDecoration(
                icon: Icon(Icons.text_format_outlined),
                labelText:"Size."),
            ),
            
            Center(
              child: (FutureBuilder<List<Planet>>(
                future: DatabaseHelper.instance.getPlanets(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Planet>> snapshot
                  ){
                    if(!snapshot.hasData){
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("Loading"),
                        ),);
                    }
                    else{
                          return snapshot.data!.isEmpty ?
                          Center(
                            child: Container(
                              child: const Text("No planets")
                              ),
                          )

                      :ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: snapshot.data!.map((planet) {
                          return Center(
                            child:ListTile(
                              title: Row(children: [Container(child: Image.file(File(planet.Image)), height: 50, width: 50,), Container(child: Text('Name:${planet.Name},| Description:${planet.Description},| Type:${planet.Type},| Size:${planet.Size}'),width: 150,)],),
                              onTap: (){
                                setState(() {
                                  final route = MaterialPageRoute(builder: (context) => TakenPictureScreen(camera: widget.firstCamera,));
                                  Navigator.push(context, route);
                                  textControllerDescription.text = planet.Description;
                                  textControllerType.text = planet.Type;
                                  textControllerSize.text = planet.Size;
                                  planetID = planet.id;
                                  textControllerName.text = planet.Name;
                                });
                              },
                              onLongPress: (){
                                
                                setState(() {
                                  DatabaseHelper.instance.delete(planet.id!);
                                });
                              },
                            )
                          );
                        }).toList()
                      );
                  }
                }
              )
            ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (planetID != null){
            DatabaseHelper.instance.update(
              Planet(id: planetID, Description: textControllerDescription.text, Type: textControllerType.text, Size: textControllerSize.text, Image: widget.ImagePhath, Name: textControllerName.text,)
            );
          }
          else{
            DatabaseHelper.instance.add(Planet(
            Description: textControllerDescription.text,
            Type: textControllerType.text,
            Size: textControllerSize.text,
            Image: widget.ImagePhath,
            Name: textControllerName.text,
          ));
          }
          
          setState(() {
            textControllerDescription.clear();
            textControllerType.clear();
            textControllerSize.clear();
          });
        },
      ),
    );
  }
}