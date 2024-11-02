import { AppBar } from '../../../components/AppBar'
import { MuyuBloc } from '../bloc/MuyuBloc';

@Component
export struct MuYuPage {
  @State model: MuyuBloc = new MuyuBloc();

  @Builder
  title() {
    Text("电子木鱼").fontSize('18fp').fontWeight(FontWeight.Bold).margin({ left: 12 })
  }

  aboutToDisappear(): void {
    this.model.release();
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

  toHistory(): void {
  }

  @Builder
  buildButtons() {
    Column() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.music_fill'))
          .fontSize(20)
          .fontColor([Color.White])
          .fontWeight(FontWeight.Bold)
      }.margin({ bottom: 12 }).width(36).height(36).borderRadius(4)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.picture_fill'))
          .fontSize(20)
          .fontColor([Color.White])
          .fontWeight(FontWeight.Bold)
      }.width(36).height(36).borderRadius(4)
    }.position({
      top: 12,
      right: 12
    })
  }

  @Builder
  valueDisplay() {
    Stack() {
      Column() {
        Text(`功德数: ${this.model.counter}`).fontSize('24fp').fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      this.buildButtons()
    }
    .layoutWeight(1)
    .width('100%')
  }

  @Builder
  muyuDisplay() {
    Stack() {
      Column() {
        Image($r('app.media.muyu')).width(200)
          .onClick(() => this.model.tick())
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
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
