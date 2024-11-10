import { MeritRecord } from "../model/MeritRecord";

@Component
export struct AnimaValue {
  @Prop @Watch('startAnimation') record?: MeritRecord | null;
  @State rate: number = 0;

  build() {
    Text(`功德 +${this.record?.value ?? 0}`)
      .fontSize(8 + this.rate * 8)
      .translate({ y: -60 - this.rate * 64 })
      .opacity(this.rate * 0.7)
  }

  startAnimation(): void {
    this.rate = 0;
    let param: AnimateParam = {
      curve: Curve.LinearOutSlowIn, duration: 400, onFinish: () => this.reset()
    };
    this.getUIContext()?.animateTo(param, () => this.onEvent());
  }

  onEvent(): void {
    this.rate = 1;
  }

  reset(): void {
    this.rate = 0;
  }
}