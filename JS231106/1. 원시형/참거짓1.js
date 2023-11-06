// 거짓인 것 6가지
// 1. false
// 2. 0
// 3. null
// 4. undefined
// 5. NaN
// 6. "빈문자열"
if(123){
  console.log('참');
}
if('0'){
  console.log('문자열 0은 참이다.');
}

if(NaN){

}else{
  console.log('NaN도 false이다.');
}
if(null){

}else{
  console.log('null도 false이다.');
}
if(undefined){

}else{
  console.log('undefined도 false이다.');
}
if(' '){
  console.log('띄어쓰기 하면 true이다.');
}else{
  console.log('빈 문자열도 false이다.');
}