// OMDB - API 활용 실습

const movieList = (movieTitle) => {
  return new Promise(resolve => {
    fetch(`http://www.omdbapi.com/?s=${movieTitle}&apikey=4220d5ea`)
      .then(response => response.json())
      .then(response => {
        console.log(response);
        resolve();
    })
  })
}

//주의사항
// 1. async와 await는 커플. 한 쌍임.
// 2. console.log 앞에는 await을 사용할 수 없다
//    왜냐하면 콘솔로그는 Promise 인스턴스를 반환하지 않으니까.. 그래서 안된다
// 3. async 붙이는 자리는 콜백함수 자리이다.
//    Promise 사용한 구문을 async와 await로 변경하기 위해서는
//    await을 감싸는 함수를 선언할 것.

const wrapping = async () => {
  await movieList('avatar')
  //await console.log('아바타'); //사용할 수 없다
  console.log('아바타');
  await movieList('avengers')
  console.log('어벤져스');
  await movieList('frozen')
  console.log('겨울왕국');
}
//주의 - 함수 호출하기
wrapping();

//테스트 할 때 주의사항 - fetch 함수는 BOM API라서 REPL로는 확인 불가함
//그러니 html문서를 통해서 실행할 것 