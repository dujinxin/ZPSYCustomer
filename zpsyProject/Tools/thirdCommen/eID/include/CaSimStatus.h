
//-----------------------------------------------------------------------------
//
// CaSimStatus.h (状态值定义)
//
//-----------------------------------------------------------------------------

#ifndef CaSim_StatusH
#define CaSim_StatusH

#define SW_SUCCESS			                0X9000		// 成功
#define SW_ERROR_OPEN_READER			    0x8D01		// 打开读卡器错误
#define SW_ERROR_NOT_LOGIN			        0x8D02		// 未登录
#define SW_ERROR_NO_READER			    	0x8D03		// 未设置读卡器
#define SW_ERROR_NOT_LOAD			        0x8D04		// 未载入处理类
#define SW_ERROR_IN_DATA_LENGTH_LONG		0x8D05		// 输入数据太长
#define SW_ERROR_KEY					0x8D08		// 密钥错误
#define SW_ERROR_OPEN_FILE				0x8D09		// 打开文件

//-----------------------------------------------------------------------------
//
// 状态首字节定义
//
//-----------------------------------------------------------------------------

#define SW1_RESP		0x61
#define SW1_AUTH_ERR	0x63
#define SW1_CMD_AGAIN   0X6C

//-----------------------------------------------------------------------------
//
// 有标准的返回状态字
//
//-----------------------------------------------------------------------------

// Checking errors

#define SW_STD_ERR_CLS			                0X6E00		// Class not supported
#define SW_STD_ERR_PARAM		                0X6B00		// Wrong parameter(s) P1-P2
#define SW_STD_ERR_NUMBER		                0X6700		// Wrong length
#define SW_STD_ERR_INS			                0X6D00		// Instruction code not supported or invalid
#define SW_STD_ERR_UNDEF		                0X6F00		// Technical problem, no precise diagnosis

// Execution errors

#define SW_STD_ERR_NO_INFO1                     0X6400      // No information given, state of non-volatile memory unchanged
#define SW_STD_ERR_NO_INFO2                     0X6500      // No information given, state of non-volatile memory changed
#define SW_STD_ERR_MEMORY			            0X6581		// Memory problem

// Postponed processing

#define SW_STD_STK_BUSY                         0X9300      // SIM Application Toolkit is busy. Command cannot be executed at
                                                            // present, further normal commands are allowed
// Warnings

#define SW_STD_WARNING_NO_INFO                  0X6200      // No information given, state of non volatile memory unchanged
#define SW_STD_WARNING_DATA_RETURN_CORRUPTED    0X6281      // Part of returned data may be corrupted
#define SW_STD_WARNING_END_REACHED              0X6282      // End of file/record reached before reading Le bytes
#define SW_STD_WARNING_FILE_INVALIDE 	        0X6283      // Selected file invalidated

// Functions in CLA not supported

#define SW_STD_CLS_NOT_SUPPORTED_UNDEF          0X6800      // No information given
#define SW_STD_CLS_NOT_SUPPORTED_CHANNEL        0X6881      // Logical channel not supported
#define SW_STD_CLS_NOT_SUPPORTED_SM             0X6882      // Secure messaging not supported

// Command not allowed

#define SW_STD_CMD_DISALLOWED                   0X6900  // No information given
#define SW_STD_CMD_DISALLOWED_FILE_TYPE         0X6981  // Command incompatible with file structure
#define SW_STD_CMD_DISALLOWED_ASTATUS           0X6982  // Security status not satisfied
#define SW_STD_CMD_DISALLOWED_KEY_LOCKED        0X6983  // Authentication/PIN method blocked
#define SW_STD_CMD_DISALLOWED_INVALIDATED       0X6984  // Referenced data invalidated
#define SW_STD_CMD_DISALLOWED_CONDITION         0X6985  // Conditions of use not satisfied
#define SW_STD_CMD_DISALLOWED_UNSELECTED        0X6986  // no EF selected


// Wrong parameters

