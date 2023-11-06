// null : 값이 존재하지 않는다
let age = null;
console.log(age);
//3초 후에 함수가 실행된다.
//setTimeout 함수 - 시간관리함 - 타임라인 변경할 때 사용함 - 기억!
setTimeout(function(){
  age = 80;
  console.log(age);
}, 3000) // setTimeout 함수 2번째 파라미터에 ms만큼 시간 적으면 `3`초 후에 80 찍힘