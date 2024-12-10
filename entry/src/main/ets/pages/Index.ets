import { BottomAppBar, MenuMeta } from '../components/BottomAppBar';
import { CounterPage } from './counter/CounterPage';
import { GuessingPage } from './guessing/view/GuessingPage';
import { MuYuPage } from './muyu/view/MuyuPage';
import { Painter } from './painter/view/Painter';


export const kTabs: MenuMeta[] = [
  {
    title: '计数器',
    icon: $r('app.media.bar_counter'),
  },
  {
    title: '猜数字',
    icon: $r('app.media.bar_guess'),
  },
  {
    title: '电子木鱼',
    icon: $r('app.media.bar_muyu'),
  },
  {
    title: '画板',
    icon: $r('app.media.bar_painter'),
  },
]

@Entry
@Component
struct Index {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  @State currentIndex: number = 0;

  @Builder tabview(){
    Tabs({ index: this.currentIndex }) {
      TabContent() {CounterPage()}
      TabContent() {GuessingPage()}
      TabContent() {MuYuPage()}
      TabContent() {Painter()}
    }.layoutWeight(1)
    .barHeight(0)
    .scrollable(false)
  }

  build() {
    Navigation(this.pageStack) {
      Column() {
        this.tabview()
        BottomAppBar({
          data: kTabs,
          activeIndex: this.currentIndex,
          onSelected: (index) => this.onPageChange(index)
        })
      }
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
    .padding({ bottom: px2vp(this.bottomRectHeight) })
  }

  onPageChange(index: number): void {
    this.currentIndex = index;
  }
}
