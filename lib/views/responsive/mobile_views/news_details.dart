import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_headlines_model.dart';

class NewsDetails extends StatefulWidget {
  late Articles _article;
  NewsDetails(Articles article){
    this._article = article;
  }

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                  ),
                  child: widget._article.urlToImage != null ? CachedNetworkImage(imageUrl: widget._article.urlToImage!,
                  fit: BoxFit.cover,
                    placeholder: (ctx, st){
                    return SpinKitCircle(
                      color: Colors.blue,
                    );
                    },
                    errorWidget: (ctx, st, obj){
                    return Icon(
                      Icons.error,
                      color: Colors.red,
                    );
                    },
                  )
                  :
                  Image.asset("assets/images/404.png"),
                ),
              ),
              Positioned(child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                width: size.width,
                height: size.height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    ),
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Text(widget._article.title!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                    ),
                    flex: 1
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Text(
                          widget._article.source!.name!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.blue
                          ),
                        ),
                        trailing: Text(
                          DateFormat.yMMMd("en_US").format(DateTime.parse(widget._article.publishedAt!))
                        ),
                      ),
                    ),
                    Expanded(child: SingleChildScrollView(
                      child: Text(
                        widget._article.description!
                      )
                    ),
                    flex: 3,
                    )
                  ],
                ),
              ),
              top: size.height * 0.4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
