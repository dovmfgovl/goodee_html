// Default parameters(기본값 매개변수)
//https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Functions/Default_parameters

const msgPrint = (msg) => {
  if(msg == null){
    msg = 'default message';
  }
  console.log(msg);
}

msgPrint('hello');
msgPrint()

{
const msgPrint = (msg = 'default message') => {
  console.log(msg);
}

msgPrint('hello');
msgPrint()
}