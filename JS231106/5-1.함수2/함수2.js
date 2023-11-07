// JS에서 함수는 객체이다
// JS에서는 리턴타입을 선언하는 자리가 없다.
// return을 쓰지 않으면 undefined 반환됨 - 디폴트!
add = (a,b) => {
  return a+b;
}

console.log(add); //[Function: add]
console.log(add(1,2));

// JS에서는 함수도 객체니까 치환이 가능한가?
// hap변수가 add의 주소번지와 같은 값을 가리키게 된다
// 함수의 이름은 함수를 참조하고 있다.
// 그러니까 함수도 객체다 - 콜백함수에서 중요한 컨벤션
const hap = add;
console.log(hap == add);
console.log(hap === add);
console.log(typeof hap);
console.log(typeof add);
console.log(hap);

// 확인하기 - 테스트
// JS에서는 파라미터가 달라도 이름이 같으면 호출된다
// 결론 - 같은 이름의 함수를 가질 수 없다 - 메소드 오버로딩 해당없음
console.log(hap()); //NaN(Not a Number)
console.log(hap(1,2))
console.log(hap(1)); //NaN
console.log(hap(1, null)); //1
console.log(hap(1, undefined)); //NaN
console.log(hap(1, {})); // 1
console.log(hap(1, [])); // 1

console.log(typeof {});
console.log(typeof []);

hap1= () => {
  return undefined
}
console.log(hap1);

// 왜?
// 원시형 - 부르면 값이다
// 참조형 - 부르면 주소번지(Heap) - 사이즈 정할 수 없다.
//  왜냐하면 변수(객체, 함수)는 주소값만 가지고 있고(Heap) - 실체는 다른 메모리에 저장됨
//  if(btn_select == btn_all)

// 함수가 곧 객체 -> 일급 함수, 일급 객체
// 리턴타입이 함수이면 - 고차함수
// 콜백함수(리액트, 스프링에서 필요)
// 함수도 할당연산자(=)를 통해 치환 가능