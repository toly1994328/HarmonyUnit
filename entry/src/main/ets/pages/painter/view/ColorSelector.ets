type IndexSelector = (index: number) => void;

@Component
export struct ColorSelector {
  @Prop activeIndex: number = 0;
  private colors: string[] = [];
  private onSelected?: IndexSelector;

  @Builder
  circleItem(color: string, index: number) {
    Row() {
      Shape() {Circle().fill(color).width(20).height(20)}
    }
    .height(28)
    .width(28)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .border(index == this.activeIndex ? { width: 1.5, radius: 14, color: '#317bd4' } : { color: Color.Transparent })
    .onClick(() => this.onSelected!(index));
  }

  build() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceEvenly }) {
      ForEach(this.colors, (item: string, index: number) => this.circleItem(item, index),);
    }
  }
}