@Entry
@Component
struct Index {
  @State counter: number = 0;

  increment(): void {
    this.counter++;
  }

  build() {
    Stack() {
      Column() {
        Text('计数器')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, left: 20 })
        Column() {
          Text('下面是你点击按钮的次数:')
            .fontSize(18)
          Text(this.counter.toString())
            .fontSize(36)
            .fontColor('#2e3032')
            .margin({ top: 10 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .height('100%')

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.plus'))
          .fontSize(24)
          .fontColor([Color.White])
          .fontWeight(FontWeight.Bold)
      }.width(56).height(56)
      .margin({ right: 20, bottom: 16 })
      .backgroundColor('#317bd4')
      .onClick(() => this.counter++)
    }.alignContent(Alignment.BottomEnd)

  }
}