#define SW_STD_PARAM_WRONG_DATA                 0X6A80  // Incorrect parameters in the data field
#define SW_STD_PARAM_WRONG_NO_FUNC              0X6A81  // Function not supported
#define SW_STD_PARAM_WRONG_NO_FILE              0X6A82  // File not found
#define SW_STD_PARAM_WRONG_NO_RECORD            0X6A83  // Record not found
#define SW_STD_PARAM_WRONG_PARAMETERS           0X6A86  // Incorrect parameters P1-P2
#define SW_STD_PARAM_WRONG_Lc                   0X6A87  // Lc inconsistent with P1-P2
#define SW_STD_PARAM_WRONG_NO_REFERENCE         0X6A88  // Referenced data not found
#define SW_STD_ERR_NO_FILE_MEMORY               0X6A84  // not enough memory

//Memory management
#define SW_STD_MEMORY_PROBLEM					0X9240	//memory problem

// USIM Application errors

#define SW_USIM_ERR_INCREASE                    0X9850  // INCREASE cannot be performed, max value reached
#define SW_USIM_ERR_AUTHENTICATE                0X9862  // Authentication error, application specific

//-----------------------------------------------------------------------------
//
// 状态字定义
//
//-----------------------------------------------------------------------------
#define SW_OK								0X9000		// 指令执行成功

#define SW_INS_NOTEXIST 	                0X9A00		// 指令不存在
#define SW_INS_NOTHEAD   	                0X9A01		// 卡头不存在
#define SW_INS_UNDEF	                    0X9A02      // 没有定义的用法
#define SW_INS_COMMERR   	                0X9A03		// 通信错误
#define SW_INS_NOTAUTH   	                0X9A04		// 没有认证
#define SW_INS_EXIST     	                0X9A05		// 已经存在
#define SW_INS_NOTSPACE    	                0X9A06		// 空间不足
#define SW_INS_AUTHERR   	                0X9A07		// 认证不对
#define SW_INS_P1ERR                        0X9A08      // P1错误
#define SW_INS_P2ERR               			0X9A09      // P2错误
#define SW_INS_P3ERR               			0X9A0A      // Lc错误
#define SW_INS_LOCKED						0X9A0B		// 应用被锁

#define SW_INS_NOROOT                       0X9A0C      // 无根目录
#define SW_INS_NODIR                        0X9A0E      // 无父目录
#define SW_INS_SUBDIRREPEAT                 0X9A0F      // 重复子目录
#define SW_INS_FILEIDREPEAT                 0X9A10      // 存在相同的文件ID
#define SW_INS_SUBDIREXIST				    0X9A11		// 还有子目录存在
#define SW_INS_NOFILE				        0X9A12		// 文件不存在


#define SW_INS_CONDITION                    0x9A19      // 条件不足
#define SW_INS_DATAERROR                    0x9A20      // 数据错误
#define SW_INS_SYNCFINISH                   0x9A21      // 同步完成
#define SW_INS_UNBINDING                    0x9A22      // 未绑定
#define SW_INS_BINDING                      0x9A23      // 已绑定
#define SW_INS_UNMATCH                      0x9A24      // 密钥与应用不匹配
#define SW_INS_INITIALIZED                  0x9A25      // 已经初始话
#define SW_INS_ADDERROR                     0x9A26      // 地址错误	 
#define SW_INS_APPDELERROR                  0x9A27      // 不能删除本CODE应用（关联的DATA应用存在）
#define SW_INS_APPTYPEERROR                 0x9A28      // 应用类型不匹配
#define SW_INS_APPTYHEADNOEXIST             0x9A29      // 应用头未创建

#define SW_INS_NORIGHT         							0X9A2A // 无权限
#define SW_INS_NOBLOCK         							0X9A2B // 无此块
#define SW_INS_NOKEY         								0X9A2C // 无此密钥
#define SW_INS_MONEYERR                     0x9A2D      // 钱包字段出错
#define SW_INS_EXPIRE                       0x9A2E      // 到期
#define SW_INS_SERIALNO                     0x9A2F      // 系列号错


