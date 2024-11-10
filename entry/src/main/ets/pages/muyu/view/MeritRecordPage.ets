import { AppBar } from "../../../components/AppBar";
import { MeritRecord } from "../model/MeritRecord";


@Builder
export function pageBuilder() {
  MeritRecordPage()
}

@Component
export struct MeritRecordPage {
  @Consume('NavPathStack') pageStack: NavPathStack;
  @State records: MeritRecord[] = []

  @Builder
  title() {
    Text("功德记录").fontSize('18fp').fontWeight(FontWeight.Bold).margin({ left: 12 })
  }

  @Builder
  backButton() {
    Button() {
      SymbolGlyph($r('sys.symbol.chevron_left'))
        .fontSize(28)
    }
    .width(36).height(36)
    .backgroundColor(Color.Transparent)
    .onClick(() => this.pageStack.pop())
  }

  build() {
    NavDestination() {
      Column() {
        AppBar({
          color: Color.White,
          leading: () => {
            this.backButton()
          },
          titleSlot: this.title
        })
        List() {
          ForEach(this.records, (record: MeritRecord) => {
            ListItem() {
              MeritRecordItem({ record })
            }
          }, (item: MeritRecord) => `${item.timestamp}`,)
        }
      }.height('100%').backgroundColor('#fafafa')
    }.onReady((ctx) => this.findParam(ctx)).hideTitleBar(true)

  }

  findParam(context: NavDestinationContext): void {
    this.records = context.pathInfo.param as MeritRecord[];
  }
}

@Preview
@Component
struct MeritRecordItem {
  record: MeritRecord = new MeritRecord({
    timestamp: Date.now(),
    value: 1,
    image: $r('app.media.muyu2'),
    audio: '空灵弥音',
  })

  build() {
    Row() {
      Image(this.record.image)
        .width(48)
        .height(48)
        .padding(6)
        .margin({ left: 12, right: 12 })
        .borderRadius(48 / 2)
        .backgroundColor('#2c85d6')

      Column() {
        Text(`功德 +${this.record.value}`).fontSize(16).margin({ bottom: 4 })
        Text(this.record.audio).fontSize(14).fontColor(Color.Gray)
      }.layoutWeight(1).alignItems(HorizontalAlign.Start)

      Text(`${new Date(this.record.timestamp).toLocaleString()}`).fontSize(12).margin({ right: 8 })
    }.padding(6).width('100%').justifyContent(FlexAlign.Start)
  }
}