//
//  TypeDefines.h
//  eidapi
//
//  Created by eID Mobile Technology Team on 2011/3/11.
//  Copyright (c) 2015 Trimps. All rights reserved.
//

/** @file TypeDefines.h
 @brief 宏定义文件*/
typedef char TCHAR;
#define BYTE unsigned char
#define HANDLE void *

#ifndef _TYPE_DEFINES_H
#define _TYPE_DEFINES_H

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef EID_WIN32
#include <windows.h>
#include <tchar.h>
#define IMPORT
#define EXPORT
#define DLLHANDLE HMODULE
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if defined(EID_MACOS)  || defined(EID_IOS)
#define LogOpen()
#define LogClose()
#include <string.h>
#include <unistd.h>
#include <dlfcn.h>
#include <stdlib.h>
#define WINAPI
#define IMPORT
#define EXPORT
#define MAX_PATH 260
#define _T
#define HANDLE void *
#include <stdint.h>
#include <wchar.h>

typedef char CHAR;
typedef unsigned char BYTE;
//typedef unsigned long DWORD;
typedef long LONG;
typedef unsigned int UINT;
#define sprintf_s(buffer,size,format, ...) sprintf(buffer,format,__VA_ARGS__)

#ifndef TRUE
#define TRUE true
#endif

#define DWORD uint32_t

#ifndef FALSE
#define FALSE false
#endif

#ifndef NULL
#define NULL 0
#endif
#define A2W 
#define BOOL bool
#define _tcslen strlen
#define IN
#define OUT
#define strcpy_s(dest, num, src)  strncpy(dest, src, num)
#define sscanf_s(buffer, size,format,...) sscanf(buffer,format,__VA_ARGS__)
#define _stprintf sprintf
#define Sleep usleep
typedef char* LPTSTR;
typedef const char* LPCTSTR;
#define _tprintf printf
#define HMODULE void*
#define DLLHANDLE HMODULE
#define AfxGetStaticModuleState()
#define AFX_MANAGE_STATE(ABC)
#define CERT_V1     0
#define CERT_V2     1
#define CERT_V3     2
#define CALLBACK
#define GetProcAddress	dlsym
#define FreeLibrary		dlclose
#define LoadLibrary(lpDllName) dlopen(lpDllName, RTLD_LAZY)
#define __int64 __int64_t
#endif
typedef void*			FARPROC; /** define void pointer using name [FARPROC] */


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef EID_WINCE
#include <tchar.h>
#define IMPORT
#define EXPORT
//#define Sleep sleep
#define DLLHANDLE HMODULE
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef __SYMBIAN32__

#define IMPORT extern "C" IMPORT_C
#define EXPORT extern "C" EXPORT_C

#define HANDLE CSDConnectHandle*

#include <wchar.h>
#define TCHAR wchar_t
#define _tcslen wcslen
#define _tcscpy wcscpy
#define WCHAR wchar_t
#define _T

#include "e32std.h"
#define UINT32 TUint32
#define UINT8  TUint8

#define BYTE unsigned char
#define DWORD unsigned long

#define WINAPI
#define CALLBACK

#define HMODULE CSDSCDev*
#define DLLHANDLE RLibrary

#endif


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef EID_LINUX
#include <dlfcn.h>
#include "wintypes.h"

#define IMPORT
#define EXPORT
typedef char TCHAR;
#define _TCHAR char
#define _tmain main
//#define TCHSR char
//#define NULL 0
#define TRUE true
#define FALSE false
#define BOOL bool
#define HANDLE void*
#define HMODULE void*
#define LPCTSTR char*
#define WINAPI
#define _T
#define CALLBACK
#define DWORD unsigned long
#define UINT unsigned int

#define _tcslen strlen
#define LoadLibrary(lpDllName) dlopen(lpDllName, RTLD_LAZY)
#define GetProcAddress	dlsym
#define FreeLibrary		dlclose
typedef void*			FARPROC;
#define sprintf_s(buffer,size,format, ...) sprintf(buffer,format,__VA_ARGS__)
#define memcpy_s(dest,num,src,count) memcpy(dest,src,count)
#define fprintf_s fprintf
#define _strdate_s(buf,num) _strdate(buf)
#define _tprintf printf
#define _stprintf sprintf
#define strcat_s(dest,num,src) strcat(dest,src)
#define fopen_s(pf,name,mode) *pf=fopen(name,mode)
#define strncpy_s(dest,num,src,count) strncpy(dest,src,count)
#define localtime_s(tm,time) *tm=*localtime(time)
#define _strdup strdup
#define ZeroMemory(Destination,Length) memset((Destination),0,(Length))
#define HMODULE void*
#define DLLHANDLE HMODULE
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#if defined(EID_ANDROID)
#define IMPORT
#define EXPORT
#ifdef EID_IOS
#define TCHAR char
#define CHAR char
#else
typedef char TCHAR;
#endif
#define _TCHAR char
#define _tmain main
//#define TCHSR char
//#define NULL 0
#define Sleep sleep
#ifndef TRUE
#define TRUE true
#endif

#ifndef FALSE
#define FALSE false
#endif

#define BOOL bool

#if defined(EID_ANDROID)
#define HANDLE int
#endif

#if defined(EID_IOS)

#endif

#define HMODULE void*
#define WCHAR wchar_t
#define LPCTSTR char*
#define WINAPI
#define _T
#define CALLBACK
#define DWORD unsigned long
#define UINT unsigned int
#define BYTE unsigned char
#define _tcslen strlen
#define LoadLibrary(lpDllName) dlopen(lpDllName, RTLD_LAZY)
#define LoadLibraryA(lpDllName) dlopen(lpDllName, RTLD_LAZY)
#define GetProcAddress	dlsym
#define FreeLibrary		dlclose
typedef void*			FARPROC;
#define sprintf_s(buffer,size,format, ...) sprintf(buffer,format,__VA_ARGS__)
#define memcpy_s(dest,num,src,count) memcpy(dest,src,count)
#define fprintf_s fprintf
#define _strdate_s(buf,num) _strdate(buf)
#define _tprintf printf
#define _stprintf sprintf
#define strcat_s(dest,num,src) strcat(dest,src)
#define fopen_s(pf,name,mode) *pf=fopen(name,mode)
#define strncpy_s(dest,num,src,count) strncpy(dest,src,count)
#define localtime_s(tm,time) *tm=*localtime(time)
#define _strdup strdup
#define DLLHANDLE HMODULE
#define AfxGetStaticModuleState()
#define AFX_MANAGE_STATE(ABC)
#define LogOpen()
#define LogClose()
#endif

#endif
