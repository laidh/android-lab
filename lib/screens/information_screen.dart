import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:volunteer/models/ui/info_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer/models/ui/article.dart';
import 'package:volunteer/screens/profile/profile_screen.dart';

class InformationScreen extends StatelessWidget {
  List<InfoCard> _infoCards = [
    InfoCard(
        'Корисна література',
        SvgPicture.asset(
            'assets/images/information_screen/icon_group_book.svg'),
        'https://en.wikipedia.org/wiki/Ukraine'),
    InfoCard(
        'Законодавча база роботи волонтерів',
        SvgPicture.asset(
            'assets/images/information_screen/icon_group_document.svg'),
        'https://en.wikipedia.org/wiki/European_Union'),
    InfoCard(
        'Зразок волонтерської заяви',
        SvgPicture.asset(
            'assets/images/information_screen/icon_group_legitimacy.svg'),
        'https://en.wikipedia.org/wiki/NATO'),
  ];

  List<Article> _articles = [
    Article(
        'Чи втрачений 2020? МолоДвіж запрошує на обговорення: програма заходу та спікери',
        '4 вересня 2020',
        'Молодвіж',
        'https://lviv.com/novyny/chy-vtrachenyi-2020-molodvizh-zaproshuie-na-obhovorennia-prohrama-zakhodu-ta-spikery/',
        '5-6 вересня відбудеться всеукраїнський молодіжний захід “МолоДвіж NOT.Wasted”. Подія проходитиме в офлайн-режимі у Львові на території !FestRepublic впродовж 24 годин і буде зосереджена на обговоренні того, чи втрачений для молоді 2020 рік, куди рухатися далі, того, як пандемія змінить наше життя, ритуали і звички, як світ переосмислює цінності, перед якими викликами ми постаємо і як з ними впоратися.',
        'assets/images/images_for_articles/first_test_article.jpg'),
    Article(
        'У Львові відбувся пілотний запуск Lviv Open Lab',
        '11 вересня 2020',
        'Lviv Open Lab',
        'https://prozahid.com/u-lvovi-vidbuvsia-pilotnyi-zapusk-lviv-open-lab/',
        'У суботу, 10 жовтня, на проспекті Червоної Калини, 58 відбувся довгоочікуваний пілотний запуск Lviv Open Lab — міського простору інноваційної освіти, що покликаний стати осередком для талановитих дітей та молоді у місті Львові.',
        'assets/images/images_for_articles/second_test_article.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Інформація",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.grey[800],
                size: 36,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 160.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _infoCards.map((infoCard) {
                return Row(
                  children: [
                    InkWell(
                      child: Container(
                        width: 120.0,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            infoCard.picture,
                            Text(
                              infoCard.title,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      onTap: () => launch(infoCard.url),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Container(
            height: 30,
            width: size.width,
            child: Container(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                "Блог",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Container(
              height: 1000,
              width: size.width,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: _articles.map((article) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () => launch(article.url),
                        child: Container(
                          margin: EdgeInsets.all(12.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3.0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(article.pathToImage),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                article.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amber,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 3.0,
                                                      color: Colors.black)
                                                ]),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            article.author,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      article.publishedDate,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              ExpansionTile(
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Показати більше',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ),
                                children: [
                                  Text(
                                    article.body,
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )),
        ]),
      ),
    );
  }
}
