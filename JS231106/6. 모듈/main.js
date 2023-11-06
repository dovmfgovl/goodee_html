/*****package.json에서 "type": "module", 을 써야 함********/
// {str, fruits, Sonata, hap} - 구조분해할당
import number, {str, fruits, Sonata} from "./module1.js"

console.log(number);
console.log(str);
console.log(fruits);
console.log(fruits.length);
const myCar = new Sonata()
console.log(myCar.speed);
myCar.speedUp() //함수 이름 뒤에 괄호가 있어야 호출
console.log(myCar.carColor);
//자바에서는 전역변수를 반드시 선언하고 this.XX 사용해야 하는데
//JS에서는 생략 가능함(this 바로 사용가능) - 선언없이 this가 붙으면 전역변수임
console.log(myCar.wheelNum);