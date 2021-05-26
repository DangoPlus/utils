// 正则相关
const regNum = '/^-?d{0,8}(.d{0,2})'; //匹配小数点前八位后两位，包含负数
const regNumAll = '/^-?d*(.d*)'; // 匹配任意数字，包含小数负数

/**
 * 对数字做过滤精确到小数点后固定位数
 * @param num 需要处理的数字
 * @param length 精确到小数点后的长度，默认2位小数（四舍五入）
 */
export function fixedNum(num: any, length: number = 2) {
  const newNum = parseFloat(num);
  if (isNaN(newNum)) {
    return '';
  } else {
    return Math.round(newNum * Math.pow(10, length)) / Math.pow(10, length);
  }
}

// 计算时间间距
export function getTimeDistance(type: string): [Moment, Moment] {
  const now = new Date();
  // 今天
  if (type === 'today') {
    return [moment(now).startOf('day'), moment(now).endOf('day')];
  }
  // 本周
  if (type === 'week') {
    return [moment(now).startOf('week'), moment(now).endOf('week')];
  }
  // 本月
  if (type === 'month') {
    return [moment(now).startOf('month'), moment(now).endOf('month')];
  }
  // 本季度
  if (type === 'quarter') {
    return [moment(now).startOf('quarter'), moment(now).endOf('quarter')];
  }
  // 今年
  return [moment(now).startOf('year'), moment(now).endOf('year')];
}

import { parse } from 'querystring';

const reg = /(((^https?:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+(?::\d+)?|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)$/;
export const isUrl = (path: string): boolean => reg.test(path);
export const getPageQuery = () => parse(window.location.href.split('?')[1]);
export const timeStampToTimeString = (ts: string) => {
  function add0(m: any) {
    return m < 10 ? `0${m}` : m;
  }
  const time = new Date(ts);
  const Y = `${time.getFullYear()}年`;
  const M = `${time.getMonth() + 1 < 10 ? `0${time.getMonth() + 1}` : time.getMonth() + 1}月`;
  const D = `${time.getDate()}日 `;
  const Hour = `${time.getHours()}`;
  const Minute = `${time.getMinutes()}`;
  const S = `${time.getSeconds()}`;
  return `${Y + M + D + add0(Hour)}:${add0(Minute)}:${add0(S)}`;
};

export const downloadFile = (url: string, filename = '') => {
  const a = document.createElement('a');
  a.setAttribute('download', filename); // 用于设置下载文件的文件名
  a.setAttribute('target', '_blank');
  a.href = url;
  a.click();
  window.URL.revokeObjectURL(url);
};
