import router from '@ohos.router'
import { getUserProfile, logout } from '../api/User'
import Constant from '../common/Constant'

@Component

export default struct Mine {

  build() {
    Row() {
      Column() {
        Text('Hello')
          .fontColor(Constant.LOGIN_COLOR)
          .fontSize(Constant.LOGIN_SIZE)
          .fontWeight(FontWeight.Bold)

        Button('Logout bye!')
          .width(Constant.BUTTON_WIDTH)
          .height(Constant.BUTTON_HEIGHT)
          .margin({ top: 30 })
          .backgroundColor(Constant.BUTTON_COLOR)
          .onClick(async () => {
            const res = await logout();
            console.info('Logout', JSON.stringify(res));
            if (res.code === 200) {
              router.pushUrl({
                url: 'pages/Login',
              });
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}