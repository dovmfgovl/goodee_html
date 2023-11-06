//function a(){}

const a = () => {
  console.log('A');
}

const b = (c) => {
  console.log(c); //함수일까 아니면 값일까
  c()
}
//JS에서는 함수도 객체로 취급하기도 하니 함수 호출할 때 파라미터 자리에 쓸 수 있다
b(a) //b 함수를 호출할 때 파라미터로 함수 a를 넘길 수 있다