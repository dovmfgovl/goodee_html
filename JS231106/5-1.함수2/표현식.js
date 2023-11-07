// 함수 선언문 function name(){}
// 함수 표현식 const name = function(){} - 익명함수(자바: 익명클래스) -  외부에서 사용불가

let hap = function (a,b){
  return a+b;
}

hap = (a,b) => a+b; // return을 생략할 수 있다 - 리액트 자주출몰 - 6.8부터 Hook

console.log(hap(1,2));

// IIFE(Immedicately-Invoked Function Expressions) - 즉시실행함수
(function run(){
  console.log('run'); //run
})(); // (); 얘 자체가 호출

let hap2 = function sum(a,b){
  return a+b;
}
//변수에 함수를 할당하여 표현하는 경우 이름을 지어주어도 외부에서 사용 불가함 - 그러니 쓰지말자
//console.log(sum(1,2));