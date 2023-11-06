// 할당 연산자 (Java의 대입연산자와 같음)
// 재할당 하려면 let으로 선언하시오.

let a = 3;

a = a + 2; //5
a += 2; //7 // 먼저 +하고 대입한다
a *= 3; //21
a %= 3; //0
console.log(a);

// 증감연산자
let b = 2;
console.log(b++); //후위 연산자이니까 먼저 출력 나중에 증가
console.log(b);
console.log(--b); //출력하기 전 먼저 1 뺀다
console.log(b); //앞에서 이미 뺄셈을 했으니까 b를 출력하면 앞에서 출력된 값과 같다

console.log(1+2);
console.log(1-2);
console.log(1*2);
console.log(1/2); //정수 나누기 정수가 실수가 나온다. 자바와 다른 점 - 자바코드였다면 0 출력
console.log(1%2); //몫은 0이고 나머지는 1이다. - 분모보다 작으니까