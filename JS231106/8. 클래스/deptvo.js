//복습 안해도 되는 예제. export만 복습
//아래 예제는 자바를 흉내냈을 때 되는지 해보는 정도~
export class DeptVO{
  constructor(deptno, dname, loc) {
    this.deptno = deptno;
    this.dname = dname;
    this.loc = loc;
  }
  get getDeptno(){
    return this.deptno;
  }
  set setDeptno(value){
    this.deptno = value;
  }
  get getDname(){
    return this.dname;
  }
  set setDname(value){
    this.dname = value;
  }
  get getLoc(){
    return this.loc;
  }
  set setLoc(value){
    this.loc = value;
  }
}