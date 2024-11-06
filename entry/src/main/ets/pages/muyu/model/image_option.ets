export class ImageOption {
  name: string = ''; // 名称
  src: ResourceStr = ''; // 资源
  min: number = 0; // 每次点击时功德最小值
  max: number = 0; // 每次点击时功德最大值

  constructor(name: string, src: ResourceStr, min: number, max: number) {
    this.name = name;
    this.src = src;
    this.min = min;
    this.max = max;
  }
}