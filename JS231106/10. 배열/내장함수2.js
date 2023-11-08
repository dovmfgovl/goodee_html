/*
sort() : 알파벳순으로 요소 정렬
      reverse() :  역순으로 요소 정렬
      sort((a,b) => {return a-b}) : 올림차순으로 정렬
      sort((a,b) => {return b-a}) : 내림차순으로 정렬
      sort((a,b) => {return a-b})[0] : 최소값 반환
      sort((a,b) => {return b-a})[0] : 최대값 반환
*/
const names = ["나신입", "나일등", "김자바"];
console.log(names.sort());

const nums = [5, 11, 3, 1, 25];

nums.sort(function(a,b){
  return a - b;
})
nums.sort((a,b) => a - b)

console.log(nums);