#define SW_INS_APPHAVEACTIVE                0x9A30      // 应用已经激活
#define SW_INS_CHANNEL_BUSY                 0x9a31      // 通道正在执行其他指令，在指令执行结束前不能执行其他指令
#define SW_INS_BUSY                         0x9a32		// 忙
#define SW_INS_FAM                          0x9a33		// 天线不对
#define SW_INS_APPSTATUS_ERR				0X9A34		// 应用状态错误
#define SW_INS_CONTINUE					    0X9A35		// 未完，继续操作
#define SW_INS_OFFSET					    0X9A36		// 偏移量出错
#define SW_INS_TAC					        0X9A37		// 返回效验错 
#define SW_INS_APPHAVEHIDDEN                0x9A38      // 应用已经隐藏
#define SW_INS_AIDDUPLICATE                 0x9A39      // AID重复

#define SW_INS_DATALENZERO			        0X9A45		// 数据域长度为零


#define SW_APP_NOTSELECT 	                0X9B00		// 应用没选择
#define SW_APP_NOLISENCE                    0x9B01      // 没有许可
#define SW_DST_NOSELECT                     0x9B02      // 没有选择
#define SW_PIN_NOVERIFY                     0x9B03      // 没有PIN认证

#define SW_DST_NOTEXIST 	                0X9C00		// 目标不存在
#define SW_KEY_NOTEXIST 	                0X9C01		// Key不存在

#define SW_RF_CONNECT   	                0X9C02		// RF已经连接上
#define SW_RF_NOCONNECT   	                0X9C03		// RF没有连接上
#define SW_RF_ERROR     	                0X9C04		// RF通信错误
#define SW_RF_NODATA     	                0X9C05		// RF没有数据
#define SW_RF_WAIT         	                0X9C06		// 正在等ACK
#define SW_RF_OK         	                0X9C07		// 发送成功
#define SW_RF_FAIL         	                0X9C08		// 发送失败

#define SW_SPI_ERROR						0x9C0A		// spi通讯超时


#define SW_API_NOEXECFUN					0X9D01		// 传输函数指针为空

#define SW_APP_MAC_ERR                          0x9E00            // MAC/CRC错误
#define SW_APP_NOREGISTER                       0x9E01            // 应用没有注册
#define SW_APP_REGISTERED                       0x9E02            // 应用已注册
#define SW_APP_STOP                             0x9E03            // 应用已停用
#define SW_APP_VER_ERR                          0x9E04            // 版本号不对
#define SW_APP_CARD_LOCK                        0x9E05            // 卡锁定
#define SW_APP_BALANCE_ERR                      0x9E06            // 余额不足
#define SW_APP_COIN_LOCK                        0x9E07            // 积分锁定
#define SW_APP_CARDID_ERR                       0x9E08            // CardID不匹配
#define SW_APP_COUNT_ERR                        0x9E09            // 数目不匹配
#define SW_APP_STATUE_ERR                       0x9E0A            // 状态字不匹配
#define SW_APP_VIPNUM_ERROR                     0x9E0B             // VIP许可数量超界
#define SW_APP_COIN_ERROR                       0x9E0C             // 币值为0
#define SW_APP_TAC_ERROR                        0x9E0D             // TAC错误
#define SW_APP_DATA_ERROR                       0x9E0E                // 数据有错

//---------------------------------------------------------------------------
// Simcert status
//---------------------------------------------------------------------------
#define SW_SIMCERT_OPENREAD				0X9423		//SIMCERT 读数据开关标志
#define SW_SIMCERT_ENDREAD				0X9424		//SIMCERT 已读完数据
#define SC_SIMCERT_ENCRYPERROR				0x9425      //加密错误
#define SC_SIMCERT_DATARROR				0x9426      //明文数据错误
#define SC_SIMCERT_KEYTYPEERROR			0x9427      //密钥类型错误
#define SC_SIMCERT_STOPCMD  			0x9428      //指令暂停(无效状态）
#define SC_SIMCERT_ERRORLEN  			0x9429      //指令数据长度错误

//---------------------------------------------------------------------------
// End file
//---------------------------------------------------------------------------

#endif
