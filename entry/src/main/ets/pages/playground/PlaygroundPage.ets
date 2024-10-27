import { CircleScaleAnimation } from "./animation/CircleScaleAnimation";

@Component
export struct PlaygroundPage {
  @State scaleValue: number = 1;

  build() {
    Column() {
      CircleScaleAnimation()
    }
    .width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
  }

}