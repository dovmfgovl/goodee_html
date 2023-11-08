// forEach(callback function)에 대해서

const fruits = ['🍎', '🍓', '🫐'];

fruits.forEach(element => console.log(element))
fruits.forEach((element, cnt) => console.log(cnt, element))
fruits.forEach((element, cnt, fruits) => console.log(cnt, element, fruits))
fruits.forEach((element, cnt) => {
  console.log(cnt, element)
  document.write(cnt, element)
})

/*
function func(){} //이거말고 arrow function 쓰자 : 함수도 호이스팅 이슈가 있어서

const func = (element, index, array) => {}

hap = () => {}

https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach

callbackFn
배열의 각 요소에 대해 실행할 함수입니다. 반환값은 사용되지 않습니다. 함수는 다음 인수를 사용하여 호출됩니다.

element
배열에서 처리 중인 현재 요소.

index
배열에서 처리 중인 현재 요소의 인덱스.

array
forEach()를 호출한 배열.
*/