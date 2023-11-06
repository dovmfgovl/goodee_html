//함수는 하나의 데이터이다.
const getNumber = function(){
  return 123;
}
const getNumber2 = () => {
  return 5;
}

console.log(typeof getNumber);//function 출력
console.log(typeof getNumber()); //함수 호출 //number 출력
console.log(typeof getNumber2()); //함수 호출 //number 출력