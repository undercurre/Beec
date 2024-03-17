import http from '@ohos.net.http';
//导入预定好的数据响应格式
import Response from '../utils/Response'

import data_storage from '@ohos.data.storage';

//导出去一个请求函数，这样开发者就可以像axios一样的风格请求数据
export function request(url:string, method: http.RequestMethod, data?:any, config?: any): Promise<Response> {
  //定义一个后台请求的基地址
  const BASE_URL =  "http://81.71.85.68:9111"
  let httpRequest = http.createHttp();
  httpRequest.on('headersReceive', (header) => {
    console.info('header: ' + JSON.stringify(header));
  });

  let storage = data_storage.getStorageSync(getContext().filesDir + 'auth');
  const token = storage.getSync('token', '');
  console.info('HTTP Request token pre:' + JSON.stringify(token));

  return new Promise<Response>((resolve, reject) => {
    httpRequest.request(BASE_URL + url, {
      method: method,
      header: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
        ...config
      },
      //携带额外参数
      extraData: JSON.stringify(data),
      // 可选，指定返回数据的类型
      // expectDataType: http.HttpDataType.STRING,
      // 可选，默认为true
      // usingCache: true,
      // 可选，默认为1
      // priority: 1,
      // 可选，默认为60000ms
      // connectTimeout: 60000,
      // readTimeout: 60000,
      // 可选，协议类型默认值由系统自动指定
      // usingProtocol: http.HttpProtocol.HTTP1_1,
    }, (err, data) => {
        let response = new Response();
        if (!err) {
          if (data.responseCode === 200) {
            // 获取返回数据,将返回的json数据解析成事先预定好的响应格式
            // 这里建议和后端的保持一致
            let res: Response = JSON.parse(`${data.result}`);
            response.data = res.data;
            response.code = res.code;
            response.msg = res.msg;
          } else {
            response.msg = '请求错误';
            response.code = 400;
          }
          resolve(response);
          // data.result为HTTP响应内容，可根据业务需要进行解析
          console.info('HTTP Request token:' + JSON.stringify(token));
          console.info('HTTP Request Result:' + JSON.stringify(data.result));
          console.info('HTTP Request code:' + JSON.stringify(data.responseCode));
          // data.header为HTTP响应头，可根据业务需要进行解析
          console.info('HTTP Request header:' + JSON.stringify(data.header));
          console.info('HTTP Request cookies:' + JSON.stringify(data.cookies)); // 8+
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy();
        } else {
          response.msg = '请求错误';
          response.code = 400;
          reject(response);
          console.info('HTTP Request token:' + JSON.stringify(token));
          console.info('HTTP Request error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 当该请求使用完毕时，调用destroy方法主动销毁。
          httpRequest.destroy();
        }
    });
  });
}