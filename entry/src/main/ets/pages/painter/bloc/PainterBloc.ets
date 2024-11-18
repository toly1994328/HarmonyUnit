import { Line, Point } from '../model/Line';

export class PainterBloc {
  @Track lines: Line[] = []; // 线列表

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  @Track context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  // 开始平移时，添加新线
  newLine(x: number, y: number) {
    this.lines.push(new Line([new Point(x, y)]));
  }

  // 平移更新时，为新线添加点
  updateLine(x: number, y: number) {
    this.lines[this.lines.length-1].points.push(new Point(x, y));
    this.paint(this.context);
  }

  clear(): void {
    this.lines = [];
    this.paint(this.context);
  }

  paint(canvas: CanvasRenderingContext2D) {
    canvas.clearRect(0, 0, this.context.width, this.context.height);
    for (let i = 0; i < this.lines.length; i++) {
      let cur = this.lines[i];
      this.drawLine(canvas, cur);
    }
  }

  ///根据点集绘制线
  drawLine(canvas: CanvasRenderingContext2D, line: Line) {
    canvas.fillStyle = line.color;
    canvas.lineWidth = line.strokeWidth;
    canvas.beginPath();
    let count = line.points.length;
    if (count == 1) {
      return;
    }
    let first = line.points[0];
    canvas.moveTo(first.x, first.y);
    for (let i = 1; i < count; i++) {
      let cur = line.points[i];
      canvas.lineTo(cur.x, cur.y);
    }
    canvas.stroke();
  }
}