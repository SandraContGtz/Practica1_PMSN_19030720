import 'package:psmna10/card_tecnm.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../responsive.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    CardtecnmData(
      title: "TecNM en Celaya",
      subtitle:
          "Somos una institución que trabaja con entusiasmo, que realiza esfuerzos para que sus estudiantes logren adaptarse al reto de un mundo global, competitivo y exigente.",
      image: const AssetImage("assets/itce.png"),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      titleColor: Color.fromARGB(255, 13, 15, 143),
      subtitleColor: Color.fromARGB(255, 8, 7, 7),
      background: LottieBuilder.asset("assets/animations/background.json"),
    ),
    CardtecnmData(
      title: "Oferta Educativa",
      subtitle:
          "Su oferta educativa la conforman 10 programas de licenciatura y 12 de posgrado cabe mencionar que el 100% acreditados como programas de calidad, lo que refiere a   instalaciones físicas y equipamiento de laboratorios y talleres.",
      image: const AssetImage("assets/lince.png"),
      backgroundColor: Color.fromARGB(255, 153, 193, 159),
      //Color.fromARGB(255, 115, 143, 190)
      //Color.fromARGB(116, 15, 17, 130)
      //Color.fromARGB(255, 44, 116, 39)
      titleColor: Color.fromARGB(255, 37, 104, 33),
      subtitleColor: Color.fromARGB(255, 0, 0, 0),
      background: LottieBuilder.asset("assets/animations/background.json"),
    ),
    CardtecnmData(
      title: "Ing. en Sistemas Computacionales",
      subtitle:
          "El y la Ingeniero/a en Sistemas Computacionales, tiene conocimientos de alto nivel tecnológico y científico para ser un profesionista con visión innovadora capaz de crear y proveer soluciones de software e infraestructura computacional de vanguardia en la nueva y dinámica sociedad de la era digital.",
      image: const AssetImage("assets/sistemas.jpg"),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      titleColor: Color.fromARGB(255, 44, 116, 39),
      subtitleColor: Color.fromARGB(255, 0, 0, 0),
      background: LottieBuilder.asset("assets/animations/background.json"),
    ),
    CardtecnmData(
      title: "Instalaciones",
      subtitle:
          "En materia de instalaciones físicas y equipamiento de laboratorios y talleres, ha sido notable el paulatino avance hasta llegar a cubrir casi en su totalidad 20 hectáreas con aulas, laboratorios, edificio de Innovatec-CEVIDE instalaciones deportivas y culturales entre otras, rodeadas de  hermosas áreas verdes y un extenso acervo cultural.",
      image: const AssetImage("assets/instalaciones.png"),
      backgroundColor: Color.fromARGB(116, 15, 17, 130),
      titleColor: Color.fromARGB(255, 13, 15, 143),
      subtitleColor: Color.fromARGB(255, 0, 0, 0),
      background: LottieBuilder.asset("assets/animations/bg-3.json"),
    ),
    CardtecnmData(
      title: "¡Registrate!",
      subtitle: "Entra ya a nuestra aplicación y conoce más, presiona el botón",
      image: const AssetImage("assets/login1.png"),
      backgroundColor: Color.fromARGB(255, 229, 240, 218),
      titleColor: Color.fromARGB(255, 13, 15, 143),
      subtitleColor: Color.fromARGB(255, 0, 0, 0),
      background: LottieBuilder.asset("assets/animations/background.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Responsive(
        mobile: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          verticalPosition: 0.73,
          itemCount: data.length,
          itemBuilder: (int index) {
            return Cardtecnm(data: data[index]);
          }
          /*itemBuilder: (int index, double value) {
          return Cardtecnm(data: data[index]);
        }*/
          ,
          onFinish: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
        desktop: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          verticalPosition: 0.85,
          radius: 1000,
          itemCount: data.length,
          itemBuilder: (int index) {
            return Cardtecnm(data: data[index]);
          },
          onFinish: () {
            Navigator.pushNamed(context, '/login');
          },
        ),
      ),
    );
  }
}

/*class LottieImage extends StatelessWidget {
  const LottieImage(this.background, {super.key});

  final String background;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Padding(
        padding: const EdgeInsets.only(top: 350),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LottieBuilder.asset(
            background,
            fit: BoxFit.cover,
          ),
        ),
      ),
      desktop: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: LottieBuilder.asset(
            background,
          ),
        ),
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Responsive(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              color: const Color.fromARGB(255, 59, 160, 255),
              textColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
              textColor: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    elevation: 0,
                    height: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    color: const Color.fromARGB(255, 59, 160, 255),
                    textColor: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Iniciar Sesion",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    height: 50,
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    textColor: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Registrarse",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
