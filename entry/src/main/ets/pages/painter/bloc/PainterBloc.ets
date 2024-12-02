import { Line, Point } from '../model/Line';

export class PainterBloc {
  // 支持的线粗
  @Track supportStorkWidths: number[] = [1, 2, 4, 6, 8, 10];
  @Track supportColors: string[] =
    ['#ff000000', '#fff44336', '#ffff9800', '#ffffeb3b', '#ff4caf50', '#ff2196f3', '#ff3f51b5', '#ff9c27b0',
      '#ffe91e63',
      '#ff9e9e9e', '#ffff5252', '#ffffab40', '#ffffff00', '#ff69f0ae', '#ff448aff', '#ff536dfe', '#ffe040fb',
      '#ffff4081',
      '#889e9e9e', '#88ff5252', '#88ffab40', '#88ffff00', '#8869f0ae', '#88448aff', '#88536dfe', '#88e040fb',
      '#88ff4081',
      '#449e9e9e', '#44ff5252', '#44ffab40', '#44ffff00', '#4469f0ae', '#44448aff', '#44536dfe', '#44e040fb',
      '#44ff4081',
    ];
  @Track colorIndex: number = 0;
  @Track storkWidthIndex: number = 0;
  @Track lines: Line[] = []; // 线列表

  @Track lineCount = 0;
  @Track historyLineCount = 0;
  @Track historyLines: Line[] = []; //回退历史线列表

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  @Track context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  back(): void {
    let line = this.lines.pop()
    if (line) {
      this.historyLines.push(line);
      this.updateCount();
    }
    this.paint(this.context);
  }

  private updateCount(){
    this.lineCount = this.lines.length;
    this.historyLineCount = this.historyLines.length;
  }

  revocation(): void {
    let line = this.historyLines.pop()
    if (line) {
      this.lines.push(line);
      this.updateCount();
    }
    this.paint(this.context);
  }


  currentColor(): string {
    return this.supportColors[this.colorIndex]
  }

  currentStorkWidths(): number {
    return this.supportStorkWidths[this.storkWidthIndex]
  }

  changeStorkWidths(index: number) {
    this.storkWidthIndex = index
  }

  changeColor(index: number) {
    this.colorIndex = index
  }

  // 开始平移时，添加新线
  newLine(x: number, y: number) {
    let currentColor = this.supportColors[this.colorIndex];
    let currentStorkWidths = this.supportStorkWidths[this.storkWidthIndex];
    this.lines.push(new Line([new Point(x, y)], currentColor, currentStorkWidths));
    this.lineCount++;
  }

  // 平移更新时，为新线添加点
  updateLine(x: number, y: number) {
    this.lines[this.lines.length-1].points.push(new Point(x, y));
    this.paint(this.context);
  }

  clear(): void {
    this.lines = [];
    this.historyLines = [];
    this.updateCount();
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
    canvas.strokeStyle = line.color;
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