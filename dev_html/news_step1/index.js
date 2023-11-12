//브라우저에 내장되어 있는 객체 - XMLHttpRequest -> ajax(아작스, 에이젝스)
//변수 선언 방법 : let - 변하는 값 선언 시, const - 상수 선언 시
//const 선언은 블록 범위의 상수를 선언합니다. 상수의 값은 재할당할 수 없으며 다시 선언할 수도 없습니다.
const ajax = new XMLHttpRequest(); //브라우저가 비동기처리를 위해 제공하는 내장 객체임
//List<Map> or List<VO>[Oracle or ] -> Gson -> JSON 포맷 뽑아낼 수 있다. - 백엔드 - 서블릿 or JSP(9000번), 스프링(8000번)
//자바로 웹서비스 지원할까
//브라우저에 <object>에서 자바클래스를 유일하게 호출할 수 있었다.
//그런데 서버에서 그 요청을 처리(주체가 서버여야함)하고 그 결과만 클라이언트측에 다운로드를 시킴
//서버에서 동작하는 애플릿 Serv + let -> 웹서비스를 지원할 수 있다. -> 서블릿은 자바다 -> 자바에 태그를 어떻게 적지? -비효율적
// -> 그래서 JSP(Java Server Page)
//자바(http프로토콜을 지원하지 않아 - web 서비스 지원 안 됨) -> 서블릿(Http 프로토콜을 지원하는 API -클래스를 지원(request, response을 내장객체로 지원))
//통신을 통해서 서버측에 요청을 해온다(동기, 비동기).
//동기적일 땐 그 요청에 대한 결과가 도착할 때까지 무작정 계속 기다림 - 비효율적
//0 -> 1 -> 2 -> 3 -> 4 상태값이 바뀔때마다(함수를 호출함) 체크함
//  상태가 바뀌는 걸 지속적으로 체크하면서 처리를 담당해 줄 콜백함수를 정해놓는다.
const NEWS_URL = 'https://api.hnpwa.com:80/v0/news/1.json'; //서버측 소통 -> servlet or jsp or spring(여기가 스팟!) //디폴트 포트 번호 80
const NEWS_URL2 = 'http://172.16.2.3/dept/deptList.kh'; //서버측 소통 -> servlet or jsp or spring(여기가 스팟!) //디폴트 포트 번호 80
//open은 XMLHttpRequest 객체가 제공하는 함수로 파라미터는 3개가 필요함
//1) 전송방식 2) 요청하는 URL 3) true: 비동기, false: 동기 처리로 요청해 줌
//ajax변수는 XMLHttpRequest를 참조하는 변수명임
ajax.open('GET', NEWS_URL, false);
ajax.send(); //send() 호출될 때 비로소 서버측에 요청이 일어남 - 0번에서 출발함 - 1번(전화옴) - 2번(기사가 물건 가져감) - 3번(이동) - 4번(물건 도착)
//이 상태를 추적해 줄 함수를 구현하지 않았다. - 콜백 함수를 생략했음 

const newsList = JSON.parse(ajax.response); //위에서 요청했을 때 서버측의 응답을 받아오는 속성이 response임
console.log(newsList); //서버측에서 보낸 응답을 출력해보기 - Array로 변환하여 출력해줌
const ul = document.createElement('ul'); //DOM API 가지고 태그를 만드니 직관적이지 않다. DOM Tree 그려지지 않아서.
for(let i=0; i<newsList.length; i++){
  const li = document.createElement('li');
  //console.log(newList[i].title);
  li.innerHTML = newsList[i].title;
  ul.appendChild(li);
}//end of for
document.getElementById('root').appendChild(ul);