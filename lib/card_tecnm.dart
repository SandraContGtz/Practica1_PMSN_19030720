import 'package:flutter/material.dart';
import 'responsive.dart';

class CardtecnmData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  CardtecnmData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
  });
}

class Cardtecnm extends StatelessWidget {
  const Cardtecnm({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardtecnmData data;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Stack(
        children: [
          if (data.background != null) data.background!,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Flexible(
                  flex: 20,
                  child: Image(image: data.image),
                ),
                const Spacer(flex: 1),
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                ),
                const Spacer(flex: 1),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
                const Spacer(flex: 10),
              ],
            ),
          ),
        ],
      ),
      desktop: Stack(
        children: [
          /*const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
          ),*/
          if (data.background != null) data.background!,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 1,
                  ),
                  Flexible(
                    child: ImageCard(data: data),
                  ),
                  Column(
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.title.toUpperCase(),
                        style: TextStyle(
                            //fontFamily: impact,
                            color: data.titleColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 600,
                        child: Text(
                          data.subtitle,
                          style: TextStyle(
                            color: data.subtitleColor,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.data,
  });

  final CardtecnmData data;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: data.image,
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    );
  }
}
