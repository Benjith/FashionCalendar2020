import 'package:calender2020/appdata.dart';
import 'package:calender2020/services.dart';
import 'package:calender2020/widgets.dart/calender_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    // fetch all notes dates
    fetchAllNotesDates();
  }
  Future<void> fetchAllNotesDates() async {
    await Services().fetchallNotesDate();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resmi R Nair Fashion Calender 2020',
      theme: ThemeData(
          // primarySwatch: Colors.lightBlue,
          brightness: Brightness.dark),
      home: MyHomePage(title: 'Fashion Calender 2020'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key) {
    this._initialIndex = 0;
    if (DateTime.now().year == 2020) {
      this._initialIndex = DateTime.now().month - 1;
    }
  }

  final String title;
  int _initialIndex;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double _calenderOpacity = 0.50;
  double _bgOpacity = 0.50;
  int tabIndex = 0;

  Widget _monthsView() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        CalenderView(AppData.jan),
        CalenderView(AppData.feb),
        CalenderView(AppData.mar),
        CalenderView(AppData.apr),
        CalenderView(AppData.may),
        CalenderView(AppData.jun),
        CalenderView(AppData.jul),
        CalenderView(AppData.aug),
        CalenderView(AppData.sep),
        CalenderView(AppData.oct),
        CalenderView(AppData.nov),
        CalenderView(AppData.dec),
      ],
    );
  }

  TextStyle _nameTextStyle =
      TextStyle(fontSize: 36, fontWeight: FontWeight.w300, letterSpacing: 5.0);

  Widget _sizedBox({double height, double width}) => SizedBox(
        height: height,
        width: width,
      );
  Widget _drawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text('Sunny Leone'),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // IconButton(onPressed: (){},icon: Icon(Icons.ac_unit,),),
                      InkWell(
                        onTap: () async {
                          var url = AppData.fbURL;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.facebookSquare,
                          size: 12,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () async {
                          var url = AppData.insta;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.instagram,
                          size: 12,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () async {
                          var url = AppData.webURL;
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Icon(
                          Icons.web,
                          size: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
          ),
          ListTile(
            title: Text('About'),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          // ListTile(
          //   title: Text('Contact'),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          Center(
            child: Text(
              'Benjith Kizhisseri',
              style: TextStyle(color: Colors.white30),
            ),
          )
        ],
      ),
    );
  }

  Widget _bGContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bgimg/$tabIndex.jpg'),
              fit: BoxFit.cover)),
      // child: Text('data'),
    );
  }

  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 12);

    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        drawer: _drawer(context),
        body: Stack(
          children: <Widget>[
            //image
            // _bGContainer(),
            AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _bgOpacity,
              child: _bGContainer(),
            ),
            // calender
            AnimatedOpacity(
              duration: Duration(seconds: 2),
              opacity: _calenderOpacity,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    _sizedBox(height: deviceH * 2 / 100, width: 0.0),
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.white30,
                      isScrollable: true,
                      tabs: <Widget>[
                        for (var item in AppData.monthsName)
                          Text(
                            item,
                            style: _nameTextStyle,
                          )
                      ],
                    ),
                    _sizedBox(height: deviceH * 5 / 100, width: 0.0),
                    Expanded(
                      child: _monthsView(),
                    ),
                    Center(
                      child: Container(
                        width: deviceW * 50 / 100,
                        child: Slider(
                          activeColor: Colors.blue[100],
                          onChanged: (val) {
                            setState(() {
                              _calenderOpacity = val;
                              _bgOpacity = 1.0 - _calenderOpacity;
                            });
                          },
                          value: _calenderOpacity,
                          min: 0.0,
                          max: 1.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About ${AppData.username}'),
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'AboutKarenjit Kaur Vohra, known by her stage name Sunny Leone, is an actress and model, currently active in the Indian film industry.She has American and Canadian citizenship. She has also used the stage name Karen Malhotra',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                  fontSize: 32),
            )),
      ),
    );
  }
}
