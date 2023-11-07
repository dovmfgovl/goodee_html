// 리턴
// return을 명시적으로 하지 않으면 자동으로 undefined 반환됨

function hap(a,b){
  return undefined
}

console.log(hap(1,2));

// return을 함수 중간에 만나면 함수가 종료됨

function m(num){
  // 파라미터 받은 값에 대한 유효성 여부 체크하는 코드 추가한다.
  if( num<0 ){
    return; // 전달되는 값이 유효한지 여부를 미리 체크해본다.
  }
  console.log(num); // 5만 출력됨
}

m(5)
m(-5) // 17번을 못 본다