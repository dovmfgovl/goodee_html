// Async, Await

const a = () => {
  return new Promise(resolve => {
    setTimeout(()=>{
      console.log(1);
      resolve()
    }, 1000)
  })
}

const b = () => console.log(2);

// a().then(()=>b()); 1 2


const wrapping = async () => {
  await a(); // 그 뒤에 있는 비동기 함수의 실행을 기다릴게
  b();  
}

wrapping();