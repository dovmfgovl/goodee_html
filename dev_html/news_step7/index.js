const ajax = new XMLHttpRequest();
const TITLE_URL = 'https://api.hnpwa.com/v0/news/1.json'; //목록 - hashchange - 관찰
const container = document.getElementById('root');
const content = document.createElement('div');
//#38074701 - substring(1) -> 38074701
// + 오늘은 페이지 처리까지 - 이전, 현재, 다음 페이지에 대한 정보가 필요함 그래서
//상세페이지 - 구분 - show(url에 얘를 붙인다)
//목록페이지 - 구분 - page(url에 얘를 붙인다)
//http://localhost:1234/#38105839 -> substring(1)
//페이지 번호가 계속 바뀐다 - 상태 - 잘한다(쿠키, 세션 - 리덕스)
//http://localhost:1234/#page/1 -> substring(7) -> 1페이지 번호 취득
//http://localhost:1234/#page/2 -> 2
//http://localhost:1234/#page/3
//http://localhost:1234/#show/1
//http://localhost:1234/#show/2
const CONTENT_URL = 'https://api.hnpwa.com/v0/item/@id.json'; //hashchange - id값 -> 오늘은 페이지 번호도

//페이징 처리를 위해 필요한 상태값을 관리하는 객체(VO 느낌) /store: 리액트에서 상태관리 할 때 사용하는 키워드(뭘 써도 상관X)
const store = {
  currentPage: 1, //현재 바라보는 페이지
  totalRecord: 47,
};

getData = (url) => {
  ajax.open('GET', url, false);
  ajax.send();
  return JSON.parse(ajax.response);
};

//뉴스목록을 가져오는 함수 구현
//글 내용을 보려면 글 목록 화면에서 제목을 클릭했을 때(a태그가 발동되었을 때)
//상세화면으로 간다(라우팅 -> router 함수로 정의 -> router 함수 내 조건이 3가지이고 -> 그 중 3번째에 해당).
getNewsData = () => {
  const newsData = getData(TITLE_URL);
  const newsList = [];
  newsList.push('<ul>');
  for (let i = (store.currentPage - 1) * 10; i < store.currentPage * 10; i++) { 
    //a(anchor: 앵커) - 상세보기(글 내용보기로 간다) - #/show
    // -> localhost:1234/#/show/2     XXX.substring(7) - Number('2') //#부터 시작 => 자바의 Integer.parseInt()와 같은 역할(문자를 숫자로 바꿔줌)
    newsList.push(`
      <li>
        <a href = "#/show/${newsData[i].id}"> 
          ${newsData[i].title}(${newsData[i].comments_count})
        </a>
      </li>
    `);
  } //end of for
  newsList.push('</ul>');

  //이전으로, 다음으로 버튼 만듦/ div : 밑에 붙이고  싶으니까
  newsList.push(`
    <div>
      <a href = "#/page/${
        store.currentPage > 1 ? store.currentPage - 1 : 1
      }">이전페이지</a>
      <a href = "#/page/${
        store.currentPage < 3 ? store.currentPage + 1 : 3
      }">다음페이지</a>
    </div>
  `);

  container.innerHTML = newsList.join('');
}; //end of getNewsData()

