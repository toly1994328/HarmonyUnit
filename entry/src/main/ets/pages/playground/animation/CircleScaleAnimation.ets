import { curves } from "@kit.ArkUI";

@Component
export struct CircleScaleAnimation {
  @State scaleValue: number = 1;

  build() {
    Shape() {
      Circle({ width: 80, height: 80, }).fill('#317bd4')
    }
    .scale({ x: this.scaleValue, y: this.scaleValue })
    .onClick(() => this.run())
  }

  run(): void {
    let param: AnimateParam = { curve: curves.springMotion(), duration: 1000 };
    this.getUIContext()?.animateTo(param, () => this.onEvent())
  }

  onEvent(): void {
    this.scaleValue = this.scaleValue == 1 ? 0.5 : 1;
  }
}