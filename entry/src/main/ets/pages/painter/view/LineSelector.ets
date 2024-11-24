type IndexSelector = (index: number) => void;

@Component
export struct StorkWidthSelector {
  @Prop activeIndex: number = 0;
  @Prop color: string = '#000000'
  private stokeWidths: number[] = [];
  private onSelected?: IndexSelector;

  @Builder
  lineItem(item: number, index: number) {
    Row() {
      Shape().height(item).width(64).backgroundColor(this.color)
    }.height(20)
    .padding({left:8,right:8})
    .alignItems(VerticalAlign.Center)
    .border(index == this.activeIndex ? { width: 1.5, radius: 10, color: '#317bd4' } : {color: Color.Transparent })
    .onClick(() => this.onSelected!(index));
  }

  build() {
    Column() {
      ForEach(this.stokeWidths, (item: number, index: number) => this.lineItem(item, index),);
    }
  }
}