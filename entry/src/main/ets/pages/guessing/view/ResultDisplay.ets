import { CheckResult, resultColor, resultLabel } from "../model/CheckResult";

@Component
export struct ResultDisplay {
  @Prop result: CheckResult = CheckResult.none;
  @Prop @Watch('onGuessCountChange') guessCount: number = 0;
  @State fontSize: number = 14;

  build() {
    Column() {
      Text(resultLabel(this.result))
        .fontSize(this.fontSize)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .layoutWeight(1)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(resultColor(this.result))
  }

  onGuessCountChange(propName: string): void {
    this.fontSize = 14;
    this.startAnimation();
  }

  startAnimation(): void {
    let param: AnimateParam = { curve: Curve.EaseIn, duration: 500 };
    this.getUIContext()?.animateTo(param, () => this.onEvent());
  }

  onEvent(): void {
    this.fontSize = 42;
  }
}