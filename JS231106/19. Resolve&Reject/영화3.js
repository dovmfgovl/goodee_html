// OMDB - API 활용 실습
// Promise에서 에러 핸들링하는 방법
// fetch가 BOM 제공하는 API라서 반드시 브라우저를 통해 확인해본다.

const movieList = (movieTitle) => {
  return new Promise((resolve, reject) => {
    fetch(`http://www.omdbapi.com/?apikey=4220d5ea&s=${movieTitle}`)
      .then(res => res.json())
      .then(json => {
        console.log(json.Response);
        if(json.Response === 'False'){
          //아래가 호출되면 catch로 간다
          //.앞에는 누가 있는걸까? - then으로 간다면 Promise가 있다
          //Promise가 쥐고 있는 함수 - catch
          //.catch 반환타입도 Promise 인스턴스이다. 그러니까 finally가 호출되었겠지
          reject(json.Error) //18번으로 간다
      }
      resolve(json)
    })
    .catch(error => {
      reject(error);
    })
    .finally(() => {
      console.log('무조건 호출');
    })
  }) //end of Promise
} //end of movieList

movieList('avatar')
  .then(movies => console.log(movies))
  .catch(error => console.log(error))
  .finally(() => loading = false)