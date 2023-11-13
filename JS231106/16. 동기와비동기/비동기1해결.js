//JS는 동기적이다.
//Execute the code block by order after hoisting
//hoisting : var, function declaration
//아래 코드는 비동기 예제였다
//함수도 호이스팅이다. 
const hap = (a,b, cback) => {
  setTimeout(()=>{
    //return, 실행문 - 제어문
    cback(a+b);
    console.log(`hap ${cback(a+b)}`);
  }, 1000) // 1초 간의 지연이 발생함
}
//함수 hap 세번째 인자에 들어갈 콜백함수 선언함
const first = (x) => {
  console.log(`firrst x : ${x}`);
  return x + 1;
}

const x = hap(1, 2, first);
console.log(`x : ${x}`);
const y = x;
console.log(`y : ${y}`);