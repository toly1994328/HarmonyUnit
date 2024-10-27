import { CounterPage } from "./CounterPage";
import { GuessingPage } from './guessing/view/GuessingPage';
import { PlaygroundPage } from './playground/PlaygroundPage';

@Entry
@Component
struct Index {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;

  build() {
    Column() {
      // CounterPage()
      GuessingPage()
      // PlaygroundPage()
    }.padding({ bottom: px2vp(this.bottomRectHeight) })

  }
}
