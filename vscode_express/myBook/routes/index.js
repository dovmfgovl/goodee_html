var express = require('express'); //외부 프레임워크 가져올 때
var router = express.Router(); //페이지 전환

/* GET home page. 
express가 Restful API를 지원해서 웹 서비스를 제공할 수 있게 해준다(서블릿, JSP)
router는 페이지 전환해주는 API로 - 화면 전환 처리 이벤트
get함수의 첫번째 파라미터가 요청에 대한 URL 주소이다.
URL주소마다 자바 단에서는 메소드를 설계(구현) 해야 한다.

아래 get요청에 대한 첫번째 자리는 요청에 따른 URL 패턴 이름이다.
프레임워크(스프링)에서는 - 이름을 가지고 메소드를 나눈다
그래서 라우터가 눈에 보이지 않는 것임

첫번째 파라미터는 요청객체이다(request) - 정보담기, 사용자가 입력한 값을 받아옴, 요청 유지되는 동안 유지해줌
두번째 파라미터는 응답객체이다(response) - mime type -> 브라우저 확장자는 의미없다. 페이지 이동처리 함 - 라우팅
  확장자가 jsp이더라도 application/json으로 되어 있다면 JSON인 것
  application/ms-word
세번째 파라미터인 next는 함수로 나누어지지 않은 대신에 다른 서비스를 호출해 줌(다음 서비스로 연결시켜줌) 

express프레임워크에서는 request, response 제공함
다른 서비스 요청을 위해 next도 제공함
next 통해 다른 서비스 즉, 다른 미들웨어 연결도 가능함

Restful 지원받을 수 있다 - 웹서비스 구현, 제공할 수 있다.
express 역할을 하는 것이 서블릿.

router.post();
*/

router.get('/', function(req, res, next) {
  //render 함수 호출: 화면을 그려줌
      //따라서 파라미터 자리에는 반드시 html파일이 온다
  //res.send("값");: 인자값 전송 - 값이 JSON일 수도 있다.
      //응답에 대한 결과가 반드시 html일 필요없다
      //화면처리에 대한 엔진으로 ejs가 선택됨(app.js 28번)
  res.render('index', { title: '도서관리시스템', pageName:"home.ejs"});
});
router.get('/login', function(req, res, next) { //app.js -> path 라이브러리 __dirname, views
  res.render('index', { title: '로그인', pageName:"auth/login.ejs" });
});
router.get('/board', function(req, res, next) { //app.js -> path 라이브러리 __dirname, views
  res.render('index', { title: '글목록', pageName:"board/list.ejs" });
});
router.get('/board/write', function(req, res, next) { //app.js -> path 라이브러리 __dirname, views
  res.render('index', { title: '글쓰기', pageName:"board/write.ejs" });
});
router.get('/board/:id', function(req, res, next) { //app.js -> path 라이브러리 __dirname, views
  let id = req.params.id;
  res.render('index', { title: '상세보기', pageName:"board/read.ejs", id: id });
});
router.get('/board/update/:id', function(req, res, next) { //app.js -> path 라이브러리 __dirname, views
  let id = req.params.id;
  res.render('index', { title: '글수정', pageName:"board/update.ejs", id: id });
});

module.exports = router;
