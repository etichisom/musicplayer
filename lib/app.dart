
import 'dart:async';

import 'package:flutt/TabNavigatorRoutes.dart';
import 'package:flutt/component/nowplaying.dart';
import 'package:flutt/model/songm.dart';
import 'package:flutt/screen/songdetails.dart';
import 'package:flutt/services/change.dart';
import 'package:flutt/services/getsong.dart';
import 'package:flutt/services/playsong.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_plugin_playlist/flutter_plugin_playlist.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:provider/provider.dart';
import 'package:slate/slate.dart';



BuildContext cuu;
var status;
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3","Page4"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
    "Page4": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

   Change p;
  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }
  final Controller c = Get.put(Controller());
  List<ArtistInfo> al =[];
  Box<Songm> h = Hive.box('his');
  @override
  Widget build(BuildContext context) {
    cuu = context;
    p = Provider.of<Change>(context);
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
            children:<Widget>[
              _buildOffstageNavigator("Page1"),
              _buildOffstageNavigator("Page2"),
              _buildOffstageNavigator("Page3"),
              _buildOffstageNavigator("Page4"),
              Positioned(
                bottom: 0,
                child: StreamBuilder(
                    stream: state.stream,
                    builder:(context,dat){
                      if(dat.data == 'stopped'){
                        return SizedBox();
                      }else if(dat.data == 'playing'){
                        return Slate(
                          child: Container(
                            color: Colors.grey[400],
                            width: MediaQuery.of(context).size.width,
                            child: nowplaying(context),
                          ),
                        );
                      }else if(dat.data == 'paused'){
                        return Slate(
                          child: Container(
                            color: Colors.grey[400],
                            width: MediaQuery.of(context).size.width,
                            child: nowplaying(context),
                          ),
                        );
                      }
                      else{
                        return SizedBox();
                      }
                    }
                ),
              ),

             // Positioned(),
            ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home_outlined),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.music_note),
              title: new Text('Music'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.playlist_play),
              title: new Text('Playlist'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              title: new Text('Search'),
            ),

          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );

  }



  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(h.values.length > 100){
      h.clear();
    }
    //status
      player.on('status', (eventname, {args}) {
        if ((args as OnStatusCallbackData).value != null) {
          int curren =
          (args as OnStatusCallbackData).value['currentIndex'].toInt();
          cindex.sink.add(curren);
         var status =
          (args as OnStatusCallbackData).value['status'].toString();
          var mss =
          (args as OnStatusCallbackData).type;

          state.sink.add(status);
          if(mss == 11){
            h.add(current[curren]);
            setState(() {});
          }
          int currentpostion =
              (args as OnStatusCallbackData).value['currentPosition'].toInt();
          cdua.sink.add(currentpostion);
         // p.setp(currentpostion);
          int total = (((args as OnStatusCallbackData).value['duration']) ?? 0)
              .toInt();
          cp.sink.add(total);

        }

      });



  }
  gr()async{
   al = await  audioQuery.getArtists(sortType: ArtistSortType.CURRENT_IDs_ORDER);
    print(al[0].name);
  }
}

