// Object Initailizer(객체초기자)
//https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Object_initializer
//key와 value가 동일할 때는 생략 가능하다.

const object1 = { a: 'foo', b: 42, c: {} };

console.log(object1.a);
// Expected output: "foo"

const a = 'foo';
const b = 42;
const c = {};
// const object2 = { a: a, b: b, c: c };
const object2 = { a, b, c }; //앞에 오는 이름과 뒤에 오는 이름이 같을때는 뒤를 생략할 수 있다
console.log(object2);

// Expected output: 42
console.log(object2.b);

const object3 = { a, b, c };

// Expected output: "foo"
console.log(object3.a);