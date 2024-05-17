import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/categories_view_model.dart';
import '../../../../view_model/news_view_model.dart';

class ExtraLargeTablet extends StatefulWidget {
  const ExtraLargeTablet({super.key});

  @override
  State<ExtraLargeTablet> createState() => _ExtraLargeTabletState();
}

class _ExtraLargeTabletState extends State<ExtraLargeTablet> {
  NewsViewModel? _newsViewModel;
  CategoriesViewModel? _categoriesViewModel;
  String _currentPanel = "";
  @override
  void initState() {
    _currentPanel = Constants.CHANNEL_PANEL;
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    Future.delayed(Duration.zero, (){
      _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
      _categoriesViewModel = Provider.of<CategoriesViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Container(width: size.width,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xffD9D9D9).withOpacity(1.0),
                            Color(0xffD9D9D9).withOpacity(0.23)
                          ]
                      )
                  ),
                  alignment: Alignment.center,
                  child: Text("News",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 3,child: Container(width: size.width * 0.15,child: ClipRRect(borderRadius: BorderRadius.only(topRight: Radius.circular(35)),child: Image.asset("assets/images/splash_pic.jpg", fit: BoxFit.cover,)))),
                      Expanded(flex: 5, child: Container(
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xffF7F4E7)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: size.height * 0.07,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0, left: 5.0),
                                child: Text("Channels", style: GoogleFonts.poppins(
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
                                onTap: (){
                                  _currentPanel = Constants.CHANNEL_PANEL;
                                  _newsViewModel!.fetchBbcHeadlinesNews();
                                },
                                child: SizedBox(
                                  height: size.height * 0.07,
                                  child: Text("BBC", style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: InkWell(
                                onTap: (){
                                  _currentPanel = Constants.CHANNEL_PANEL;
                                  _newsViewModel!.fetchCnnHeadlinesNews();
                                },
                                child: SizedBox(
                                  height: size.height * 0.07,
                                  child: Text("CNN", style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: InkWell(
                                onTap: (){
                                  _currentPanel = Constants.CHANNEL_PANEL;
                                  _newsViewModel!.fetchAlJazeeraHeadlinesNews();
                                },
                                child: SizedBox(
                                  height: size.height * 0.07,
                                  child: Text("Al Jazeera", style: GoogleFonts.poppins(
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
                                onTap: (){
                                  _currentPanel = Constants.CHANNEL_PANEL;
                                  _newsViewModel!.fetchIndependentHeadlinesNews();
                                },
                                child: SizedBox(
                                  height: size.height * 0.07,
                                  child: Text("Independent", style: GoogleFonts.poppins(
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
                                onTap: (){
                                  _currentPanel = Constants.CHANNEL_PANEL;
                                  _newsViewModel!.fetchReutersHeadlinesNews();
                                },
                                child: SizedBox(
                                  height: size.height * 0.07,
                                  child: Text("Reuters", style: GoogleFonts.poppins(
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
                        future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
                        builder: (ctx, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                            return SpinKitCircle(
                              color: Colors.blue,
                              size: 40,
                            );
                          }
                          else{
                            return Consumer2<NewsViewModel, CategoriesViewModel>(
                                builder: (ctx, news, categories, ch){
                                  var data = news.getHeadlines;
                                  print("news length: ${data.articles!.length}");
                                  if(_currentPanel.contains(Constants.CHANNEL_PANEL)) {
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
                                            crossAxisCount: 3,
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
                                                            .urlToImage != null
                                                            ? ClipRRect(
                                                          child: CachedNetworkImage(
                                                            imageUrl: data
                                                                .articles![position]
                                                                .urlToImage,
                                                            fit: BoxFit.fill,
                                                            placeholder: (ctx,
                                                                st) {
                                                              return SpinKitCircle(
                                                                color: Colors
                                                                    .blue,);
                                                            },
                                                            errorWidget: (ctx,
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
                                                          child: Image.asset(
                                                            "assets/images/404.png",
                                                            fit: BoxFit.cover,),
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
                                                              .only(left: 3),
                                                          child: ClipRect(
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
                                                            ),
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
                                                              fontSize: 12,
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
                                                              "en_US").format(
                                                              DateTime.parse(
                                                                  data
                                                                      .articles![position]
                                                                      .publishedAt!)),
                                                          style: TextStyle(
                                                              fontSize: 12,
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
                                  }
                                  else{
                                    var data = categories.getCategoriesHeadLines;
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
                                            crossAxisCount: 3,
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
                                                            .urlToImage != null
                                                            ? ClipRRect(
                                                          child: CachedNetworkImage(
                                                            imageUrl: data
                                                                .articles![position]
                                                                .urlToImage,
                                                            fit: BoxFit.cover,
                                                            placeholder: (ctx,
                                                                st) {
                                                              return SpinKitCircle(
                                                                color: Colors
                                                                    .blue,);
                                                            },
                                                            errorWidget: (ctx,
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
                                                          child: Image.asset(
                                                            "assets/images/404.png",
                                                            fit: BoxFit.cover,),
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
                                                              .only(left: 3),
                                                          child: Text(data
                                                              .articles![position]
                                                              .title!,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w700,
                                                                fontSize: 18
                                                            ),
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
                                                              "en_US").format(
                                                              DateTime.parse(
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
                                  }
                                },
                            );
                          }
                        }
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(flex: 3,child: Container(width: size.width * 0.15,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),child: Image.asset("assets/images/splash_pic.jpg", fit: BoxFit.cover,)))),
                      Expanded(flex: 5, child: Container(
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                            color: Color(0xffF7F4E7)
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.07,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2.0, left: 5.0),
                                  child: Text("Categories", style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 2,),
                              Container(
                                width: 304,
                                height: 1,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchSportsCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Sports", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchEntertainmentCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Entertainment", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchGeneralCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("General", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                  ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchTechnologyCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Technology", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchScienceCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Science", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchBusinessCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Business", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  onTap: (){
                                    _currentPanel = Constants.CATEGORIES_PANEL;
                                    _categoriesViewModel!.fetchHealthCategoryNews();
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.07,
                                    child: Text("Health", style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ),)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
