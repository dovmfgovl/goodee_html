/*
모든 업무(처리)에는 순서가 있다
입력 -> 처리 -> 출력
순서대로
*/
first = () => {
  console.log('1');
}

second = () => {
  console.log('2');
}

first();
//first가 지연발생됨
second();