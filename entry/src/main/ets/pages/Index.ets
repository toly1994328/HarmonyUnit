import { CounterPage } from "./CounterPage";
import { GuessingPage } from './guessing/view/GuessingPage';

@Entry
@Component
struct Index {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;

  build() {
    Column() {
      // CounterPage()
      GuessingPage()
    }.padding({ bottom: px2vp(this.bottomRectHeight) })

  }
}
