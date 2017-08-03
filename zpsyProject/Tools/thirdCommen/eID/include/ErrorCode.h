#ifndef _EID_ERROR_CODE_H
#define _EID_ERROR_CODE_H

/** @file ErrorCode.h
 *  @brief 返回码文件
 *
 *  定义接口的返回码
 */

#define ERR_BASE_CARD           0xe0100000/**<卡片应用层错误*/
#define ERR_BASE_CONTEXT        0xe0110000/**<应用文上下环境层错误*/
#define ERR_BASE_UAI            0xe0120000/**<统一应用接口层错误*/
#define ERR_BASE_CARDDEVICE     0xe0130000/**<卡设备层错误*/
#define ERR_BASE_COS            0xe0140000/**<cos层错误*/
#define ERR_BASE_EID           0xe0150000/**<eID层错误*/
#define ERR_BASE_USER           0xe0ff0000/**<用户自定义的错误*/

#define ERR_SUCCESS                   0x00/**<操作成功*/
#define ERR_UNKNOWN                   0x01/**<未知错误*/
#define ERR_NOT_SUPPORT               0x02/**<函数不支持*/
#define ERR_BAD_CARD_OBJ              0x03/**<卡对象错误*/
#define ERR_BAD_CARDDEV_OBJ           0x04/**<卡设备对象错误*/
#define ERR_INVALID_PARAM             0x05/**<参数错误*/
#define ERR_BAD_LEN                   0x06/**<数据长度错误*/
#define ERR_BAD_ALG                   0x07/**<算法错误*/
#define ERR_BAD_PADDING               0x08/**<填充或反填充错误*/
#define ERR_BAD_IV                    0x09/**<初始化向量错误*/
#define ERR_BAD_KEY                   0x0A/**<密钥错误*/
#define ERR_BAD_MODE                  0x0B/**<对称算法模式错误*/
#define ERR_BAD_ROLE                  0x0C/**<错误的角色*/
#define ERR_BAD_FILE_ID               0x0D/**<文件ID错误*/
#define ERR_BAD_DIR_NAME              0x0E/**<目录名错误*/
#define ERR_FILE_EXIST                0x0F/**<指定的文件已存在*/
#define ERR_FILE_NOT_EXIST            0x10/**<指定的文件不存在*/
#define ERR_BAD_KEY_TYPE              0x11/**<密钥类型错误*/
#define ERR_CONTAINER_EXIST           0x12/**<指定的容器已存在*/
#define ERR_CONTAINER_NOT_EXIST       0x13/**<指定的容器不存在*/
#define ERR_NO_VALID_CONTAINER        0x14/**<无效的容器*/
#define ERR_NOT_INIT                  0x15/**<未完成初始化*/
#define ERR_LIST_DEV                  0x16/**<枚举设备错误*/
#define ERR_DEV_HANDLE                0x17/**<设备句柄错误*/
#define ERR_DEV_NAME                  0x18/**<设备名错误*/
#define ERR_NO_DEV                    0x19/**<无法找到设备*/
#define ERR_NO_MEMORY                 0x1A/**<没有足够的内存*/
#define ERR_BAD_PIN_LEN               0x1B/**<PIN码长度错误*/
#define ERR_BAD_FILE_OFFSET           0x1C/**<文件偏移错误*/
#define ERR_SESSION_INDEX             0x1D/**<会话密钥索引错误*/
#define ERR_NO_OPEN_DEV               0x1E/**<无法找到已打开的设备*/
#define ERR_NO_ABILITY_DATA           0x1F/**<未找到能力文件*/
#define ERR_BAD_CARD_NAME             0x20/**<设备名错误*/
#define ERR_BAD_FILESYSTEM            0x21/**<文件系统错误*/
#define ERR_KEYTYPE_NO_SUITE          0x22/**<指定的算法与密钥类型不匹配*/
#define ERR_MULTI_DEVICE              0x23/**<不允许插入多个设备*/
#define ERR_CALC                      0x24/**<计算错误*/
#define ERR_NO_SN_BIND                0x25/**<没有绑定SN*/
#define ERR_HASH_NOT_INIT             0x26/**<未初始化hash*/
#define ERR_HASH_NOT_UPDATE           0x27/**<未计算hash值*/
#define ERR_HASH_INIT_FAILED          0x28/**<hashInit执行失败*/
#define ERR_HASH_UPDATE_FAILED        0x29/**<hashUpdate执行失败*/
#define ERR_HASH_FINAL_FAILED         0x2A/**<hashFinal执行失败*/
#define ERR_NOT_EID_CARD              0x2B/**<非eID卡*/
#define ERR_SIGN_NOT_INIT             0x2C/**<未初始化签名*/
#define ERR_SIGN_NOT_UPDATE           0x2D/**<未计算签名*/
#define ERR_VERIFY_NOT_INIT           0x2E/**<未初始化验签*/
#define ERR_VERIFY_NOT_UPDATE         0x2F/**<未计算验签*/
#define ERR_LOGIN_ENCRYPT_FAILED      0x30/**<密文校验PIN时，加密失败*/

