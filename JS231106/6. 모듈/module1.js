// 기본으로 내보내기
// default 키워드는 한 번만 사용 가능함 - 주의!
export default 123

export const str = 'hello'
export const fruits = ['🍎', '🍓', '🫐']

export const hap = (i, j) => {
  return i + j;
}

export class Sonata {
  constructor(){
    this.wheelNum = 4;
    this.speed = 30;
  }
  speedUp = () => {
    this.speed = this.speed + 1;
  }
}