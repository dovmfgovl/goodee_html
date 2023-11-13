//Promise prototype 활용하여 비동기처리 해보기

const 상품조회 = () => {
  return new Promise((resolve, reject)=>{
    setTimeout(()=>{
      console.log('상품조회');
      const goods = [{name : '스킨', price : 3000}, {name : '샴푸', price : 4000}]
      resolve(goods);
    }, 1000)
  })
}

const 카트담기 = () => {
  return new Promise((resolve, reject)=>{
    setTimeout(()=>{
      console.log('카트담기');
      const goods = {name : '스킨', name1 : '샴푸', name2 : '비누'};
      resolve(goods);
    }, 3000)
  })
}

const 결제하기 = () => console.log('결제하기');

//상품조회 함수 호출할 때 콜백에서 카트담기 함수를 호출하면 순서가 보장된다.

상품조회()//
  .then((response) => {
    console.log(response);
  return 카트담기();
})
.then((response)=>{
  console.log(response);
  console.log(response.name);
  console.log(response.name1);
  console.log(response.name2);
  return 결제하기();
})