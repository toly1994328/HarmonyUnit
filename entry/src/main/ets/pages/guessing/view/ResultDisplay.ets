import { CheckResult, resultColor, resultLabel } from "../model/CheckResult";

@Component
export struct ResultDisplay {
  @Prop result: CheckResult = CheckResult.none;

  build() {
    Column() {
      Text(resultLabel(this.result))
        .fontSize(24)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .layoutWeight(1)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(resultColor(this.result))
  }
}