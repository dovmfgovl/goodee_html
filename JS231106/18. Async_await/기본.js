// Async, Await
// then함수를 쓰려면 Promise여야 한다. - then은 Promise 프로토타입이 제공하는 함숫이다.
// 여기서 프로토타입에 대한 정의는 뭘까?
// 어떤 객체에 대해서도 재사용이 가능한 객체인 것

// fetch함수는 BOM이라서 REPL실행이 불가하다
// console.log(fetch("http://www.omdbapi.com/?s=frozen&apikey=4220d5ea&page=2"));

// 실습 코드 작성 목적
//  코드 a는 1초 후에 실행되는 비동기 코드이다. - 코드 파악
//  그렇게 만들어진(내 안에 setTimeout) 비동기 코드가 실행되고 나서 b함수에 실행을 보장 받으려면
// then이라는 prototype 메소드를 사용해서 내용을 작성할 수 있다

const a = () => {
  return new Promise(resolve => {
    setTimeout(()=>{
      console.log(1);
      resolve()
    }, 1000)
  })
}

const b = () => console.log(2);

a().then(()=>b());
// Cannot read properties of undefined (reading 'then')
// 왜냐하면 a는 리턴타입이 Promise 인스턴스라서 Promise.prototype.then()을 호출할 수 있다.
// 이에 반해 b는 달랑 출력하는 문이 전부이다. = Promise 인스턴스를 갖지 못했다.
//b().then(()=>a());