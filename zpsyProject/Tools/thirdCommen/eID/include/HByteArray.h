/******************************************************************
胡永涛
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
	//pucData允许为NULL，此时只开辟内部ulSize大小的缓冲区，不初始化缓冲区的内容
	CHByteArray(const unsigned char * pucData, const unsigned long ulSize, unsigned long ulCapacity = 0);

	~CHByteArray();


	//返回内部缓冲区字节大小
	unsigned long GetSize() const;		//出错的情况下，返回ARRAY_ERROR_SIZE

	bool IsEmpty();
	//得到当前最大字符数组Index，相当于GetSize() - 1，
	unsigned long GetUpperBound() const;

	//调整内部缓冲区大小,nGrowBy是内存优化方式，暂不实现
	void SetSize(unsigned long nNewSize, int nGrowBy = -1);

	// Direct Access to the element data (may return NULL)
	const unsigned char* GetData() const;
	unsigned char* GetData();

	// Operations
	// Clean up
	//释放内部多余的缓冲区空间，已占用空间==内部缓冲区大小
	void FreeExtra();
	//释放内部缓冲区空间
	void RemoveAll();

	// Accessing elements
	unsigned char GetAt(unsigned long nIndex) const;
	void SetAt(unsigned long nIndex, unsigned char newElement);

	//把整个缓存区内部全填0，但不释放缓冲区
	void ClearContent();

	/*
	unsigned char& ElementAt(unsigned long nIndex);
	*/
	//在当前占用区域后面设置字符（可在超过当前缓冲区大小的位置操作）
	void SetAtGrow(unsigned long nIndex, unsigned char newElement);

	//在当前占用区域（而不是缓冲区）末尾添加一个字符
	unsigned long Add(unsigned char newElement);

	//加入一个对象
	unsigned long Append(const CHByteArray& src);
	//在当前占用区域（而不是缓冲区）末尾后面加入一个字符串数组
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