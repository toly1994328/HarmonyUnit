import { AppBar } from '../components/AppBar'

@Preview
@Component
export struct GuessingPage {
  @State guessing: boolean = false;

  @Builder
  tailing() {
    Button() {
      Image($r('app.media.start'))
        .width(24).height(24)
        .fillColor(Color.Blue)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
  }

  @Builder
  titleInput() {
    TextInput({ placeholder: '输入 0~99 数字' })
      .layoutWeight(1)
      .margin({ left: 8, right: 8 })
      .backgroundColor('#F3F6F9')
  }

  @Builder
  leading() {
    Button() {
      Image($r('app.media.logo')).width(30).height(30)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
  }

  gen() {

  }

  @Builder
  button() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      SymbolGlyph($r('sys.symbol.scope'))
        .fontSize(24)
        .fontColor([Color.White])
        .fontWeight(FontWeight.Bold)
    }
    .width(56)
    .height(56)
    .margin({ right: 20, bottom: 16 })
    // .backgroundColor($r('app.color.theme_color'))
    .backgroundColor(this.guessing ? '#9e9e9c' : $r('app.color.theme_color'))
    .enabled(!this.guessing)
    .onClick(() => this.gen())
  }

  @Builder
  buildCounterDisplay(){
    if(!this.guessing)
    Column() {
      Text('点击生成随机数')
      Text('0').fontSize(46).fontColor('#727272')
    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
    else
    Column() {
      Text('开始输入猜数字吧~')
      Text('**').fontSize(46).fontColor('#727272')
    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      AppBar(
        {
          color: $r('app.color.app_title_bg_color'),
          tailing: this.tailing,
          leading: this.leading,
          titleSlot: this.titleInput,
        }
      )
      Stack() {
        Column() {
          ResultDisplay({ result: CheckResult.bigger })
          ResultDisplay({ result: CheckResult.none })
        }
        this.buildCounterDisplay()
        this.button()
      }.layoutWeight(1)
      .width('100%')
      .alignContent(Alignment.BottomEnd)

    }.width('100%').height('100%')

  }
}

enum CheckResult {
  none,
  bigger,
  smaller,
  equal,
}

function resultLabel(result: CheckResult): string | Resource {
  switch (result) {
    case CheckResult.bigger:
      return '大了';
    case CheckResult.smaller:
      return '小了';
  }
  return '';
}

function resultColor(result: CheckResult): ResourceColor {
  switch (result) {
    case CheckResult.bigger:
      return '#ff5454';
    case CheckResult.smaller:
      return '#448afc';
  }
  return '';
}


@Component
struct ResultDisplay {
  private result: CheckResult = CheckResult.none;

  build() {
    Column() {
      Text(resultLabel(this.result))
        .fontSize(24)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .layoutWeight(1)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(resultColor(this.result))
  }
}