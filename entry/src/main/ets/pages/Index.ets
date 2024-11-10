@Entry
@Component
struct Index {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack){}
      .padding({ bottom: px2vp(this.bottomRectHeight) })
      .onAppear(() => this.pushHome())
  }

  pushHome(): void {
    this.pageStack.pushPathByName("muyu", null, false);
  }
}
