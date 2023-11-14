const keyword = document.querySelector('#keyword'); //이벤트 소스의 주소번지 얻기

//내장함수를 사용해서 keydown 이벤트 처리 - 콜백함수 만남
keyword.addEventListener('keydown', (event) => {
  //사용자가 누른 키보드 아스키코드값 10진수가 출력됨
  console.log(event.keyCode); //78번 - 대문자 N
  //사용자가 입력한 검색어를 찾는 함수 호출 - 자동완성 기능을 흉내내보기
  handleSearch();
})

//썸네일 클릭했을 떄 상세보기 화면처리 
let videoItem;
const videoShow = (id, title, description, channelTitle) => {
  videoItem = `
    <section class="detail">
      <iframe id="player" type="text/html" width="640" height="500"
      src="http://www.youtube.com/embed/${id}"
      frameborder="0"></iframe>    
      <h2>${title}</h2>
      <h3>${channelTitle}</h3>
      <pre class="description">
      ${description}
      </pre>
      <div>
        <a href="./youtube.html">이전페이지</a>
        &nbsp;
        <a href="javascript:search('손흥민')">이전페이지2</a>
      </div>
    </section>
  `;
  document.querySelector("#root").innerHTML = videoItem;
};

//사용자가 입력한 검색어 읽어오기
const handleSearch = () => {
  const user = keyword.value; //사용자가 입력한 글자 얻어오기
  console.log('사용자가 입력한 검색어 ====>' + user);
  //사용자가 입력한 검색어로 조건 검색 구현하기
  search(user);
}

const search = (query) => {
  console.log(`사용자가 입력한 nba를 받아오기 : ` + query);
  // insert here - 검색 결과 가져오는 코드 작성하기

  const ajax = new XMLHttpRequest();
  // AIzaSyBie5qlyMDwHSSyOl0uSH_mRqFecVNNzSc
  const Youtube_URL = `https://www.googleapis.com/youtube/v3/search?part=snippet&key=AIzaSyBie5qlyMDwHSSyOl0uSH_mRqFecVNNzSc&type=video&q=${query}&maxResults=25`;
  ajax.open('GET', Youtube_URL, false);
  ajax.send(); //send() 호출될 때 비로소 서버측에 요청이 일어남 - 0번에서 출발함 - 1번(전화옴) - 2번(기사가 물건 가져감) - 3번(이동) - 4번(물건 도착)

  //1-2 학습목표 : 배열을 사용하여 템플릿을 구성해 본다
  const videoList = [];

  //console.log(ajax.response); //Object

  const most = JSON.parse(ajax.response);
  const items = most.items;

  let items2;
  items2 = most.items.map((item) => ({ ...item, id: item.id.videoId }))
  console.log(items);//id:{kind: 'youtube#video', videoId: 'Y-5X4Y0lDbE'}
  console.log(items2);//id:"Y-5X4Y0lDbE"
  console.log(items2.length);//25
  videoList.push( `<ul class="videos">`);
  items2.map((video) => {
      //25번 반복 - 25개의 li
      videoList.push( `<li class="container" onclick="videoShow('${video.id}','${video.snippet.title}','${video.snippet.description}','${video.snippet.channelTitle}')">`);
      videoList.push( `<div class="video">`);
      videoList.push( `<img class="thumbnail" src='${video.snippet.thumbnails.medium.url}'/>`); 
      videoList.push( `<div>`);
      videoList.push( `<p class="title">${video.snippet.title}</p>`);
      videoList.push( `<p class="channelTitle">${video.snippet.channelTitle}</p>`);
      videoList.push( `</div>`);
      videoList.push( `</div>`);
      videoList.push( `</li>`);
  })
  videoList.push( `</ul>`);
  
  document.querySelector('#root').innerHTML = videoList.join('');
}