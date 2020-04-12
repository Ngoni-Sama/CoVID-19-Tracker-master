import 'package:covid_19_tracker/utils/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_19_tracker/utils/constants.dart';

final List<String> imgList = [
  'assets/images/hand-wash.jpeg',
  'assets/images/human_contact.png',
  'assets/images/prevent_corona_small.png',
  'assets/images/air.png',
  'assets/images/doctor_patient.png'
];

final List<String> stepList = [
  'Wash your hands frequently',
  'Maintain social distancing',
  'Avoid touching eyes, nose and mouth',
  'Practice respiratory hygiene',
  'Seek medical care early'
];

final List<String> infoList = [
  'Washing your hands with soap and water or using alcohol-based sanitizer kills viruses that may be on your hands.',
  'Maintain at least 1 metre distance between yourself and anyone who is coughing or sneezing. If you are too close, you can breathe in the droplets, including the COVID-19 virus if the person coughing has the disease. ',
  'Hands touch many surfaces and can pick up viruses. Once contaminated, hands can transfer the virus to your eyes, nose or mouth. From there, the virus can enter your body and can make you sick.',
  'Make sure you, and the people around you, follow good respiratory hygiene. This means covering your mouth and nose with your bent elbow or tissue when you cough or sneeze. Then dispose of the used tissue immediately.',
  'Stay home if you feel unwell. If you have a fever, cough and difficulty breathing, seek medical attention and call in advance. Follow the directions of your local health authority.'
];

final List carouselImages = map<Widget>(
  imgList, stepList, infoList,
      (index, i) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Image.asset(i, fit: BoxFit.fitHeight, width: 200),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(stepList[index],
                style: Constants.kTitleStyle,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              child: Text(infoList[index],
              style: Constants.kSubtitleStyle,),
            ),
          )
        ],
      ),
    );
  },
).toList();

List<T> map<T>(List list, List wordList, List infoList, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class PreventativeMeasuresScreen extends StatefulWidget {
  @override
  _PreventativeMeasuresScreenState createState() =>
      _PreventativeMeasuresScreenState();
}

class _PreventativeMeasuresScreenState
    extends State<PreventativeMeasuresScreen> {

  // Step indicator
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: true,
        leading: _goBackButton(context),
    title: Text(
    'Prevention',
    style: TextStyle(
    fontSize: 18, fontWeight: FontWeight.w700,
    color: Colors.white,
    ),
    ),
    backgroundColor: Color(0xFF212b46)
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 0.40,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        color: preventivePageBGColor,
                      ),
                    ),
                    clipper: CustomClipPath(),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 25.0,
                    child: Image.asset(
                      'assets/images/doctor.png',
                      height: 100.0,
                    ),
                  ),
                  Positioned(
                    left: 85.0,
                    bottom: 70.0,
                    child: Image.asset(
                      'assets/images/stop_covid.png',
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
                  Positioned(
                    bottom: 90.0,
                    right: 35.0,
                    child: Text(
                      'All you need to\n do is stay at home.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Take steps to protect yourself and others',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: <Widget>[
                CarouselSlider(
                  items: carouselImages,
                  viewportFraction: 1.0,
                  aspectRatio: 1.1,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    imgList, stepList, infoList,
                        (index, url) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Color.fromRGBO(0, 0, 0, 0.9)
                                : Color.fromRGBO(0, 0, 0, 0.4)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 80, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget _goBackButton(BuildContext context) {
  return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pop(true);
      });
}