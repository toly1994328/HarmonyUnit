import { AppBar } from '../../../components/AppBar'
import { CheckResult } from '../model/CheckResult';
import { GuessingState } from '../model/GuessingState';
import { InfomationDisplay } from './InfomationDisplay';
import { ResultDisplay } from './ResultDisplay';

@Preview
@Component
export struct GuessingPage {
  @State state: GuessingState = new GuessingState();

  aboutToAppear(): void {
    console.log("aboutToAppear")
  }

  aboutToDisappear(): void {
    console.log("aboutToDisappear")
  }

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
    .enabled(this.state.guessing)
    .onClick(() => this.state.checkResult())
  }

  @Builder
  titleInput() {
    TextInput({
      placeholder: '输入 0~99 数字',
      text: $$this.state.input,
    })
      .layoutWeight(1)
      .onSubmit(() => this.state.checkResult())
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
    .backgroundColor(this.state.guessing ? '#9e9e9c' : $r('app.color.theme_color'))
    .enabled(!this.state.guessing)
    .onClick(() => this.state.start())
  }

  build() {
    Column() {
      AppBar(
        {
          color: $r('app.color.app_title_bg_color'),
          tailing: () => {
            this.tailing()
          },
          leading: this.leading,
          titleSlot: () => {
            this.titleInput()
          },
        }
      )
      Stack() {
        Column() {
          ResultDisplay({ result: this.solve(CheckResult.bigger), guessCount: this.state.guessCount })
          ResultDisplay({ result: this.solve(CheckResult.smaller), guessCount: this.state.guessCount })
        }

        InfomationDisplay({
          result: this.state.result,
          secret: this.state.secret,
          guessing: this.state.guessing,
        })
        this.button()
      }.layoutWeight(1)
      .width('100%')
      .alignContent(Alignment.BottomEnd)

    }.width('100%').height('100%')

  }

  solve(result: CheckResult): CheckResult {
    if (this.state.result == result) {
      return result;
    }
    return CheckResult.none;
  }
}


