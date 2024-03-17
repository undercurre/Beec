import http from '@ohos.net.http';
import CryptoJS from '@ohos/crypto-js';
//导入封装好的请求
import { request } from '../utils/Request'
import data_storage from '@ohos.data.storage';

/**
 * 登录
 */
export async function login(data: {username: string, password: string}) {
  let storage = data_storage.getStorageSync(getContext().filesDir + 'auth');
  storage.deleteSync('token');
  data.password = CryptoJS.MD5(data.password).toString();
  const res = await request(`/auth/login`,http.RequestMethod.POST, data)

  if (res.code === 200) {
    storage.putSync('token', res.data.access_token);
    storage.flushSync();
  }
  return res;
}

/**
 * profile
 */
export function getUserProfile() {
  return request('/profile', http.RequestMethod.GET)
}

/**
 * 退出登录
 */
export function logout() {
  return request(`/auth/logout`, http.RequestMethod.POST, {})
}