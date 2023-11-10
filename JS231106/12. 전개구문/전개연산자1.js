//전개 연산자(Spread Operator)

const fruits = ['🫐', '🍓', '🍎'];
console.log(fruits);

// ... 전개연산자로 읽는다
//문자열이 출력된다
console.log(...fruits);

toObject = (a,b,...c) => {
  return { // ,는 열거형 연산자이다
    a:a, b:b, c:b,
  }
}
toObject2 = (a,b,...c) => {
  //속성의 이름과 데이터의 이름이 같으면 위 말고 아래와 같이 축약형으로 가능하다
  return { // ,는 열거형 연산자이다
    a, b, c,
  }
}

//실행문 안에 다른 코드가 없으면 좀 더 축약할 수 있다.
toObject3 = (a, b, ...c) => ({a, b, c});

console.log(toObject(...fruits));
console.log(toObject2(...fruits));
console.log(toObject3(...fruits));
console.log(fruits[0], fruits[1], fruits[2]);