newsDetail = () => {
  //localhost:1234/#3808856 -> routerPath.substring(1) #은 잘라내고 그 다음 숫자만 가져옴
  //localhost:1234/#/page/1 -> /page/1
  //localhost:1234/#/show/1 -> /show/1
  /* 
    newsDetail은 id를 추출하는게 show,page단어가 추가되어 있어서 1을 7로 바꾸어주자
    다음 페이지 2번째 페이지를 보고 내용을 보면 잘 나온다
    다시 목록으로 돌아가면 목록이 잘 나오는 걸 볼 수 있다
    하지만 목록 보기로 왔을 때 정확히 몇번째 페이지인지 애매하다
    왜냐면 바로 #으로 나왔기 때문에 그렇다
    #으로 나오면 라우터 쪽에선 어떻게 동작할까? 라우터에 아무것도 없는 상태로 나올 것이다
    그리고 getNewsData()로 바로 호출한다. 그럼 getNewsData함수로 가면 현재의 페이지
    상태로 보이긴 할것이다
    왜냐면 currentPage를 바꾸고 난 다음에 목록으로 돌아갔다가 다시 뒤로 돌아오니까
    하지만 url기준으로는 몇 페이지인지 알수 없는 상황이니까
    일관된 동작을 위해서 목록 화면에서 넘어갈때 즉 바로 # 으로 가지 않고 
    현재 currentPage를 알고 있으니까 이러한 용도로 우리가 store라고 하는 상태를 
    #으로 가지않고 여기다가 page를 넘겨주도록 합시다 - 81라인에 대한 설명입니다.참고하세요!!!
  */
  const id = location.hash.substring(7);
  const ncontent = getData(CONTENT_URL.replace('@id', id));
  container.innerHTML = `
  <h1>${ncontent.title}</h1>
  <div><a href='#/page/${store.currentPage}'>목록으로</a></div>
  `;
}; //end of newsDetail
/*
  라우터 관점에서는 글 내용에 대한 해시인지 글 목록을 보는 해시인지에 대한
  구분이 필요할 것이다.
  현재는 구분할 수 없는 상태이고 뭔가를 구분하는 구조를 만들어야 하니까
  이런 방식으로 해결해본다.
  최초 실행하면 화면에 아무것도 보이지 않는다.
  getNewsData()를 호출하는 코드가 없어서.
  그래서 라우터를 구현하여 getNewsData()를 호출할 수 있도록 한다.
  그런데 newsDetail이 hashchange에 걸려있다
  그래서 해시가 바뀌면 무조건 글 내용을 보는거야 라고 구현되어 있는 것이다.
  해시가 바뀌면 글 내용을 볼 수도 있고 글 목록을 볼 수도 있어야하니까
  그래서 이 hashchange가 일어났을 때 동작하는 함수를 기존 newsDetail이 아닌
  라우터한테 주면 라우터가 해시가 바뀔 때마다 동작하게 되고 그럼 그 라우터
  안에서 어떤 해시냐에 따라 글 목록을 보여줄 때도 있고 글 내용을 보여주기도 하는 것
*/
router = () => {
  //실제로 목록을 누르면 http://localhost:61394/# 을 갖는데
  //location.hash에 #만 있으면 빈 값을 반환함
  const routerPath = location.hash;
  // == 두 개면 값만 비교 / === 타입까지 같은지 체크(js는 3개까지 존재함)
  if (routerPath === '') {
    //http://localhost:1234/# //#만 있으면 빈 문자열을 반환함 //처음 열었을 때 보이는 뉴스목록은 여기를 탐
    getNewsData(); //글 목록 보기
  }
  //routerPath 앞단에 page가 들어가 있으면 이건 페이징이다. 글 내용을 보는게 아니고
  //그래서 routerPath라고 하는 문자열 안에 이런 문자열이 있는지 찾는 메소드가 있는데
  //indexOf가 그것이다. 이 메소드는 입력으로 주어진 문자열을 찾아서 있다면 0이상의
  //위치값을 리턴하게 되어 있고 없다면 -1을 반환하는 함수이다.
  //-1즉 0보다 작은 값이면 입력으로 주어진 문자열이 없다는 뜻이 된다
  // -> #/page/ 이런 형태로 들어와 있을 때 이게 0보다 크면 page라고 하는
  //해시변경이라는 걸 확인할 수 있다.
  else if (routerPath.indexOf('#/page/') >= 0) { //#/page/ 문자열이 >=0(=-1) 없으면 넘어가라
    /*
      currentpage에 2페이지, 3페이지 이렇게 들어가 있겠지! 페이지 뒤에 숫자값을 넣으면 되고요
      그런데 우리는 아직 추출하지 않았으니까 상수로 2를 주어 일단 동작을 확인해보자
    */
    store.currentPage = Number(routerPath.substring(7)); //전역변수의 값을 변경해둔다. 다른 함수에서도 그 값을 공유한다.
    getNewsData(); //글 내용 보기
  }
  // 현재 페이지를 바꿔주고 새로운 페이지 값으로 그리고 getNewsData 게시글 함수를
  // 다시 한 번 호출하면 됨. 게시글 함수(getNewsData)는 현재 페이지 정보(store.currentPage = Number(routerPath.substring(7)))를 가지고 리스트를 뿌리는
  // 코드가 들어가게 됨.
  // -> #/show/ 의 경우
  else { // #/page/ 말고 선언한 건 #/show/뿐. 즉, else if(routerPath.indexOf('#/page/')) 과 같은 의미
    newsDetail(); //글 내용 보기 - window.addEventListener('hashchange', function(){})
  }
};
// JS에서는 함수가 곧 객체. 주소번지 갖고 있다. 그러므로 아래에서 newsDetail(), router() 괄호 붙일 필요없다.
window.addEventListener('hashchange', router); // 두 번째 파라미터에서 라우팅을 위한 함수 호출
router(); // 전처리 과정
