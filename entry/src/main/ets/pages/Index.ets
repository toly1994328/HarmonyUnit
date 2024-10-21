@Entry
@Component
struct Index {
  @State message: string = '鸿蒙纪元';

  build() {
    Column() {
      Text('计数器')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, left: 20 })
      Column() {
        Text('下面是你点击按钮的次数:')
          .fontSize(18)
        Text('0')
          .fontSize(36)
          .fontColor('#2e3032')
          .margin({ top: 10 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height('100%')
  }
}

