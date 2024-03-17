import Home from './Home'
import Mine from './Mine'

@Component

export default struct TabBar {
  @State username: string = ''

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Home()
      }
      .tabBar({
        icon: $rawfile('icon/home.svg'),
        text: 'Home'
      })

      TabContent() {
        Mine()
      }
      .tabBar({
        icon: $rawfile('icon/mine.svg'),
        text: this.username
      })
    }
  }
}