@Component
export struct AppBar {
  private title: string | Resource = '';
  private color?: ResourceColor;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  @Builder
  leadingBuilder() {
  }

  @Builder
  tailingBuilder() {
    Shape().width(28)
  }

  @Builder
  titleBuilder() {
    Text(this.title)
      .fontSize($r('app.float.app_bar_title_size')).fontWeight(FontWeight.Bold)
      .fontColor($r('sys.color.black'))
  }

  @BuilderParam leading: () => void = this.leadingBuilder;
  @BuilderParam tailing: () => void = this.tailingBuilder;
  @BuilderParam titleSlot: () => void = this.titleBuilder;

  build() {
    Stack(){
      Row() {
        this.leading()
        this.titleSlot()
        this.tailing()
      }
      .backgroundColor(this.color)
      .width('100%')
      .height(56 )
      .padding({ left: 8, right: 8, })
      .justifyContent(FlexAlign.SpaceBetween)
    }.padding({ top: px2vp(this.topRectHeight)})
  }
}
