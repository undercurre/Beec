import router from '@ohos.router'
import Constant from '../common/Constant'
import http from '@ohos.net.http';
import { getUserProfile, login } from '../api/User';

let httpRequest = http.createHttp();

httpRequest.on('headersReceive', (header) => {
  console.info('header: ' + JSON.stringify(header));
});

@Entry
@Component
struct Login {
  @State message: string = 'Please login'
  @State username: string = ''
  @State password: string = ''

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

        TextInput({ placeholder: 'Password' })
          .type(InputType.Password)
          .margin({ top: 20 })
          .width(Constant.INPUT_WIDTH)
          .height(Constant.INPUT_HEIGHT)
          .onChange((value: string) => {
            this.password = value
          })


        Button('Login in')
          .width(Constant.BUTTON_WIDTH)
          .height(Constant.BUTTON_HEIGHT)
          .margin({ top: 30 })
          .backgroundColor(Constant.BUTTON_COLOR)
          .onClick(async () => {
            const res = await login({ username: this.username, password: this.password })
            if (res.code === 200) {
              router.pushUrl({
                url: 'pages/Index',
                params: {
                  username: this.username
                }
              });
            }
          })

        // Flex({ justifyContent: FlexAlign.Center }) {
        //   Text(`Don't have an account yet?`).margin({ right: 10 })
        //   Text('To Register')
        //     .fontColor(Constant.BUTTON_COLOR)
        //     .onClick(() => {
        //       login({username: this.username, password: this.password});
        //     })
        //     .onClick(() => {
        //       router.pushUrl({
        //         url: 'pages/Register'
        //       })
        //     })
        // }
        // .width('100%')
        // .margin(30)
      }
      .width('100%')
    }
    .height('100%')
  }
  onPageShow() {
    router.clear();
  }
}
