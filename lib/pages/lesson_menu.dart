import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:physics/pages/testing.dart';

class LessonMenu extends StatelessWidget {
  final lesson;
  const LessonMenu({required this.lesson, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/black_i.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  '${lesson['title']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lesson['shamalar'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.black.withOpacity(0.6),
                        child: Column(
                          children: [
                            Text(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              '${lesson['shamalar'][index]['title']}',
                            ),
                            Text(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              '${lesson['shamalar'][index]['description']}',
                            ),
                            SizedBox(height: 15,),
                            lesson['shamalar'][index]['image'] != null
                            ? Container(
                              child: InstaImageViewer(
                                child: Image.asset('${lesson['shamalar'][index]['image']}', fit: BoxFit.contain,),
                              ),
                            )
                            : Text('')
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                lesson['tests'].isEmpty ? Text('') : Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 108, 182, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                    onPressed:() {
                      Navigator.push(context, MaterialPageRoute(builder:(context) {
                        return Testing(lesson: lesson,);
                      },));
                    }, 
                    child: Text(
                      'Тесттерге бару ▶️',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}