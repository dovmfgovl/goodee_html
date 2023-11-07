// 주의사항
// 불변성 Immutability
// 파라미터로 참조형을 받을 수 있다 - 원시형은 해당없다
// 원시값 - 값에 의한 복사
// 객체값 - 참조에 의한 복사(메모리 복제됨 - 불변성 - 원본도 바뀐다) - 부수효과(side effect)
// JS에서는 선언 시 타입을 쓰지 않음 - 언제 타입 결정되죠? - 런타임시 결정
function funcA(num){
  num = 5;
  console.log(num);
}
// 원시형인 경우 함수 내부에서 상태를 변경하더라도 외부에 영향 없다
const value = 3;
funcA(value)
console.log(value);

// 대조군
const fruit = { name: '🍓'}

function funcB(obj){
  obj.name = '🍎';
  console.log(obj);
}

funcB(fruit)
console.log(fruit);