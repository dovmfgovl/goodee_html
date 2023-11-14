// Resolve, Reject 흉내내기

const validFunc = (index) => {
  return new Promise((resolve, reject) => {
    setTimeout(()=>{
      if(index > 10){
        reject(`${index}는 10보다 클 수 없습니다.`);
        return;
      } //end of if
      console.log(index);
      resolve(index+1)
    }, 1000) //end of setTimeout
  })
} //end of validFunc
// 함수의 파라미터가 3개 있는데 
// 조건에 따라서 호출되는 콜백함수를 제어할 수 있다
//insert here
validFunc(5)//
  .then(res => console.log(res))
  .catch(err => console.error(err))
  .finally(() => console.log('처리완료'))

  //학습목표
  // async와 await로 처리할 때 에러처리는 try..catch블록으로 한다.

  const wrapping = async () => {
    try {
      const res = await validFunc(15);
      console.log(res);      
    } catch (error) {
      console.error(error);
    } finally {
      console.log('정상이거나 실패인 경우여도 항상 실행됨');
    }
  }
  wrapping();

