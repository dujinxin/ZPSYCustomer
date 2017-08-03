
//-----------------------------------------------------------------------------
//
// CaSimStatus.h (״ֵ̬����)
//
//-----------------------------------------------------------------------------

#ifndef CaSim_StatusH
#define CaSim_StatusH

#define SW_SUCCESS			                0X9000		// �ɹ�
#define SW_ERROR_OPEN_READER			    0x8D01		// �򿪶���������
#define SW_ERROR_NOT_LOGIN			        0x8D02		// δ��¼
#define SW_ERROR_NO_READER			    	0x8D03		// δ���ö�����
#define SW_ERROR_NOT_LOAD			        0x8D04		// δ���봦����
#define SW_ERROR_IN_DATA_LENGTH_LONG		0x8D05		// ��������̫��
#define SW_ERROR_KEY					0x8D08		// ��Կ����
#define SW_ERROR_OPEN_FILE				0x8D09		// ���ļ�

//-----------------------------------------------------------------------------
//
// ״̬���ֽڶ���
//
//-----------------------------------------------------------------------------

#define SW1_RESP		0x61
#define SW1_AUTH_ERR	0x63
#define SW1_CMD_AGAIN   0X6C

//-----------------------------------------------------------------------------
//
// �б�׼�ķ���״̬��
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
// ״̬�ֶ���
//
//-----------------------------------------------------------------------------
#define SW_OK								0X9000		// ָ��ִ�гɹ�

#define SW_INS_NOTEXIST 	                0X9A00		// ָ�����
#define SW_INS_NOTHEAD   	                0X9A01		// ��ͷ������
#define SW_INS_UNDEF	                    0X9A02      // û�ж�����÷�
#define SW_INS_COMMERR   	                0X9A03		// ͨ�Ŵ���
#define SW_INS_NOTAUTH   	                0X9A04		// û����֤
#define SW_INS_EXIST     	                0X9A05		// �Ѿ�����
#define SW_INS_NOTSPACE    	                0X9A06		// �ռ䲻��
#define SW_INS_AUTHERR   	                0X9A07		// ��֤����
#define SW_INS_P1ERR                        0X9A08      // P1����
#define SW_INS_P2ERR               			0X9A09      // P2����
#define SW_INS_P3ERR               			0X9A0A      // Lc����
#define SW_INS_LOCKED						0X9A0B		// Ӧ�ñ���

#define SW_INS_NOROOT                       0X9A0C      // �޸�Ŀ¼
#define SW_INS_NODIR                        0X9A0E      // �޸�Ŀ¼
#define SW_INS_SUBDIRREPEAT                 0X9A0F      // �ظ���Ŀ¼
#define SW_INS_FILEIDREPEAT                 0X9A10      // ������ͬ���ļ�ID
#define SW_INS_SUBDIREXIST				    0X9A11		// ������Ŀ¼����
#define SW_INS_NOFILE				        0X9A12		// �ļ�������


#define SW_INS_CONDITION                    0x9A19      // ��������
#define SW_INS_DATAERROR                    0x9A20      // ���ݴ���
#define SW_INS_SYNCFINISH                   0x9A21      // ͬ�����
#define SW_INS_UNBINDING                    0x9A22      // δ��
#define SW_INS_BINDING                      0x9A23      // �Ѱ�
#define SW_INS_UNMATCH                      0x9A24      // ��Կ��Ӧ�ò�ƥ��
#define SW_INS_INITIALIZED                  0x9A25      // �Ѿ���ʼ��
#define SW_INS_ADDERROR                     0x9A26      // ��ַ����	 
#define SW_INS_APPDELERROR                  0x9A27      // ����ɾ����CODEӦ�ã�������DATAӦ�ô��ڣ�
#define SW_INS_APPTYPEERROR                 0x9A28      // Ӧ�����Ͳ�ƥ��
#define SW_INS_APPTYHEADNOEXIST             0x9A29      // Ӧ��ͷδ����

#define SW_INS_NORIGHT         							0X9A2A // ��Ȩ��
#define SW_INS_NOBLOCK         							0X9A2B // �޴˿�
#define SW_INS_NOKEY         								0X9A2C // �޴���Կ
#define SW_INS_MONEYERR                     0x9A2D      // Ǯ���ֶγ���
#define SW_INS_EXPIRE                       0x9A2E      // ����
#define SW_INS_SERIALNO                     0x9A2F      // ϵ�кŴ�


