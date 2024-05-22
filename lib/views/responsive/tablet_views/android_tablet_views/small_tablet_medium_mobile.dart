import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/tablet_views/android_tablet_views/small_tablet_medium_mobile_category.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/route_util.dart';
import '../../../../view_model/news_view_model.dart';
import '../../web_views/extra_large_detail_web.dart';

class SmallTabletAndMediumMobileHome extends StatefulWidget {
  const SmallTabletAndMediumMobileHome({super.key});

  @override
  State<SmallTabletAndMediumMobileHome> createState() => _SmallTabletAndMediumMobileHomeState();
}

class _SmallTabletAndMediumMobileHomeState extends State<SmallTabletAndMediumMobileHome> {
  NewsViewModel? _newsViewModel;
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
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return SmallTabletMediumMobileCategory();
            }));
          },
          icon: Image.asset(Constants.IMAGE_PATH + "category_icon.png",
            width: 25,
            height: 25,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (ctx){
            return <PopupMenuItem>[
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchBbcHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("BBC", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchAlJazeeraHeadlinesNews();
                },
                child: Container(width: size.width,height: 35,child: Text("Al Jazeera", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchCnnHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("CNN", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchIndependentHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("Independent", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchReutersHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("Reuters", style: TextStyle(color: Colors.black),)),
              ))
            ];
          })
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.landscape){

            return SafeArea(
                  child: FutureBuilder<bool>(
                      future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
                      builder: (ctx, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                          return SpinKitCircle(
                            color: Colors.blue,
                            size: 40,
                          );
                        }
                        else{
                          return Consumer<NewsViewModel>(
                            builder: (ctx, news, ch){
                              var data = news.getHeadlines;
                              print("news length: ${data.articles!.length}");
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.1
                                  ),
                                  itemBuilder: (ctx, position){
                                    return InkWell(
                                      onTap: (){
                                        /*Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                            data.articles![position].description!,
                                            data.articles![position].source!.name,
                                            DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                            data.articles![position].urlToImage,
                                            Constants.ROUTE_HOME
                                        )));*/
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  child: data.articles![position].urlToImage != null ? ClipRRect(
                                                    child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                                      fit: BoxFit.cover,
                                                      placeholder: (ctx, st){
                                                        return SpinKitCircle(color: Colors.blue,);
                                                      },
                                                      errorWidget: (ctx, str, obj){
                                                        return Image.asset("assets/images/404.png", fit: BoxFit.cover,);
                                                      },
                                                    ),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ) : ClipRRect(child: Image.asset("assets/images/404.png", fit: BoxFit.cover,),
                                                    borderRadius: BorderRadius.circular(15),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 3,),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(padding: EdgeInsets.only(left: 3),child: Wrap(
                                                  children: [Text(data.articles![position].title!,
                                                    style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14
                                                    ),
                                                  )],
                                                )),
                                              ),
                                              SizedBox(height: 12,),
                                              ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
                                                child: Text(data.articles![position].source!.name,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                                fit: BoxFit.contain,
                                                alignment: Alignment.centerLeft,
                                              ),
                                                trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w700
                                                    )
                                                ),
                                              )
                                            ]
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: data.articles!.length,
                                ),
                              );
                            },
                          );
                        }
                      }
                  ),
                );
          }
          else{
            return SafeArea(
              child: FutureBuilder<bool>(
                  future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
                  builder: (ctx, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                      return SpinKitCircle(
                        color: Colors.blue,
                        size: 40,
                      );
                    }
                    else{
                      return Consumer<NewsViewModel>(
                        builder: (ctx, news, ch){
                          var data = news.getHeadlines;
                          print("news length: ${data.articles!.length}");
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemBuilder: (ctx, position){
                                return InkWell(
                                  onTap: (){
                                    /*Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                            data.articles![position].description!,
                                            data.articles![position].source!.name,
                                            DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                            data.articles![position].urlToImage,
                                            Constants.ROUTE_HOME
                                        )));*/
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height * 0.5,
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: data.articles![position].urlToImage != null ? ClipRRect(
                                                  child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                                    fit: BoxFit.cover,
                                                    placeholder: (ctx, st){
                                                      return SpinKitCircle(color: Colors.blue,);
                                                    },
                                                    errorWidget: (ctx, str, obj){
                                                      return Image.asset("assets/images/404.png", fit: BoxFit.cover,);
                                                    },
                                                  ),
                                                  borderRadius: BorderRadius.circular(15),
                                                ) : ClipRRect(child: Image.asset("assets/images/404.png", fit: BoxFit.cover,),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                width: size.width,
                                              ),
                                            ),
                                            SizedBox(height: 3,),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(padding: EdgeInsets.only(left: 3),child: Wrap(
                                                children: [Text(data.articles![position].title!,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14
                                                  ),
                                                )],
                                              )),
                                            ),
                                            SizedBox(height: 12,),
                                            ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
                                              child: Text(data.articles![position].source!.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                              fit: BoxFit.contain,
                                              alignment: Alignment.centerLeft,
                                            ),
                                              trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700
                                                  )
                                              ),
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: data.articles!.length,
                            ),
                          );
                        },
                      );
                    }
                  }
              ),
            );
          }
        }
      ),
    );
  }
}
