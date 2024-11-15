import { AppBar } from "../../../components/AppBar"

@Component
export struct Painter {
  @Builder
  title() {
    Text("画板绘制").fontSize('18fp').fontWeight(FontWeight.Bold).margin({ left: 12 })
  }

  @Builder
  backButton() {
    Button() {
      SymbolGlyph($r('sys.symbol.trash')).fontSize(26)
    }
    .width(36).height(36).backgroundColor(Color.Transparent)
  }

  @Builder
  actionsButton() {
    Row() {
      Button() {
        SymbolGlyph($r('sys.symbol.undo')).fontSize(24)
      }
      .width(36).height(36).backgroundColor(Color.Transparent)

      Button() {
        SymbolGlyph($r('sys.symbol.redo')).fontSize(24)
      }
      .width(36).height(36).backgroundColor(Color.Transparent)
    }
  }

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      AppBar({
        titleSlot: this.title,
        tailing: () => {
          this.backButton()
        },
        leading: () => {
          this.actionsButton()
        },
      })
      Canvas(this.context)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#fafafa')
        .onReady(() => this.paint(this.context))
    }
    .width('100%').height('100%')
  }

  paint(canvas: CanvasRenderingContext2D) {
    // let strokeWidth = 10;
    // canvas.fillRect(100, 100, strokeWidth, strokeWidth)
    // canvas.fillRect(100, 150, strokeWidth, strokeWidth)
    // canvas.fillRect(150, 150, strokeWidth, strokeWidth)
    // canvas.fillRect(200, 100, strokeWidth, strokeWidth)
    // this.drawLine1(canvas);
    // this.drawLine2(canvas);

    // let region = new Path2D();
    // region.arc(100, 100, 50, 0, 2*Math.PI);
    // canvas.fill(region)
    //
    // canvas.translate(120,0)
    // canvas.stroke(region)

    // let region = new Path2D();
    // region.rect(100, 100, 80, 60);
    // canvas.fill(region)
    //
    // canvas.translate(120,0)
    // canvas.stroke(region)

    // this.roundedRect(canvas,100, 100, 80, 60,8);
    // canvas.stroke()
    // canvas.translate(120, 0)
    // canvas.fill()
    //

    let region = new Path2D();
    region.ellipse(120, 450, 80, 120, 0, Math.PI * 0, Math.PI * 2)
    canvas.fill(region)
    canvas.translate(0, -260)

    canvas.lineWidth = 5;

    canvas.stroke(region)

    // let region = new Path2D();
    // region.rect(100, 100, 80, 60);
    // canvas.fill(region)
    //
    // canvas.translate(120, 0)
    // canvas.stroke(region)

    // this.drawLine3(canvas);
  }

  // 绘制圆角矩形的函数
  roundedRect(ctx: CanvasRenderingContext2D, x: number, y: number, width: number, height: number, radius: number) {
    ctx.beginPath();
    ctx.moveTo(x + radius, y); // 移动到左上角圆角的起始点
    ctx.lineTo(x + width - radius, y); // 绘制上边直线
    ctx.arcTo(x + width, y, x + width, y + height, radius); // 绘制右上角圆角
    ctx.lineTo(x + width, y + height - radius); // 绘制右边直线
    ctx.arcTo(x + width, y + height, x + width - radius, y + height, radius); // 绘制右下角圆角
    ctx.lineTo(x + radius, y + height); // 绘制下边直线
    ctx.arcTo(x, y + height, x, y + height - radius, radius); // 绘制左下角圆角
    ctx.lineTo(x, y + radius); // 绘制左边直线
    ctx.arcTo(x, y, x + radius, y, radius); // 绘制左上角圆角
    ctx.closePath();
  }

  drawLine1(canvas: CanvasRenderingContext2D) {
    canvas.lineWidth = 10;
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(0, 100)
    canvas.lineWidth = 5;
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(0, 100)
    canvas.lineWidth = 1;
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();
  }

  drawLine2(canvas: CanvasRenderingContext2D) {
    canvas.lineWidth = 10;
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(0, 100);
    canvas.strokeStyle = '#f64135';
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(0, 100);
    canvas.beginPath();
    canvas.strokeStyle = '#2097f1';

    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();
  }

  //"butt" | "round" | "square"
  drawLine3(canvas: CanvasRenderingContext2D) {
    canvas.lineWidth = 10;
    canvas.lineCap = 'square';
    canvas.beginPath();
    canvas.translate(-70, 0);
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(120, 0);
    canvas.lineCap = 'butt';
    canvas.strokeStyle = '#f64135';
    canvas.beginPath();
    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();

    canvas.translate(120, 0);
    canvas.lineCap = 'round';
    canvas.strokeStyle = '#2097f1';

    canvas.beginPath();

    canvas.moveTo(100, 100);
    canvas.lineTo(100, 150);
    canvas.lineTo(150, 150);
    canvas.lineTo(200, 100);
    canvas.stroke();
  }
}