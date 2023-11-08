/*
모든 업무(처리)에는 순서가 있다
입력 -> 처리 -> 출력
순서대로

콜백함수 - 함수 파라미터 자리에 들어가는 함수 - prototype
용도 : 반드시 순서가 지켜져야만 하는 경우에 사용하자
*/
first = (param) => {
  console.log('1');
  param();
}

second = () => {
  console.log('2');
}

first(second);