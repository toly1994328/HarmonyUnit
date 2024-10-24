
@Component
export struct AppBar {
  private title: string | Resource = '';

  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

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
    .height(56 + px2vp(this.topRectHeight))
    .padding({ left: 8, right: 8, top: px2vp(this.topRectHeight) })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
