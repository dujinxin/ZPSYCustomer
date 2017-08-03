/******************************************************************
������
2011.3.7
*******************************************************************/
#ifndef _BYTEARRAY_H
#define _BYTEARRAY_H
#define UCHAR unsigned char
const unsigned long ARRAY_ERROR_SIZE = 0xFFFFFFFF;

class  CHByteArray  
{
public:
	CHByteArray();
	CHByteArray(const CHByteArray &);
	//pucData����ΪNULL����ʱֻ�����ڲ�ulSize��С�Ļ�����������ʼ��������������
	CHByteArray(const unsigned char * pucData, const unsigned long ulSize, unsigned long ulCapacity = 0);

	~CHByteArray();


	//�����ڲ��������ֽڴ�С
	unsigned long GetSize() const;		//���������£�����ARRAY_ERROR_SIZE

	bool IsEmpty();
	//�õ���ǰ����ַ�����Index���൱��GetSize() - 1��
	unsigned long GetUpperBound() const;

	//�����ڲ���������С,nGrowBy���ڴ��Ż���ʽ���ݲ�ʵ��
	void SetSize(unsigned long nNewSize, int nGrowBy = -1);

	// Direct Access to the element data (may return NULL)
	const unsigned char* GetData() const;
	unsigned char* GetData();

	// Operations
	// Clean up
	//�ͷ��ڲ�����Ļ������ռ䣬��ռ�ÿռ�==�ڲ���������С
	void FreeExtra();
	//�ͷ��ڲ��������ռ�
	void RemoveAll();

	// Accessing elements
	unsigned char GetAt(unsigned long nIndex) const;
	void SetAt(unsigned long nIndex, unsigned char newElement);

	//�������������ڲ�ȫ��0�������ͷŻ�����
	void ClearContent();

	/*
	unsigned char& ElementAt(unsigned long nIndex);
	*/
	//�ڵ�ǰռ��������������ַ������ڳ�����ǰ��������С��λ�ò�����
	void SetAtGrow(unsigned long nIndex, unsigned char newElement);

	//�ڵ�ǰռ�����򣨶����ǻ�������ĩβ���һ���ַ�
	unsigned long Add(unsigned char newElement);

	//����һ������
	unsigned long Append(const CHByteArray& src);
	//�ڵ�ǰռ�����򣨶����ǻ�������ĩβ�������һ���ַ�������
	unsigned long Append(const unsigned char *data,unsigned long datalen);

	void Copy(const CHByteArray& src);
	void Copy(const unsigned char *data,unsigned long datalen);


	// Operations that move elements around
	/*
	void InsertAt(INT_PTR nIndex, BYTE newElement, INT_PTR nCount = 1);

	void RemoveAt(INT_PTR nIndex, INT_PTR nCount = 1);
	void InsertAt(INT_PTR nStartIndex, CByteArray* pNewArray);
	*/

	CHByteArray & operator = (const CHByteArray & oByteArray);
	CHByteArray & operator + (const CHByteArray & oByteArray);

	CHByteArray & operator += (const unsigned char ucByte);
	CHByteArray & operator += (const CHByteArray & oByteArray);
	bool operator == (const CHByteArray &oByteArray)	const;

protected:
	bool Equals(const CHByteArray & oByteArray) const;

	// Potentially growing the array
	void MakeArray(const unsigned char * pucData, unsigned long ulSize, unsigned long ulCapacity = 0);

	unsigned char	*m_pucData;
	unsigned long	m_ulSize;
	unsigned long	m_ulCapacity;
	bool			m_bMallocError;
	unsigned long	m_nGrowBy;   // grow amount

};

#endif