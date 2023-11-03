//비동기 통신 객체를 생성해서 담을 변수 선언
let xhrObject = null; //const 상수선언 - 재정의 불가함 - 따라서 let으로 변경(ECMASript6부터 var 대신 const와 let 사용권장)
//비동기 통신 객체 생성하는 함수 구현
createRequest = () => {
  //서버에 요청 할 수 있는 객체를 생성한다.
  try {
    xhrObject = new XMLHttpRequest();
  } catch (error) {
    console.log(error);
  }
  if (xhrObject == null) {
    alert('비동기 통신 객체 생성 에러');
  }
}; /////////////////// end of createRequest
//어떤 조건(0->1->2->3->4)을 만족하면 시스템이 호출해주는 함수 - 콜백(CallBack) - 비동기처리 - 가중치
//개발자가 지정한 콜백함수를 시스템이 알 수 있도록 추가 코딩이 필요하다
accountProcess = () => {
  console.log(`accountProcess 호출 => ${xhrObject.readyState}`); //0->1->2->3(다운중)->4(완료)
  if (xhrObject.readyState == 4) {
    if (xhrObject.status == 200) {
      //200 - ok 라는 의미(정상적으로 처리했다는)
      //20을 읽어온다 - boardSellAccount.html(백엔드에서는 자바가 할 일 - 추후엔 스프링이 할 일)
      const newTotal = xhrObject.responseText; // 새로 받아온 값을 담음
      console.log(`${newTotal}`); //20 찍히는지 - 관전포인트 -> 프론트와 백엔드가 만나는 접점
      const boardSoldEl = document.querySelector('#boardSold');
      replaceText(boardSoldEl, newTotal); //10 -> 20으로 바뀌는 순간
      //구매가
      const costEl = document.querySelector('#cost');
      let cost = getText(costEl);
      //소비자가
      const priceEl = document.querySelector('#price'); //아이디 사용할 땐 #
      let price = getText(priceEl);
      //보드 한 개당 마진 금액 계산
      let cashPerBoard = price - cost;
      let cash = cashPerBoard * newTotal;
      console.log(`마진금액은 ${cash}`);
      //마진금액을 붙여본다
      const cashEl = document.querySelector(`#cash`);
      replaceText(cashEl, cash);
    }
  }
};
//마진은 버튼을 눌렀을 때 호출
getBoardSold = () => {
  const msg = 'getBoardSold 호출';
  console.log(`${msg}`);
  //비동기객체 생성
  createRequest();
  let url = './boardSellAccount.html';
  //const url = 'http://127.0.0.1:9000/board/boardSellAccount.jsp';
  //집계를 담당하는 페이지 호출
  xhrObject.open('GET', url, true);
  //콜백함수 지정 - readyState가 변할 때 마다 브라우저 호출 - 상태 체크 프로세스
  xhrObject.onreadystatechange = accountProcess; //함수도 객체다! //onreadystatechange(비동기 일때만 사용 가능)
  xhrObject.send();
};
//@param - element - 태그 정보 - 태그 주소번지
getText = (el) => {
  let text = ''; //ES6 ->ECMAScript2015 - 적용안되는 브라우저이면 babel필요하다 또는 번들러 parcel(웹팩-리액트)
  if (el != null) {
    //파라미터로 받아온 element가 널이 아니면 존재하니
    if (el.childNodes) {
      //JS에서는 0이 아닌 것 모두 true이다.
      // el null스킵, undefined, "", NaN
      console.log(el + ', ' + el.childNodes.length); //1 1
      for (let i = 0; i < el.childNodes.length; i++) {
        //el.childNodes.length
        //costEl, priceEl
        //브라우저는 같은 이름이 여러 개이면 자동으로 배열로 전환해준다
        let childNode = el.childNodes[i]; //el.childNodes[0], el.childNodes[1]
        //너 텍스트 노드니?
        if (childNode.nodeValue != null) {
          text = text + childNode.nodeValue;
        }
      }
    }
  }
  return text; //100 120
}
//기존 TextNode의 값을 다른 문자열로 바꾸기
/***********************************************
      param1 :document.getElementById("boardSold")
      param1 :document.querySelector("#boardSold")
      param2 :xhrObject. 
      ************************************************/
replaceText = (el, value) => {
  //el-> boardSoldEl(보드판매량), cashEl(마진)
  if (el != null) {
    //span
    clearText(el); //기존에 있던 10을 지워주세요.
    //새로운 텍스트 노드 15를 생성하기
    var newNode = document.createTextNode(value); //15
    //위에서 생성한 텍스트 노드 값을 el에 붙이는 함수 호출하기
    el.appendChild(newNode); //el boardSoldEl-> <span>10</span> <span id=boardSold or cash></span>  <span>20</span>
  }
}
//기존 태그안에 문자열 지우는 함수 구현
function clearText(el) {
  if (el != null) {
    if (el.childNodes) {
      //자바스크립트에서는 0이 아닌건 모두 참이다
      for (let i = 0; i < el.childNodes.length; i++) {
        let childNode = el.childNodes[i];
        el.removeChild(childNode); //해당 el삭제하기 - DOM API -> 직관적이지 않다-> 유지보수어렵다->쓰기싫다
      }
    }
  }
}
