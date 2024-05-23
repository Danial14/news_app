import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/route_util.dart';
import '../../../../view_model/news_view_model.dart';
import '../../web_views/categories_large_view.dart';
import 'medium_tablet_large_mobile_category.dart';

class LargeTablet extends StatefulWidget {
  const LargeTablet({super.key});

  @override
  State<LargeTablet> createState() => _LargeTabletState();
}

class _LargeTabletState extends State<LargeTablet> {
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
    Size constraints = MediaQuery.of(context).size;
    double panelItemsHeight = constraints.height * 0.07;
    print("max height: ${constraints.height}");
    print("orientation");
    if(constraints.height > 992 && constraints.height < 1200){
      panelItemsHeight = constraints.height * 0.04;
    }
    else if(constraints.height >= 1200){
      print("max height: ${constraints.height}");
      panelItemsHeight = constraints.height * 0.03;
    }
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait ?AppBar(
        centerTitle: true,
        title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        leading: IconButton(
          onPressed: (){
            /*Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return CategoryScreen();
            }));*/
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
                child: Container(height: 35,width: constraints.width,child: Text("BBC", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchAlJazeeraHeadlinesNews();
                },
                child: Container(width: constraints.width,height: 35,child: Text("Al Jazeera", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchCnnHeadlinesNews();
                },
                child: Container(height: 35,width: constraints.width,child: Text("CNN", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchIndependentHeadlinesNews();
                },
                child: Container(height: 35,width: constraints.width,child: Text("Independent", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await _newsViewModel!.fetchReutersHeadlinesNews();
                },
                child: Container(height: 35,width: constraints.width,child: Text("Reuters", style: TextStyle(color: Colors.black),)),
              ))
            ];
          })
        ],
      ) : null,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.portrait){
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
                                                width: constraints.width,
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
          return Container(
            width: constraints.width,
            height: constraints.height,
            child: Stack(
              children: [
                Container(width: constraints.width,
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xffD9D9D9).withOpacity(1.0),
                            Color(0xffD9D9D9).withOpacity(0.23)
                          ]
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                        ),
                      ),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("News",
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                          //SizedBox(width: constraints.maxWidth * 0.45,),
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(RouteUtil.createRoute(MediumTabletLargeMobileCategory()));
                              },
                              child: Image.asset(
                                "assets/images/category_icon.png",
                                width: 40, height: 40,),
                            ),
                          ),
                        ],
                      )
                      )
                    ],
                  )
                  ,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(flex: 3,
                              child: Container(
                                  width: constraints.width * 0.15,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(35)),
                                      child: Image.asset(
                                        "assets/images/splash_pic.jpg",
                                        fit: BoxFit.fill,)))),
                          Expanded(flex: 5, child: Container(
                            width: constraints.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xffF7F4E7)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: panelItemsHeight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 5.0),
                                    child: Text("Channels",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20
                                      ),),
                                  ),
                                ),
                                SizedBox(height: 2,),
                                Container(
                                  width: 304,
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      _newsViewModel!
                                          .fetchBbcHeadlinesNews();
                                    },
                                    child: SizedBox(
                                      height: panelItemsHeight,
                                      child: Text(
                                        "BBC", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                      ),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      _newsViewModel!
                                          .fetchCnnHeadlinesNews();
                                    },
                                    child: SizedBox(
                                      height: panelItemsHeight,
                                      child: Text(
                                        "CNN", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                      ),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      _newsViewModel!
                                          .fetchAlJazeeraHeadlinesNews();
                                    },
                                    child: SizedBox(
                                      height: panelItemsHeight,
                                      child: Text("Al Jazeera",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      _newsViewModel!
                                          .fetchIndependentHeadlinesNews();
                                    },
                                    child: SizedBox(
                                      height: panelItemsHeight,
                                      child: Text("Independent",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: InkWell(
                                    onTap: () {
                                      _newsViewModel!
                                          .fetchReutersHeadlinesNews();
                                    },
                                    child: SizedBox(
                                      height: panelItemsHeight,
                                      child: Text("Reuters",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                        ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 75),
                        child: FutureBuilder<bool>(
                            future: _newsViewModel!
                                .fetchInitialHeadlinesNews("bbc-news"),
                            builder: (ctx, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                                  !snapshot.data!) {
                                return SpinKitCircle(
                                  color: Colors.blue,
                                  size: 40,
                                );
                              }
                              else {
                                return Consumer<NewsViewModel>(
                                  builder: (ctx, news, ch) {
                                    var data = news.getHeadlines;
                                    print("news length: ${data.articles!
                                        .length}");

                                    return Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height,
                                      child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.8
                                        ),
                                        itemBuilder: (ctx, position) {
                                          return InkWell(
                                            onTap: () {
                                              /*Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                                      data.articles![position].description!,
                                                      data.articles![position].source!.name,
                                                      DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                      data.articles![position].urlToImage,
                                                      Constants.ROUTE_HOME
                                                  )));*/
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        child: data
                                                            .articles![position]
                                                            .urlToImage !=
                                                            null
                                                            ? ClipRRect(
                                                          child: CachedNetworkImage(
                                                            imageUrl: data
                                                                .articles![position]
                                                                .urlToImage,
                                                            fit: BoxFit
                                                                .fill,
                                                            placeholder: (
                                                                ctx,
                                                                st) {
                                                              return SpinKitCircle(
                                                                color: Colors
                                                                    .blue,);
                                                            },
                                                            errorWidget: (
                                                                ctx,
                                                                str, obj) {
                                                              return Image
                                                                  .asset(
                                                                "assets/images/404.png",
                                                                fit: BoxFit
                                                                    .cover,);
                                                            },
                                                          ),
                                                          borderRadius: BorderRadius
                                                              .circular(15),
                                                        )
                                                            : ClipRRect(
                                                          child: Image
                                                              .asset(
                                                            "assets/images/404.png",
                                                            fit: BoxFit
                                                                .cover,),
                                                          borderRadius: BorderRadius
                                                              .circular(15),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 3,),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .only(
                                                              left: 3),
                                                          child: Wrap(
                                                              children: [Text(data
                                                                  .articles![position]
                                                                  .title!,
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                    fontWeight: FontWeight
                                                                        .w700,
                                                                    fontSize: 16
                                                                ),
                                                              ),
                                                              ]
                                                          )),
                                                    ),
                                                    SizedBox(height: 12,),
                                                    ListTile(
                                                      contentPadding: EdgeInsets
                                                          .only(left: 3),
                                                      leading: FittedBox(
                                                        child: Text(data
                                                            .articles![position]
                                                            .source!.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight
                                                                  .w700
                                                          ),
                                                        ),
                                                        fit: BoxFit.contain,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                      trailing: Text(
                                                          DateFormat.yMMMd(
                                                              "en_US")
                                                              .format(
                                                              DateTime
                                                                  .parse(
                                                                  data
                                                                      .articles![position]
                                                                      .publishedAt!)),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight
                                                                  .w700
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
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
