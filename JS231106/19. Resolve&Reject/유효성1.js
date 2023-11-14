// Resolve, Reject 흉내내기

const validFunc = (index, cb, errorCb) => {
  setTimeout(()=>{
    if(index > 10){
      errorCb(`${index}는 10보다 클 수 없습니다.`);
      return;
    }
    console.log(index);
    cb(index+1)
  }, 1000)
}
// 함수의 파라미터가 3개 있는데 
// 조건에 따라서 호출되는 콜백함수를 제어할 수 있다
//insert here
validFunc(4, res => console.log(res), err => console.log(err));

validFunc(15, res => console.log(res), err => console.log(err));