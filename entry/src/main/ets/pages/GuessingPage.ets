import { AppBar } from '../components/AppBar'

@Preview
@Component
export struct GuessingPage {
  @State guessing: boolean = false;
  @State secret: number = 0;
  @State input: string = '';
  @State result: CheckResult = CheckResult.none;

  @Builder
  tailing() {
    Button() {
      Image($r('app.media.start'))
        .width(24).height(24)
        .fillColor(Color.Blue)
    }
    .width(36)
    .height(36)
    .backgroundColor(Color.Transparent)
    .enabled(this.guessing)
    .onClick(() => this.checkResult())
  }

  @Builder
  titleInput() {
    TextInput({
      placeholder: '输入 0~99 数字',
      text: $$this.input,
    })
      .layoutWeight(1)
      .onSubmit(() => this.checkResult())
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

  checkResult(): void {
    if (this.input === '' || !this.guessing) {
      return;
    }
    const guess: number = Number(this.input);
    if (Number.isNaN(guess)) {
      return;
    }
    const diff = guess - this.secret;

    if (diff == 0) {
      this.result = CheckResult.equal
      this.guessing = false;
      this.input =''
    }
    if (diff > 0) {
      this.result = CheckResult.bigger
    }
    if (diff < 0) {
      this.result = CheckResult.smaller
    }
  }

  start(): void {
    this.guessing = true;
    this.secret = Math.floor(Math.random() * 100);
    this.result = CheckResult.none;
    this.input =''
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
    .backgroundColor(this.guessing ? '#9e9e9c' : $r('app.color.theme_color'))
    .enabled(!this.guessing)
    .onClick(() => this.start())
  }

  build() {
    Column() {
      AppBar(
        {
          color: $r('app.color.app_title_bg_color'),
          tailing: () => {this.tailing()},
          leading: this.leading,
          titleSlot: () => {this.titleInput()},
        }
      )
      Stack() {
        Column() {
          ResultDisplay({ result: this.solve(CheckResult.bigger) })
          ResultDisplay({ result: this.solve(CheckResult.smaller) })
        }

        InfomationDisplay({
          result: this.result,
          secret: this.secret,
          guessing: this.guessing,
        })
        this.button()
      }.layoutWeight(1)
      .width('100%')
      .alignContent(Alignment.BottomEnd)

    }.width('100%').height('100%')

  }

  solve(result: CheckResult): CheckResult {
    if (this.result == result) {
      return result;
    }
    return CheckResult.none;
  }
}

@Component
struct InfomationDisplay {
  @Prop result: CheckResult = CheckResult.none;
  @Prop guessing: boolean = false;
  @Prop secret: number = 0;

  info(): string {
    if (this.result == CheckResult.equal) {
      return '恭喜你猜对啦~';
    }
    if (!this.guessing) {
      return '点击生成随机数';
    }
    return '开始输入猜数字吧~';
  }

  value(): string {
    if (this.guessing) {
      return '**';
    }
    return this.secret.toString();
  }

  build() {
    Column() {
      Text(this.info())
      Text(this.value()).fontSize(46).fontColor('#727272')
    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
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
  @Prop result: CheckResult = CheckResult.none;

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