export class Duck{
  constructor(name, leg){
    this.name = name;
  }
  display = () => {
    console.log(`나는 ${name} 오리 입니다.`);
  }
}