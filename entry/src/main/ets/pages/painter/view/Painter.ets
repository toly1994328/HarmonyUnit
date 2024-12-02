import { AppBar } from "../../../components/AppBar"
import { PainterBloc } from "../bloc/PainterBloc"
import { ColorSelector } from "./ColorSelector"
import { StorkWidthSelector } from "./LineSelector"

@Component
export struct Painter {
  @Builder
  title() {
    Text("画板绘制").fontSize('18fp').fontWeight(FontWeight.Bold).margin({ left: 12 })
  }

  @Builder
  clearButton() {
    Button() {
      SymbolGlyph($r('sys.symbol.trash')).fontSize(26)
    }
    .width(36).height(36).backgroundColor(Color.Transparent)
    .onClick(() => this.showClearDialog())
  }

  @Builder
  actionsButton() {
    Row() {
      Button() {
        SymbolGlyph($r('sys.symbol.undo')).fontSize(24)
      }
      .width(36).height(36)
      .backgroundColor(Color.Transparent)
      .enabled(this.model.lineCount > 0)
      .onClick(() => this.model.back())

      Button() {
        SymbolGlyph($r('sys.symbol.redo')).fontSize(24)
      }
      .width(36).height(36)
      .backgroundColor(Color.Transparent)
      .enabled(this.model.historyLineCount > 0)
      .onClick(() => this.model.revocation())
    }
  }

  @State model: PainterBloc = new PainterBloc();

  build() {
    Stack() {
      Column() {
        AppBar({
          titleSlot: this.title,
          tailing: () => {
            this.clearButton()
          },
          leading: () => {
            this.actionsButton()
          },
        })
        Canvas(this.model.context)
          .width('100%')
          .layoutWeight(1)
          .backgroundColor('#fafafa')
          .gesture(
            PanGesture()
              .onActionStart((e) => this.onPanStart(e))
              .onActionUpdate((e) => this.onPanUpdate(e)),
          )
      }

      Row() {
        ColorSelector({
          colors: this.model.supportColors,
          activeIndex: this.model.colorIndex,
          onSelected: (index) => {
            this.model.changeColor(index);
          }
        }).layoutWeight(1)
        StorkWidthSelector({
          stokeWidths: this.model.supportStorkWidths,
          activeIndex: this.model.storkWidthIndex,
          color: this.model.currentColor(),
          onSelected: (index) => {
            this.model.changeStorkWidths(index);
          }
        }).margin({ left: 8 })
      }.padding({ left: 12, right: 12 }).position({ bottom: 24 })

    }

    .width('100%').height('100%')
  }

  positionX: number = 0;
  positionY: number = 0;

  onPanUpdate(e: GestureEvent): void {
    if (e.fingerList.length < 0) {
      return;
    }
    let x = e.fingerList[0].localX;
    let y = e.fingerList[0].localY;
    this.model.updateLine(x, y);
  }

  onPanStart(e: GestureEvent): void {
    if (e.fingerList.length < 0) {
      return;
    }
    let x = e.fingerList[0].localX;
    let y = e.fingerList[0].localY;
    this.model.newLine(x, y);
  }

  showClearDialog(): void {
    AlertDialog.show(
      {
        title: '清空操作提示',
        message: '您的当前操作会清空所有的绘制内容，是否确定继续!',
        autoCancel: true,
        cornerRadius: 8,
        alignment: DialogAlignment.Center,
        gridCount: 4,
        primaryButton: {
          value: '取消', action: () => {
          }
        },
        secondaryButton: {
          enabled: true,
          defaultFocus: true,
          style: DialogButtonStyle.HIGHLIGHT,
          backgroundColor: '#fe5455',
          value: '确定',
          action: () => this.model.clear()
        }
      }
    );
  }
}