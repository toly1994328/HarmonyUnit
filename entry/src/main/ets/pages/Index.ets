import { CounterPage } from "./CounterPage";

@Entry
@Component
struct Index {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;

  build() {
    Column() {
      CounterPage()
    }.padding({ bottom: px2vp(this.bottomRectHeight) })

  }
}
