import { AppBar } from '../../../components/AppBar'
import { MuyuBloc } from '../bloc/MuyuBloc';
import { AnimaValue } from './AnimaValue';
import { MuyuSelectorSheet } from './MuyuSelectorSheet';
import { VoiceSelectorSheet } from './VoiceSelectorSheet';

@Builder
export function pageBuilder(name: string, param: Object) {
  MuYuPage()
}


@Component
export struct MuYuPage {
  @State model: MuyuBloc = new MuyuBloc();
  @Consume('NavPathStack') pageStack: NavPathStack;

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

  toHistory() {
    this.pageStack.pushPathByName('merit_record', this.model.records.reverse());
  }

  @Builder
  buildButtons() {
    Column() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.music_fill'))
          .fontSize(20)
          .fontColor([Color.White])
          .fontWeight(FontWeight.Bold)
      }
      .width(36)
      .height(36)
      .margin({ bottom: 12 })
      .borderRadius(4)
      .onClick(() => this.openBottomSheet(true))

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.picture_fill'))
          .fontSize(20)
          .fontColor([Color.White])
          .fontWeight(FontWeight.Bold)
      }.width(36).height(36).borderRadius(4)
      .onClick(() => this.openBottomSheet(false))

    }.position({
      top: 12,
      right: 12
    })
  }

  openBottomSheet(music: boolean) {
    this.isShowSheet = true;
    this.isMusic = music;
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
        Image(this.model.imageSrc()).height(200)
          .onClick(() => this.model.tick())
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      AnimaValue({ record: this.model.lastRecord })
    }
    .width('100%')
    .layoutWeight(1)
  }

  @State isMusic: boolean = false;

  @Builder
  sheetBuilder() {
    Column() {
      if (this.isMusic) {
        VoiceSelectorSheet({
          activeIndex: this.model.activeAudioIndex,
          options: this.model.audioOptions,
          onSelected: (index) => {
            this.model.changeVoice(index);
            this.isShowSheet = false;
          },
          onPreview: (index) => {
            this.model.previewVoice(index);
          }
        })
      } else {
        MuyuSelectorSheet({
          activeIndex: this.model.activeImageIndex,
          options: this.model.imageOptions,
          onSelected: (index) => {
            this.model.changeImage(index);
            this.isShowSheet = false;
          }
        }
        )
      }
    }
  }

  @State isShowSheet: boolean = false;

  build() {
    NavDestination(){
      Column() {
        AppBar({ titleSlot: this.title, tailing: (): void => this.tailing() }
        ).backgroundColor($r('sys.color.white'))
        this.valueDisplay()
        this.muyuDisplay()
      }
      .height('100%')
      .backgroundColor('#fafafa')
      .bindSheet($$this.isShowSheet, this.sheetBuilder(), {
        height: 400,
        showClose: false,
      })
    }.hideTitleBar(true)

  }
}
