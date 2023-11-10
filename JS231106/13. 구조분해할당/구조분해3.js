// 구조분해할당 - React(props)에서 많이 사용함 - Next.js(F/W) - FLUX 아키텍쳐 - 상태관리 해 줌
// 객체 다루기, 배열 다루기(Handlebars - 템플릿)
// 데이터셋(UI솔루션에서 나오는 키워드: Set)
// Oracle - 서블릿(컨트롤 계층 설계) - JSP(ejs, React, Vue.js...) - POJO(1-1, 1-2, 1-3) - Spring(레거시, Maven, Gradle)
// 데이터셋 누가 담당하나요? 백엔드 - Spring - Oracle, realtime firebase(채팅 구현)

//html(ejs-입력받겠지)[WAS- views - 물리적 위치 - 배포, 배치 - DevOps] -> 조회버튼 -> (자바) -> 오라클(select * from 도서) -> 
// List<Map>[리턴타입] -> JSON(com.google.gson.Gson - gson.jar)
// 자바스크립트(인터페이스: 접점) -> ajax, XMLHttpRequest, fetch()-비동기처리(콜백)
// fetch(a,b, ()=>{
// }).then((response)=>{JSON.stringify(string - 구조분해할당 안 됨) or parse(배열)})
//
// {} object -> [] Array -> [{},{},{}]((List<Map> or List<VO>))
const user = {
  name: '나신입',
  age: 35,
  email: 'nice@hot.com'
}

const user2 = {
  address: '서울시 마포구 공덕동',
  address2: '인천시'
}
console.log(user2);
const { address2 = '부산시' } = user2;
console.log(user2);
console.log(user2.address2);
console.log(address2);
const {name, age, email, address} = user;
console.log(name, age, email, address);
console.log(user.name);
console.log(user['name']);
console.log(`${user['name']}`);