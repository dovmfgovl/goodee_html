//아래는 동기 코드인가? 비동기 코드인가?
//자바스크립트는 순서대로 처리가 된다(defer 강조 - 보류 - 지연)
//흐름을 바꾼다 - 논리적인 오류 - 트러블 슈팅
//DOM Tree(브라우저) - DOM API를 통해서 접근이 가능하다
const hap = (a,b) => {
  setTimeout(()=>{
    //return, 실행문 - 제어문
    return a+b;
  }, 1000) // 1초 간의 지연이 발생함
}

const x = hap(1, 2);
const y = x;
console.log(x);
console.log(y);

/*
  setTimeout(콜백함수, 지연되는 시간 - millisec)

  비동기적인 상황을 마주하기 전에 대비를 해본다
  html + 서블릿
  html + jsp
  네트워크 - 도메인 다름, 포트 - 네트워크 지연발생, 여보세요(IO) 지연 - waiting - 콜백함수
  html + 지연발동 + 스프링(Tomcat - 172.16.2.3:8000) + 오라클(211.150.35.7:1521)
  html + javascript(promise, async: 비동기상황 알림, await 함수호출 - 콜백) + 스프링

  오라클 서버제품

  왜 하필 네가 이 역할을 맡아?
  html - 클라이언트 다운로드 - 단방향, 제어문이 없다
  css - 상동 - 예쁜 애
  js - 상동 - 로컬 처리되는 언어 - 처리 주체가 로컬(브라우저)! - 셋 중 자바스크립트 네가 해줘야겠어(백엔드와 프론트 사이 양방향 수용, 처리하는 것/ firebase.js or authLogin.js)

  js - 1995년
  jquery - 2006년 - 최초 문서화 작업 - api
  jqueryUI - 2010년 - 화면단 - 국토개발부에서 사용
  NodeJS - 2009년 - V8
  ES6 - 2015년 - 모듈화, 모더니즘, jquery가 아니어도 되지 않을까? html5 등장
  jquery : 2022년부터 순위에서 빠짐
  
  <div id = 'root'>값</div> - 오라클(cursor - 로우+커럼 -> 테이블) - 자바(List<Map>, List<VO>) - JSON - Array

  document.querySelector('#root').innerHTML = `${변수명}`

  자바, 서블릿, jsp, 스프링, 오라클, mysql(백엔드)

  action에 오는 페이지는 사용자가 입력한 값을 전송하고 처리를 받아서 돌려줄 요청 URL
  자바는 이 요청을 받을 수 없다 - 왜냐하면 http 프로토콜을 지원하는 api가 없으니까
  그럼 누가 있지? - 서블릿(태그를 문자열로 출력하니까 - 후지다) -> jsp -> spring
  Restful API 지원하는 함수로 전송방식 결정됨 - 서버측 청취한 후에 오라클(data+2)과 콜라보 결과 만들어 냄
  <form method = get action='http://172.16.2.3:8000/dept/deptList.jsp(do or gd)>
  </form>
*/