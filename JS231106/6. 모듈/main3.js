setTimeout(async()=>{
  const temp = await import('./module1.js')
  console.log(temp);
}, 3000)

/*
자바스크립트는 기본적으로 동기인데
만일 꼭 비동기적으로 처리 해야할 때 setTimeout함수 사용
async와 await는 커플. 같이 와야 함.

Front-End : ReactJS, UI솔루션 - 클라이언트 사이드
Back-End : 자바 - 서버 사이드(지연발생됨 - 출처가 다름(CORS 이슈)) - 비동기처리 해야함 - 자바는 비동기 가능함
  그런데 JS는 불가함
http://localhost:9000/dept/getDeptList.jsp
*/