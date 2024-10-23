@Entry
@Component
struct Index {
  @State counter: number = 0;

  increment(): void {
    this.counter++;
  }

  @Builder
  tailing() {
    Button(){
      Image($r('app.media.more'))
        .width(24).height(24)
        .fillColor(Color.White)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  leading() {
    Button(){
      Image($r('app.media.logo')).width(30).height(30)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
  }

  build() {
    Stack() {
      Column() {
        AppBar({ title: $r('app.string.counter_title'), leading: this.leading, tailing: this.tailing })
        Column() {
          Text($r('app.string.counter_tips'))
            .fontSize($r('app.float.counter_desc_size'))
          Text(this.counter.toString())
            .fontSize($r('app.float.counter_value_size'))
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
      .backgroundColor($r('app.color.theme_color'))
      .onClick(() => this.counter++)
    }.alignContent(Alignment.BottomEnd)

  }
}

@Component
struct AppBar {
  private title: string | Resource = '';

  @Builder
  leadingBuilder() {
  }

  @Builder
  tailingBuilder() {
  }

  @BuilderParam leading: () => void = this.leadingBuilder;
  @BuilderParam tailing: () => void = this.tailingBuilder;

  build() {
    Row() {
      this.leading()
      Text(this.title)
        .fontSize($r('app.float.app_bar_title_size')).fontWeight(FontWeight.Bold)
        .fontColor($r('sys.color.white'))
      this.tailing()
    }
    .backgroundColor($r('app.color.theme_color'))
    .width('100%')
    .height(56)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
