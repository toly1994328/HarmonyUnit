export class Line {
  points: Point[];
  color: string;
  strokeWidth: number;

  constructor(
    points: Point[],
    color: string = '#000000',
    strokeWidth: number =2
  ) {
    this.points = points;
    this.color = color;
    this.strokeWidth = strokeWidth;
  }
}

export class Point {
  readonly x: number = 0;
  readonly y: number = 0;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}