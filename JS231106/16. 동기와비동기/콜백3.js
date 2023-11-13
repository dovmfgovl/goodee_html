// 1 2 3을 순서대로 출력하는 문장을 작성해보시오

console.log(1); //첫번째로 1

const second = (cback) => {
  setTimeout(()=>{
    console.log(2); //세번째로 2
    cback()
  }, 2000)
}// end of second

const first = () => {
  console.log(3); //두번째로 3
}