import router from '@ohos.router'
import Constant from '../common/Constant'

@Entry
@Component
struct Register {
  @State message: string = 'Please Register'
  @State username: string = ''
  @State password: string = ''
  @State email: string = ''

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontColor(Constant.LOGIN_COLOR)
          .fontSize(Constant.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)
        TextInput({ placeholder: 'Username' })
          .margin({ top: 20 })
          .width(Constant.INPUT_WIDTH)
          .height(Constant.INPUT_HEIGHT)
          .onChange((value: string) => {
            this.username = value
          })
        TextInput({ placeholder: 'Email' })
          .margin({ top: 20 })
          .width(Constant.INPUT_WIDTH)
          .height(Constant.INPUT_HEIGHT)
          .onChange((value: string) => {
            this.email = value
          })
        TextInput({ placeholder: 'Password' })
          .type(InputType.Password)
          .margin({ top: 20 })
          .width(Constant.INPUT_WIDTH)
          .height(Constant.INPUT_HEIGHT)
          .onChange((value: string) => {
            this.password = value
          })
        Button('Register')
          .width(Constant.BUTTON_WIDTH)
          .height(Constant.BUTTON_HEIGHT)
          .margin({ top: 30 })
          .backgroundColor(Constant.BUTTON_COLOR)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Login',
              params: {
                username: this.username,
                password: this.password,
                email: this.email
              }
            })
          })
        Flex({ justifyContent: FlexAlign.Center }) {
          Text(`Already have an account?`).margin({ right: 10 })
          Text('Sign in')
            .fontColor(Constant.BUTTON_COLOR)
            .onClick(() => {
              router.back()
            })
        }
        .width('100%')
        .margin(30)
      }
      .width('100%')
    }
    .height('100%')
  }
}