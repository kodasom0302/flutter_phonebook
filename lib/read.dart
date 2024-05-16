import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  //기본 레이아웃
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("읽기 페이지"),
      ),
      body: Container(
        padding: EdgeInsets.all(18),
        color: Color(0xffd6d6d6),
        child: _ReadPage(),
      )
    );
  }
}

//상태 변화를 감시하게 등록시키는 클래스 - 자동 생성되기 때문에 '그런가 보다~'하고 알면 됨
class _ReadPage extends StatefulWidget {
  const _ReadPage({super.key});

  @override
  State<_ReadPage> createState() => _ReadPageState();
}

//할 일 정의 클래스(통신, 데이터 적용)
class _ReadPageState extends State<_ReadPage> {
  //변수

  //미래에 정우성 데이터가 담길 거야
  late Future<PersonVo> personVoFuture;

  //초기화 함수 - 한번만 실행
  @override
  void initState() {
    super.initState();

    //추가 코드 //데이터 불러오는 메소드 호출
    print("initState() : 데이터 가져오기");
  }

  //화면 그리기
  @override
  Widget build(BuildContext context) {
    //라우터로 전달받은 personId
    //ModalRoute를 통해 현재 페이지에 전달된 arguments 가져오기
    late final args=ModalRoute.of(context)!.settings.arguments as Map;

    //personId 키를 사용하여 값 추출하기
    late final personId=args["personId"];
    print("-----------------------------");
    print(personId);
    print("-----------------------------");

    personVoFuture = getPersonByNo(personId);

    print("build() : 그리기 작업");

    return FutureBuilder(
      future: personVoFuture, //Future<> 함수명, 으로 받은 데이타
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else {
          //데이터가 있으면
          return Column(
                children: [
                  Row(
                    children: [
                      //Text("1층"),
                      Container(
                        width: 70,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "번호",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.data!.personId}",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ), //1층
                  Row(
                    children: [
                      //Text("2층"),
                      Container(
                        width: 70,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "이름",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.data!.name}",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ), //2층
                  Row(
                    children: [
                      //Text("3층"),
                      Container(
                        width: 70,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "핸드폰",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.data!.hp}",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ), //3층
                  Row(
                    children: [
                      //Text("4층"),
                      Container(
                        width: 70,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "회사",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 50,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.data!.company}",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ), //4층
                ],
              );
              /*
            Row(
              children: [
                Text("번호"),
                Text("25"),
            */
              //한 줄에 두 칸
        } // 데이터가 있으면
      },
    );
  }

  //3번 정우성 데이터 가져오기(=return) - 그리기X
  Future<PersonVo> getPersonByNo(int pId) async {
    print(pId);

    print("getPersonByNo() : 데이터 가져오는 중");

    try {
/*----요청 처리-------------------*/
//Dio 객체 생성 및 설정
      var dio = Dio();
// 헤더 설정: json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

// 서버 요청
      final response = await dio.get //put : 수정  //delete : 삭제
          (
        //'http://localhost:9000/api/persons/${no}',
        //'http://localhost:9000/api/persons/25',
        'http://15.164.245.216:9000/api/persons/${pId}',
        //'http://localhost:9005/api/list/1',
      );
/*----응답처리-------------------*/
      if (response.statusCode == 200) {
//접속 성공 200 이면
        //print(response.data); // json -> map 자동 변경
        print(response.data);
        return PersonVo.fromJson(response.data["apiData"]);
      } else {
//접속 실패 404, 502등등 api 서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
//예외 발생
      throw Exception('Failed to load person: $e');
    } //getPersonByNo()
  }
}
