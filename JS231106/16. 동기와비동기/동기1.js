// Javascript is synchronous 
// 동기코드가 무엇인가?
// 자바스크립트에서는 반환타입을 선언하는 자리가 없다

const func = (x) => {//x=98 copy by value
  return x+2;//100
}

const x = func(98);//
const y = x;//