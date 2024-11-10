import { AudioOption } from "../model/AudioOption";

type IndexSelector = (index: number) => void;

@Component
export struct VoiceSelectorSheet {
  @Prop activeIndex: number = 0;
  private options: AudioOption[] = []
  private onSelected?: IndexSelector;
  private onPreview?: IndexSelector;

  @Builder
  voiceItem(item: AudioOption, index: number) {
    Row() {
      Text(item.name).layoutWeight(1).fontColor(this.activeIndex==index?Color.Blue:Color.Black)
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.music_fill'))
          .fontSize(20)
          .fontColor([Color.Blue])
          .fontWeight(FontWeight.Bold)
      }
      .width(36)
      .height(36)
      .borderRadius(4)
      .backgroundColor(Color.White)
      .onClick(() => this.onPreview!(index))

    }.height(46).alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 16 })
    .onClick(() => this.onSelected!(index));
  }

  build() {
    Column() {
      Row() {
        Text('选择音效').fontSize('18fp').fontWeight(FontWeight.Bold)
      }.height(52).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)

      ForEach(this.options, (item: AudioOption, index: number) => this.voiceItem(item, index),);
    }
    .width('100%')
    .height('100%')
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}