#define SW_INS_APPHAVEACTIVE                0x9A30      // Ӧ���Ѿ�����
#define SW_INS_CHANNEL_BUSY                 0x9a31      // ͨ������ִ������ָ���ָ��ִ�н���ǰ����ִ������ָ��
#define SW_INS_BUSY                         0x9a32		// æ
#define SW_INS_FAM                          0x9a33		// ���߲���
#define SW_INS_APPSTATUS_ERR				0X9A34		// Ӧ��״̬����
#define SW_INS_CONTINUE					    0X9A35		// δ�꣬��������
#define SW_INS_OFFSET					    0X9A36		// ƫ��������
#define SW_INS_TAC					        0X9A37		// ����Ч��� 
#define SW_INS_APPHAVEHIDDEN                0x9A38      // Ӧ���Ѿ�����
#define SW_INS_AIDDUPLICATE                 0x9A39      // AID�ظ�

#define SW_INS_DATALENZERO			        0X9A45		// �����򳤶�Ϊ��


#define SW_APP_NOTSELECT 	                0X9B00		// Ӧ��ûѡ��
#define SW_APP_NOLISENCE                    0x9B01      // û�����
#define SW_DST_NOSELECT                     0x9B02      // û��ѡ��
#define SW_PIN_NOVERIFY                     0x9B03      // û��PIN��֤

#define SW_DST_NOTEXIST 	                0X9C00		// Ŀ�겻����
#define SW_KEY_NOTEXIST 	                0X9C01		// Key������

#define SW_RF_CONNECT   	                0X9C02		// RF�Ѿ�������
#define SW_RF_NOCONNECT   	                0X9C03		// RFû��������
#define SW_RF_ERROR     	                0X9C04		// RFͨ�Ŵ���
#define SW_RF_NODATA     	                0X9C05		// RFû������
#define SW_RF_WAIT         	                0X9C06		// ���ڵ�ACK
#define SW_RF_OK         	                0X9C07		// ���ͳɹ�
#define SW_RF_FAIL         	                0X9C08		// ����ʧ��

#define SW_SPI_ERROR						0x9C0A		// spiͨѶ��ʱ


#define SW_API_NOEXECFUN					0X9D01		// ���亯��ָ��Ϊ��

#define SW_APP_MAC_ERR                          0x9E00            // MAC/CRC����
#define SW_APP_NOREGISTER                       0x9E01            // Ӧ��û��ע��
#define SW_APP_REGISTERED                       0x9E02            // Ӧ����ע��
#define SW_APP_STOP                             0x9E03            // Ӧ����ͣ��
#define SW_APP_VER_ERR                          0x9E04            // �汾�Ų���
#define SW_APP_CARD_LOCK                        0x9E05            // ������
#define SW_APP_BALANCE_ERR                      0x9E06            // ����
#define SW_APP_COIN_LOCK                        0x9E07            // ��������
#define SW_APP_CARDID_ERR                       0x9E08            // CardID��ƥ��
#define SW_APP_COUNT_ERR                        0x9E09            // ��Ŀ��ƥ��
#define SW_APP_STATUE_ERR                       0x9E0A            // ״̬�ֲ�ƥ��
#define SW_APP_VIPNUM_ERROR                     0x9E0B             // VIP�����������
#define SW_APP_COIN_ERROR                       0x9E0C             // ��ֵΪ0
#define SW_APP_TAC_ERROR                        0x9E0D             // TAC����
#define SW_APP_DATA_ERROR                       0x9E0E                // �����д�

//---------------------------------------------------------------------------
// Simcert status
//---------------------------------------------------------------------------
#define SW_SIMCERT_OPENREAD				0X9423		//SIMCERT �����ݿ��ر�־
#define SW_SIMCERT_ENDREAD				0X9424		//SIMCERT �Ѷ�������
#define SC_SIMCERT_ENCRYPERROR				0x9425      //���ܴ���
#define SC_SIMCERT_DATARROR				0x9426      //�������ݴ���
#define SC_SIMCERT_KEYTYPEERROR			0x9427      //��Կ���ʹ���
#define SC_SIMCERT_STOPCMD  			0x9428      //ָ����ͣ(��Ч״̬��
#define SC_SIMCERT_ERRORLEN  			0x9429      //ָ�����ݳ��ȴ���

//---------------------------------------------------------------------------
// End file
//---------------------------------------------------------------------------

#endif
