/**
 * Created by Administrator on 2018/9/4 0004.
 * 可以将枚举信息都放在这里
 */

/**
 * http请求返回的状态码枚举
 */
export enum HttpCodesEnum {
  Success = '0000', //返回成功
  ServerError = '9999', //服务端报错
  BuidExist = '9500', //创建重复的数据
  QueryEmpty = '9006', //查询结果不存在
  QueryExist = '9006', //已存在重复
  ParamEmpty = '9004', //传入参数为空
  ParamIlegal = '9003', //传入参数非法
  StateError = '9002', //状态错误
  DataUnFull = '4444',
  NoDataUpdate = '4000',
  JobNumberExist = '1003',  //员工工号已存在
  PhoneErr = '1001', //手机号或格式有误
  AcTPsdErr = '1000', //账号密码错误
  PhoneExist = '1002', //手机号已存在
}

/**
 *获取枚举信息的传入状态码枚举
 */
export enum Enums {
  state = 1010,  // 状态
  companyNature = 1011,  // 公司性质
  TestUnitState = '1000',//测试单元状态
  StaffState = '1001',//员工状态
  ErrTypeState = '1002',//错误类型状态
  TestOptionState = '1003',//测试项状态
  TestRecordsState = '1004',//测试记录状态
  RepairState = '1005',//检修状态
  Genders = '1006',//性别
}

export enum States {
  enable = "Enable",//启用
  disable = "Disable",//禁用
}


export enum ActionType {
  add = 'add',
  modify = 'modify',
  del = 'delete'
}

/**
 * 性别类型枚举
 */
export enum GenderEnum {
  Male = 'Male',    //男
  Female = 'Female',  //女
  Other = 'Other',  //其他
}

/**
 * 员工在职状态枚举
 */
export enum StaffStateEnum {
  Hire = 'Hire', //在职
  Leave = 'Leave',  //离职
}

/**
 * 性别名称枚举
 */
export enum GenderNameEnum {
  Male = '男',    //男
  Female = '女',  //女
  Other = '其他',  //其他
}

/**
 * 员工在职状态名称枚举
 */
export enum StaffStateNameEnum {
  Hire = '在职', //在职
  Leave = '离职',  //离职
}

/**
 * 测试件状态样式枚举
 */
export enum TestunitStateClassEnum {
  Create = 'create anticon anticon-plus-circle',  //创建
  TestSuccess = 'testSuccess anticon anticon-check-circle-o',  //测试通过
  TestFailed = 'testFailed anticon anticon-close-circle-o',  //测试失败
  Repair = 'repair anticon anticon-tool',  //检修
}

/**
 * 测试件状态枚举
 */
export enum TestunitStateEnum {
  Create = 'Create',  //创建
  TestSuccess = 'TestSuccess',  //测试通过
  TestFailed = 'TestFailed',  //测试失败
  Repair = 'Repair',  //检修
}

/**
 * 同步数据操作事件枚举
 */
export enum SyncEventEnum {
  Insert = 'Insert',
  Update = 'Update',
  Delete = 'Delete'
}

/**
 * 同步数据状态枚举
 */
export enum SyncStateEnum {
  Ready = 'Ready',
  Synced = 'Synced'
}

/**
 * 同步追踪数据状态枚举
 */
export enum SyncTraceStateEnum {
  SyncSuccess = 'SyncSuccess',
  SyncFailed = 'SyncFailed'
}

/**
 * 同步追踪数据状态枚举
 */
export enum SyncTraceDirectionEnum {
  DownwardSync = 'DownwardSync',
  UpwardSync = 'UpwardSync'
}
