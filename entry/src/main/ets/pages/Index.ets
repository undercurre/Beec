import router from '@ohos.router';
import TabBar from '../components/TabBar';

let username: string = router.getParams()['username']

@Entry
@Component
struct Index {

  build() {
    Row() {
      Column() {
        TabBar({ username: username })
      }
      .width('100%')
    }
    .height('100%')
  }
}