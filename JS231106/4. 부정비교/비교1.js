//비교

const a = 1
const b = 2
const c = '2'

console.log(a == b);
console.log(a != b);

//일치

console.log(a === b);
console.log(b == c);
console.log(b === c); // = 이 3개면 타입까지도 같은지 비교 //false

//불일치

console.log(b !== c);

console.log(a > b);
console.log(a <= b); //작거나 같니? 합집합 - 둘 중 하나만 맞아도 참