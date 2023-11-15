var myHeaders = new Headers();
myHeaders.append("Authorization", "KakaoAK 1270689e90debc4edc797c63e2f3eb5e");
//사용자가 입력한 정보를 담는 객체 - 필요없다
//var formdata = new FormData();
//body속성을 통해서 서버측에 뭔가 넘겨줘야 원하는 정보를 받아 올 수 있다(카카오페이, 토스증권 결제서비스)
//body속성을 사용해서 값을 전달할 때는 GET 방식불가 -> POST로 해야함
//body속성에 넘기는 정보는 반드시 문자열로 한다
/*
  GET 방식으로 서버측에 값을 넘길 땐 쿼리스트링을 사용할 수 있지만
  아래서 처럼 body속성을 이용해서 값을 넘길 땐 반드시 POST 방식 전송해야 함
  Request with GET/HEAD method cannot have body.
    at 패치1.js:18:1
*/
var requestOptions = {
  method: 'POST',
  headers: myHeaders,
  body: JSON.stringify({
    name: '나신입',
    email: 'nice@hot.com'
  }), //key를 가지고 value에 접근할 수 있다.
  redirect: 'follow'
};

fetch("https://dapi.kakao.com/v3/search/book?target=title&query=오라클&size=3", requestOptions)
  .then(response => response.json()) //or json()을 하면 묶어줌/ then이 반환하는 Promise
  .then(result => console.log(result)) //Promise가 제공하는 함수나 속성을 호출할 수 있다.
  .catch(error => console.log('error', error)); //에러 발생했을 때 실행됨