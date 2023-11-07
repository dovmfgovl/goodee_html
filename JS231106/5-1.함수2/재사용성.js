let lastName = '나';
let firstName = '신입';
let fullName = `${lastName} ${firstName}`
console.log(fullName);
// console.log(funName);
console.log(funName2('강','감찬'));

lastName = '야';
firstName = '너두';
fullName = `${lastName} ${firstName}`
console.log(fullName);
// 문제제기 - 만일 firstName과 lastName의 순서를 바꿔야 한다면 어떻게 해야 될까?
// 반복되는 일을 줄이기 위해 함수로 만들 수 있다.
// 결론 : 한 곳에서만 수정하면 된다?

// 관전 포인트 하나 더
// arrow function과 아닌 경우 사이에 차이점은?
// function으로 시작한 함수는 위치에 대한 이슈가 없지만
// arrow function은 접근이 불가함

// 함수 - 리턴타입과 파라미터
funName = (firstName, lastName) => {
  return `${firstName} ${lastName}`
}

function funName2 (firstName, lastName) {
  return `${firstName} ${lastName}`
}
funName2(firstName, lastName);

// 함수의 표현식 정리