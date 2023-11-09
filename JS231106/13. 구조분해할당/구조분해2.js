//배열 -> filter -> 깊은 복사
const words = ['spray', 'elite', 'exuberant', 'destruction', 'present'];
// -> filter는 다른 여러 객체에서도 재사용할 수 있는 prototype
// -> filter 함수는 리턴타입이 배열이다. 그런데 깊은 복사 = 새로운 배열이다 = 두 배열 주소번지가 다르다
const result = words.filter((word) => word.length > 6);
console.log(typeof result); //object
console.log(result.length); //3
words.push('abcdefg');
console.log(words); //['spray', 'elite', 'exuberant', 'destruction', 'present']
console.log(result); //['exuberant', 'destruction', 'present']
// Expected output: Array ["exuberant", "destruction", "present"]
// 구조분해할당 장점: 배열에 대한 초기화를 한 줄로 끝냄 -> react의 props에서 많이 사용
const [r1, r2, r3] = result;
console.log(r1);
console.log(r2);
console.log(r3);