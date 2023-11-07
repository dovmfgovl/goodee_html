// 객체를 쉽게 만드는 템플릿
// 고전적 방법 - 생성자 함수라고 함
// 클래스 - ES6
class Fruit { // 리액트 활용되다가 훅으로 지원함 - 클래스 사용빈도 좀 줄어듦 - this 불분명한 부분 - 신입에겐 폭탄
  constructor(name, emoji){
    this.name = name;
    this.emoji = emoji;
  }
  // 함수 선언 시 function 예약어 사용불가함
  display = () => {
    console.log(`${this.name} : ${this.emoji}`);
  }
}//end of Fruit
//kiwi는 Fruit 클래스의 인스턴스 변수
const kiwi = new Fruit('kiwi', '🍎');
const tomato = new Fruit('tomato', '🍓')

console.log(kiwi);
console.log(kiwi['name']);
console.log(kiwi.name);
tomato.display();
kiwi.display();