import { ImageOption } from "../model/ImageOption";

type IndexSelector = (index: number) => void;

@Component
export struct MuyuSelectorSheet {
  @Prop activeIndex: number = 0;
  private options: ImageOption[] = []
  private onSelected?: IndexSelector;

  @Builder
  buildItem(item: ImageOption, index: number) {
    Row() {
      Column() {
        Text(item.name).fontSize('16fp').fontWeight(FontWeight.Bold)
        Image(item.src)
          .width(120)
          .height(120)
          .borderRadius(4)
          .backgroundColor(Color.White)
          .margin({ top: 16, bottom: 16 })
        Text(`每次功德 +${item.min} ~ ${item.max}`).fontSize('14fp').fontColor('#b0b0b0')
      }
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 16, top: 12, bottom: 12 })
    .layoutWeight(1)
    .margin({ right: 8 })
    .border(index == this.activeIndex ? { width: 1, radius: 6, color: Color.Blue } : {})
    .onClick(() => this.onSelected!(index));
  }

  build() {
    Column() {
      Row() {
        Text('选择木鱼').fontSize('18fp').fontWeight(FontWeight.Bold)
      }.height(52).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)

      Row() {
        ForEach(this.options, (item: ImageOption, index: number) => this.buildItem(item, index),);
      }.margin({ top: 24 })
    }
    .padding({ left: 16, right: 16 })
    .width('100%')
    .height('100%')
    .borderRadius(8)
    .backgroundColor(Color.White)
  }
}
