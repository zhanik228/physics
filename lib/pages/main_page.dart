import 'package:flutter/material.dart';
import 'package:physics/pages/lesson_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/black_i.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Физика пәніне көмекші',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Бұл қосымша сізге физиканың негіздерін оңай үйренуге және түсінуге көмектеседі.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Физика әлемінің қызықты қырларын ашыңыз! Өз тарауыңызды таңдаңыз, қызықты тесттерден өтіңіз және білімнің жаңа көкжиектерін ашыңыз.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 108, 182, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      onPressed:() {
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                          return LessonList();
                        },));
                      }, 
                      child: Text(
                        'Бастау ▶️',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}