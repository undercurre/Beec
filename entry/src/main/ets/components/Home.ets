import web_webview from '@ohos.web.webview';

@Component

export default struct Home {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  build() {
    Column() {
      // 组件创建时，加载www.example.com
      Web({ src: 'blog.lirh42.xyz', controller: this.webviewController})
    }
  }
  onPageShow() {
    try {
      this.webviewController.loadUrl('blog.lirh42.xyz');
    } catch (error) {
      console.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
    }
  }
}