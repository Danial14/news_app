import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/web_views/web_app_drawer.dart';
import 'package:provider/provider.dart';

import '../../../view_model/news_view_model.dart';
import 'android_ios_large_tablet_web_view_home.dart';
import 'android_ios_medium_mobile_tablet_web_view_home.dart';
import 'extra_large_devices_web_view_home.dart';
import 'large_devices_web_view_home.dart';

class AndroidIosSmallMobileWebViewHome extends StatefulWidget {
  const AndroidIosSmallMobileWebViewHome({Key? key}) : super(key: key);

  @override
  State<AndroidIosSmallMobileWebViewHome> createState() => _AndroidIosSmallMobileWebViewHomeState();
}

class _AndroidIosSmallMobileWebViewHomeState extends State<AndroidIosSmallMobileWebViewHome> {
  NewsViewModel? _newsViewModel;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if(constraints.maxWidth > 1200){
          return ExtraLargeDevicesWebViewHome();
        }
        else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
          return AndroidIosLargeTabletWebViewHome();
        }
        else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
          return AndroidIosMediumMobileTabletWebViewHome();
        }
        else if(constraints.minWidth >= 992 && constraints.minWidth < 1200){
          return LargeDevicesWebViewHome();
        }
        return Scaffold(
            key: _key,
            drawer: WebAppDrawer(_newsViewModel!),
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffD9D9D9).withOpacity(1.0),
                        Color(0xffD9D9D9).withOpacity(0.23)
                      ]
                  ),
                ),
              ),
              title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
              leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: InkWell(
                  onTap: (){
                    _key.currentState!.openDrawer();
                  },
                  child: Image.asset("assets/images/Menu.png"),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: InkWell(
                    onTap: (){
                      //Navigator.of(context).pushReplacement(RouteUtil.createRoute(ExtraLargeWebCategory()));
                    },
                    child: Image.asset("assets/images/category_icon.png", width: 40,height: 40,),
                  ),
                )
              ],
            ),
          body: Container(
          width: size.width,
          height: size.height,
          child: FutureBuilder<bool>(
            future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
            builder: (ctx, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                return SpinKitCircle(
                  size: 40,
                  color: Colors.blue,
                );
              }
              else{
                return Consumer<NewsViewModel>(
                    builder: (context, news, ch) {
                      var data = news.getHeadlines;
                      print("news length: ${data.articles!.length}");
                      List verticalList = data.articles!.sublist((data.articles!.length / 2).toInt());
                      return Column(
                        children: <Widget>[Expanded(
                          flex: 2,
                          child: RawScrollbar(
                            thumbColor: Colors.purple,
                            controller: _scrollController,
                            child: ListView.builder(controller: _scrollController,
                              itemBuilder: (ctx, position){
                              return InkWell(
                                onTap: (){
                                  /*Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                    return NewsDetails(data.articles![position]);
                                  }));*/
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: size.width * 0.6,
                                        height: size.height * 0.4,
                                        padding: EdgeInsets.symmetric(horizontal: size.height * .02),
                                        child: data.articles![position].urlToImage != null ? ClipRRect(
                                          child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                            fit: BoxFit.fill,
                                            placeholder: (ctx, st){
                                              return SpinKitCircle(color: Colors.blue,);
                                            },
                                            errorWidget: (ctx, str, obj){
                                              return Icon(Icons.error, color: Colors.red,);
                                            },
                                          ),
                                          borderRadius: BorderRadius.circular(15),
                                        ) : Center(child: Text("404 Image not found", style: GoogleFonts.italiana(fontSize: 24, fontWeight: FontWeight.w600),)),
                                      ),
                                      Positioned(bottom: 2,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Container(
                                            width: size.width * 0.5,
                                            height: size.height * 0.20,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(child: Padding(child: SingleChildScrollView(
                                                  child: Text(data.articles![position].title!,
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                  padding: EdgeInsets.only(left: 16, top: 5),
                                                ),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: ListTile(
                                                      leading: Text(data.articles![position].source!.name,style: TextStyle(color: Colors.blue),),
                                                      trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.now())),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                              scrollDirection: Axis.horizontal,
                              itemCount: (data.articles!.length / 2).toInt(),
                            ),
                          ),
                        ),
                          SizedBox(height: 5,),
                          Expanded(flex: 2,
                            child: ListView.builder(itemBuilder: (ctx, position){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: InkWell(
                                      onTap: (){
                                        /*Navigator.of(context).push(MaterialPageRoute(
                                            builder: (ctx){
                                              return NewsDetails(data.articles![position]);
                                            }
                                        ));*/
                                      },
                                      child: Container(
                                        height: size.height * 0.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: verticalList[position].urlToImage != null ? CachedNetworkImage(imageUrl: verticalList[position].urlToImage,
                                            fit: BoxFit.fill,
                                            placeholder: (ctx, st){
                                              return SpinKitCircle(color: Colors.blue,);
                                            },
                                            errorWidget: (ctx, st, ob){
                                              return Icon(Icons.error, color: Colors.red,);
                                            },
                                          ) :
                                          Center(
                                            child: Text(
                                              "Image not found 404",
                                              style: GoogleFonts.italiana(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                      flex: 3,
                                    ),
                                    SizedBox(width: 5,),
                                    Expanded(child: Container(
                                      height: size.height * 0.3,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 8,
                                            child: Text(verticalList[position].title!,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(child: FittedBox(
                                                  child: Text(data.articles![position].source!.name,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                  fit: BoxFit.contain,
                                                  alignment: Alignment.centerLeft,
                                                ),
                                                  //flex: 2,
                                                ),
                                                //SizedBox(width: 5,),
                                                Expanded(child: Container(alignment: Alignment.centerRight,child: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(verticalList[position].publishedAt!)))))
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    ),
                                      flex: 4,
                                    )
                                  ],
                                ),
                              );
                            },
                              itemCount: verticalList.length,
                            ),
                          )
                        ],
                      );
                    }
                );
              }
            },
          ),
        ),
        );
      }
    );
  }
}
