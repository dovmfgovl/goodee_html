// 함수 안에 함수 선언이 가능하다. - 일급함수 - 리덕스 -> FLUX 아키텍쳐
// {} - const sonata = {carColor: '검정', speed: 0}
// , 열거형 연산자 -> ES6 스레드연산자
const createStore = () => {
  let state; //상태관리
  let handlers = [];
  // 함수 안에 함수를 또 선언할 수 있다
  const send = () => {
  
  }
  const subscribe = (handler) => { //구독해줘
    handlers.push(handler); //영속성, 유지, 기억해줄게
  }
  return{
    send,
    subscribe,
  }
}

const store = createStore();
console.log(store);

store.subscribe(()=>{
  console.log('subscribe');
});

store.send();