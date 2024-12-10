type IndexSelector = (index: number) => void;

@Component
export struct BottomAppBar {
  @Prop data: MenuMeta[] = [];
  @Prop activeIndex: number = 0;
  private onSelected?: IndexSelector;

  build() {
    Column(){
      Divider()
      Flex({ alignItems: ItemAlign.Center }) {
        ForEach(this.data, (item: MenuMeta, index: number) => {
          TabItem({
            item: item, selected: this.activeIndex == index,
            onTap: ()=>this.onSelected!(index)
          });
        })
      }.layoutWeight(1);
    }.height(58).width('100%').backgroundColor(Color.White)
    }

}

export interface MenuMeta {
  title: ResourceStr;
  icon: ResourceStr;
}

@Component
struct TabItem {
  @Prop item: MenuMeta;
  @Prop selected: boolean = false;
  private onTap = () => {};

  build() {
    Column() {
      Image(this.item.icon).fillColor(this.selected ? $r('app.color.theme_color') : Color.Grey).width(24).height(24)
      Shape().height(4)
      Text(this.item.title).fontSize(12).fontColor(this.selected ? $r('app.color.theme_color') : Color.Grey)
    }.onClick(() => this.onTap()).layoutWeight(1)
    .justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
  }
}