//cos 层错误码
#define ERR_FILE_SHORT                  0x6282/**<文件长度小于Le*/
#define ERR_FILE_INVALID                0x6283/**<选择文件无效*/
#define ERR_FCI_P2_INVALID              0x6284/**< FCI格式与P2指定的不符*/
#define ERR_NODATA_OR_INVALID           0x6300/**<无数据或导入的数据无效*/
#define ERR_MEMORY                      0x6581/**<内存错误*/
#define ERR_LC_OR_LE                    0x6700/**<Lc或Le有错*/
#define ERR_SAFE_MSG_NOT_SUPPORT        0x6882/**<不支持安全报文*/
#define ERR_PIN_REMAINED_TIMES_MASK     0x63C0/**<63CX，X表示剩余尝试次数*/
#define ERR_CMD_UN_ACCEPT               0x6901/**<（命令不接受）无效状态*/
#define ERR_CMD_FILE_INCOM              0x6981/**<命令与文件结构不相容*/
#define ERR_NOT_SAFE                    0x6982/**<安全状态不满足*/
#define ERR_AUTHEN_METHOD_LOCKED        0x6983/**<认证方法（个人密码）锁定*/
#define ERR_DATA_INVALID                0x6984/**<引用数据无效*/
#define ERR_CONDITION_INVALID           0x6985/**<使用条件不满足*/
#define ERR_NOT_EF                      0x6986/**<不满足命令执行的条件（不是当前的EF）*/
#define ERR_SAFE_MSG_MISSING            0x6987/**<安全报文数据项丢失*/
#define ERR_SAFE_MSG_WRONG              0x6988/**<安全报文数据项不正确*/
#define ERR_DATA_PARAM_WRONG            0x6A80/**<数据域参数不正确*/
#define ERR_FUN_NOT_SUPPORT             0x6A81/**<功能不支持*/
#define ERR_FILE_MISSING                0x6A82/**<没有找到文件*/
#define ERR_RECORD_MISSING              0x6A83/**<没有找到记录*/
#define ERR_NO_SPACE                    0x6A84/**<没有足够的空间*/
#define ERR_P1_P2_WRONG                 0x6A86/**<P1，P2参数不正确*/
#define ERR_DATA_MISSING                0x6A88/**<未找到引用数据*/
#define ERR_GREATER_THAN_EF             0x6B00/**<参数错误（偏移地址超出了EF）*/
#define ERR_LE_WRONG                    0x6C00/**<6CXX长度错误（Le不正确，‘XX’表示实际长度）*/
#define ERR_INS_WRONG                   0x6D00/**<不正确的INS*/
#define ERR_CLA_WRONG                   0x6E00/**<不正确的CLA*/
#define ERR_DATA_WRONG                  0x6F00/**<数据无效*/
#define ERR_MAC_WRONG                   0x9302/**<MAC无效*/
#define ERR_APP_LOCK                    0x9303/**<应用已被永久锁定*/
#define ERR_ABNORMAL_CODE               0x9401/**<功能（算法或其它）不支持*/
#define ERR_KEY_NOTFOUND                0x9403/**<密钥未找到*/

/** @class ErrorCode ErrorCode.h
 *  @brief 错误码定义类
 *
 *  返回码由4个字节组成，前两个字节为返回码头，后两个字节为实际返回码。
 *  <br>如：0xe0100005，返回码头为0xe010，实际返回码为0x0005。
 *  <br>返回码头描述了出现返回码的源头，根据不同的返回码头，实际返回码的定义也不相同。
 *  <br>以"ERR_BASE"开头的均为返回码头，如：#define ERR_BASE_CARD 0xe0100000；
 *  <br>其他均为实际返回码，如：#define ERR_BAD_ALG 0x07
 *  <br>返回码头0xe0100000与实际返回码0x07组合成0xe0100007，对应"从卡片层返回的算法错误"。
 *  @ingroup Defines
 */

class ErrorCode{
  
public:
    /** @brief 获取结果码描述
     *  @param errorCode [in] 结果码
     * @return 结果码描述
     */
    static const  char* getErrorDescription(unsigned long errorCode);
};


#endif