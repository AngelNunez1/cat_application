import 'package:camera/camera.dart';
import 'package:cat_application/helpers/database_helper.dart';
import 'package:cat_application/screens/contact.dart';
import 'package:cat_application/screens/details_page.dart';
import 'package:cat_application/screens/taken_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:cat_application/widgets/image_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

import '../models/cat_model.dart';

class HomePageWidget extends StatefulWidget {
  final CameraDescription firstCamera;
  
  const HomePageWidget({Key? key, required this.firstCamera}) : super(key: key);
  
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Planets',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          'Solar system',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(135, 0, 0, 0),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 30, 5),
                    child: FlutterFlowIconButton(
                      borderColor: Color.fromARGB(65, 0, 0, 0),
                      borderRadius: 30,
                      borderWidth: 2,
                      buttonSize: 60,
                      fillColor: Color(0x003F2D1C),
                      icon: Icon(
                        Icons.search,
                        color: Color.fromARGB(135, 0, 0, 0),
                        size: 30,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ],
              ),


              Expanded(
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
                                child: const Text("No Planets")
                                ),
                            )

                        :ListView(
                          
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          
                          children: snapshot.data!.map((planet) {
                            return Center(
                              child:GestureDetector(
                                
                                child: Container(                              
                                  child: Image_s(path: planet.Image), height: 325, width: 200, 
                                  
                                  
                                ),
                                onTap: (){
                                  setState(() {
                                    final route = MaterialPageRoute(builder: (context) => DetailsScreenWidget(
                                      firstCamera: widget.firstCamera,
                                      Description: planet.Description,
                                      Image: planet.Image,
                                      Name: planet.Name,
                                      Size: planet.Size,
                                      Type: planet.Type,
                                      ));
                                    Navigator.push(context, route);
            
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
              ),


              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 30, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: '',
                      icon: Icon(
                        Icons.public,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: 50,
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 180, 0),
                      child: FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                          );
                        },
                        text: '',
                        icon: FaIcon(
                          FontAwesomeIcons.list,
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        options: FFButtonOptions(
                          height: 50,
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () {
                      print('button_n_planet pressed ...');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                        builder: (context) => TakenPictureScreen(camera: widget.firstCamera,)
                    ),
                  );
                        },
                      
                      text: '',
                      icon: Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: 50,
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //new
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Mercury.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Mercury',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/venus.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Venus',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Earth.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Earth',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Mars.png',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Mars',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Jupiter.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Jupiter',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Saturn.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Saturn',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/Uranus.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Uranus',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/neptune.jpg',
                              width: 125,
                              height: 125,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Neptune',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
