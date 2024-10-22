@Entry
@Component
struct Index {
  @State counter: number = 0;

  increment(): void {
    this.counter++;
  }


  @Builder
  tailing() {
    SymbolGlyph($r('sys.symbol.dot_grid_1x2'))
      .fontSize(24)
      .fontColor([Color.White])
      .fontWeight(FontWeight.Bold)
  }

  @Builder
  leading() {
    SymbolGlyph($r('sys.symbol.access_card'))
      .fontSize(24)
      .fontColor([Color.White])
      .fontWeight(FontWeight.Bold)
  }

  build() {
    Stack() {
      Column() {
        AppBar({ title: '计数器', leading: this.leading, tailing: this.tailing })
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
      }
      .width(56)
      .height(56)
      .margin({ right: 20, bottom: 16 })
      .backgroundColor('#317bd4')
      .onClick(() => this.counter++)
    }.alignContent(Alignment.BottomEnd)

  }
}

@Component
struct AppBar {
  private title: string = '';

  @Builder
  leadingBuilder() {}

  @Builder
  tailingBuilder() {}

  @BuilderParam leading: () => void = this.leadingBuilder;
  @BuilderParam tailing: () => void = this.tailingBuilder;

  build() {
    Row() {
      this.leading()
      Text(this.title)
        .fontSize(20).fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.white'))
      this.tailing()
    }
    .backgroundColor('#317bd4')
    .width('100%')
    .height(56)
    .padding({ left: 20, right: 20 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
