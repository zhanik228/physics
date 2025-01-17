import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physics/pages/lesson_menu.dart';

class LessonList extends StatefulWidget {
  const LessonList({super.key});

  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  List _lessons = [];

  Future readJson() async {
    var json = await rootBundle.loadString('assets/json/move.json');
    var jsondata = jsonDecode(json);
    _lessons = jsondata;
    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Физика бөлімдері', style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.6),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/black_i.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            _lessons.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: _lessons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LessonMenu(lesson: _lessons[index],); 
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                '${_lessons[index]['logo']}',
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('${_lessons[index]['title']}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Параграф саны: ${_lessons[index]['paragraph_count']}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ) : Text('no lessons'),
          ],
        ),
      ),
    );
  }
}