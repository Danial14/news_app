import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/route_util.dart';
import 'package:news_app/views/responsive/web_views/extra_large_category_web.dart';
import 'package:news_app/views/responsive/web_views/home.dart';

import '../../../constants/constants.dart';
import 'android_ios_medium_mobile_tablet_web_view_home.dart';

class ExtraLargeWebDetailView extends StatelessWidget {
  late String _headlinesTitle;
  late String _newsDescription;
  late String _newsChannelName;
  late String _date;
  late String? _image;
  late String? _fromWhere;
  ExtraLargeWebDetailView(String headlinesTitle, String newsDescription, String newsChannelName, String date, String? image, String? fromWhere){
    this._headlinesTitle = headlinesTitle;
    this._newsDescription = newsDescription;
    this._newsChannelName = newsChannelName;
    this._date = date;
    this._image = image;
    this._fromWhere = fromWhere;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("details");
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if(constraints.maxWidth < 600){
          return WillPopScope(
            onWillPop: () async{
              print("back pressed");
              Future.delayed(Duration(seconds: 0), (){
                /*switch(_fromWhere){
                  case Constants.ROUTE_CATEGORY:
                    Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebCategory()));
                    break;
                  case Constants.ROUTE_HOME:
                    Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebHomeView()));
                    break;
                }*/
                //Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(AndroidIosMediumMobileTabletWebViewHome()));
              });
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                flexibleSpace: Container(
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
              ),
              body: SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _image != null ? CachedNetworkImageProvider(_image!) :
                          AssetImage("assets/images/404.png") as ImageProvider,
                          fit: BoxFit.cover
                      )
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      width: size.width * 0.8,
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 5, blurRadius: 7)
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: SingleChildScrollView(
                            child: Text(_headlinesTitle,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: constraints.maxWidth * 0.04,
                              ),
                            ),
                          ),
                            flex: 1,
                          ),
                          SizedBox(height: 3,),
                          Expanded(child: SingleChildScrollView(
                            child: Text(_newsDescription,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: constraints.maxWidth * 0.02),
                            ),
                          ),
                            flex: 2,
                          ),
                          Expanded(child: ListTile(
                            leading: Text(_newsChannelName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                              ),
                            ),
                            trailing: Text(_date,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
          return WillPopScope(
            onWillPop: () async{
              print("back pressed");
              Future.delayed(Duration(seconds: 0), (){
                /*switch(_fromWhere){
                  case Constants.ROUTE_CATEGORY:
                    Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebCategory()));
                    break;
                  case Constants.ROUTE_HOME:
                    Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebHomeView()));
                    break;
                }*/
                Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(AndroidIosMediumMobileTabletWebViewHome()));
              });
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                flexibleSpace: Container(
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
              ),
              body: SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _image != null ? CachedNetworkImageProvider(_image!) :
                          AssetImage("assets/images/404.png") as ImageProvider,
                          fit: BoxFit.cover
                      )
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      width: size.width * 0.8,
                      height: size.height * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 5, blurRadius: 7)
                          ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(child: SingleChildScrollView(
                            child: Text(_headlinesTitle,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: constraints.maxWidth * 0.04,
                                ),
                            ),
                          ),
                            flex: 2,
                          ),
                          SizedBox(height: 3,),
                          Expanded(child: SingleChildScrollView(
                            child: Text(_newsDescription,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: constraints.maxWidth * 0.02),
                            ),
                          ),
                            flex: 2,
                          ),
                          Expanded(child: ListTile(
                            leading: Text(_newsChannelName,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                              ),
                            ),
                            trailing: Text(_date,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async{
            print("back pressed");
            Future.delayed(Duration(seconds: 0), (){
              switch(_fromWhere){
                case Constants.ROUTE_CATEGORY:
                  Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebCategory()));
                  break;
                case Constants.ROUTE_HOME:
                  Navigator.of(context).pushReplacement(RouteUtil.createBackRoute(ExtraLargeWebHomeView()));
                  break;
              }

            });
           return true;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
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
            ),
            body: SafeArea(
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image != null ? CachedNetworkImageProvider(_image!) :
                      AssetImage("assets/images/404.png") as ImageProvider,
                    fit: BoxFit.cover
                  )
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                      width: size.width * 0.8,
                      height: size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.grey.withOpacity(0.4), spreadRadius: 5, blurRadius: 7)
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: Text(_headlinesTitle,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 28),
                        ),
                          flex: 1,
                        ),
                       // SizedBox(height: 1,),
                        Expanded(child: Text(_newsDescription,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                          flex: 2,
                        ),
                        Expanded(child: ListTile(
                          leading: Text(_newsChannelName,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 20
                          ),
                          ),
                          trailing: Text(_date,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20
                              )
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                          flex: 1,
                        ),
                      ],
                    ),
                    ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
