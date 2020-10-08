import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

const HOME_SCREEN_ROUTE = '/';
const DETAIL_SCREEN_ROUTE = '/detail';

void main() => runApp(RoutingApp());

class DetailScreenArguments {
  final int width;
  final int height;
  final String name;

  DetailScreenArguments(this.width, this.height, this.name);
}

class RoutingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HOME_SCREEN_ROUTE,
      routes: {
        HOME_SCREEN_ROUTE: (context) => HomeScreenWidget(),
        DETAIL_SCREEN_ROUTE: (context) => DetailWidget()
      },
      theme: ThemeData(primaryColor: Colors.black),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
          centerTitle: true,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final width = max(Random().nextInt(500), 250);
            final height = max(Random().nextInt(500), 250);
            final name = 'Nya #${index + 1} ($width * $height)';

            return Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: 'https://placekitten.com/$width/$height',
                  ),
                  Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(5),
                    child: Text(name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  Positioned(
                      bottom: 0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, DETAIL_SCREEN_ROUTE,
                              arguments:
                                  DetailScreenArguments(width, height, name));
                        },
                        child: Text('Nya to details',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.black,
                      ))
                ],
              ),
            );
          },
        ));
  }
}

class DetailWidget extends StatelessWidget {
  DetailWidget();

  @override
  Widget build(BuildContext context) {
    final DetailScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen for ${args.name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: 'https://placekitten.com/${args.width}/${args.height}',
                ),
                Positioned(
                  top: 0.5,
                  child: Container(
                    color: Colors.black,
                    child: Text(args.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.black,
              child: Text('Description',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.headline4.fontSize)),
            ),
            Text(
              lipsum.createText(numParagraphs: 2, numSentences: 3),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
