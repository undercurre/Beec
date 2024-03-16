import router from '@ohos.router';

let username: string = router.getParams()['username']

@Entry
@Component
struct Index {
  @State message: string = 'Hello World111'

  build() {
    Row() {
      Column() {
        Text(`Hello ${username}!`)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}