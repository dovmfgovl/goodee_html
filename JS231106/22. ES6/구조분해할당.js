//구조분해 할당
//https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment

//Object

const Sonata = {
  carColor: 'black',
  speed: 30
}

const carColor = Sonata.carColor;
console.log(carColor);
const speed = Sonata.speed;
console.log(speed);
{
const {carColor, speed} = Sonata;
console.log(carColor, speed);
}

// 다른 이름으로 정의해서 사용 가능함
{
const {carColor: myColor, speed: mySpeed} = Sonata;
console.log(myColor, mySpeed);
}

//Array
const fruits = ['토마토','키위','사과'];
const first = fruits[0];
const second = fruits[1];
const third = fruits[2];

{
  const [first, second, third] = fruits;
  console.log(first, second, third);
}