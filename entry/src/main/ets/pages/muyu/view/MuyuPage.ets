import { AppBar } from '../../../components/AppBar'

@Component
export struct MuYuPage {
  @Builder
  title() {
    Text("电子木鱼").fontSize('18fp').fontWeight(FontWeight.Bold).margin({ left: 12 })
  }

  @Builder
  tailing() {
    Button() {
      Image($r('app.media.history')).width(26).height(26).fillColor(Color.Black)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
    .onClick(() => this.toHistory())
  }

  toHistory(): void {}

  @Builder
  valueDisplay(){
    Column() {
      Text('功德数: 0').fontSize('24fp').fontWeight(FontWeight.Bold)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
    .width('100%')
  }

  @Builder
  muyuDisplay(){
    Column() {
      Image($r('app.media.muyu')).width(200)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
  }

  build() {
    Column() {
      AppBar({ titleSlot: this.title, tailing: (): void => this.tailing() }
      ).backgroundColor($r('sys.color.white'))
      this.valueDisplay()
      this.muyuDisplay()
    }.backgroundColor('#fafafa')
  }
}
