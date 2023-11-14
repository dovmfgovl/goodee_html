// Resolve, Reject 흉내내기
// 아래 함수 내부에서 fetch를 통해 스프링 서버에게 요청할 수 있다.
// SELECT deptno, dname, loc FROM 부서집합 WHERE deptno=10 or dname='Sales'
// resolve(res) - resolve에 태워진 저 데이터셋은 어디로 가는걸까?
// 화면{html}으로 가서 출력하는데 데이터값으로 존재함 - 연결
// resolve함수에 태워진 데이터셋이 반환됨 - <td>데이터<td>
const validFunc = (index) => { //index가 {} -> DeptVO이거나 Map이 치환되어야 함 - 파라미터
  return new Promise((resolve, reject) => {
    //fetch오는 자리 - url값이다. - 172.16.2.3:8000/dept/getDeptList.jsp
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

validFunc(15)//
  .then(res => console.log(res))
  .catch(err => console.error(err))
