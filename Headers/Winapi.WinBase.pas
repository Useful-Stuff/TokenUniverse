unit Winapi.WinBase;
{$MINENUMSIZE 4}

interface

uses
  Winapi.WinNt;

type
  TSecurityLogonType = (ltSystem, ltReserved, ltInteractive, ltNetwork, ltBatch,
    ltService, ltProxy, ltUnlock, ltNetworkCleartext, ltNewCredentials,
    ltRemoteInteractive, ltCachedInteractive, ltCachedRemoteInteractive,
    ltCachedUnlock);

  TLogonProvider = (lpDefault, lpWinNT35, lpWinNT40, lpWinNT50, lpVirtual);

// 2830
function LocalFree(hMem: Pointer): Pointer; stdcall; external kernel32;

// 3500
function GetCurrentProcessId: Cardinal; stdcall; external kernel32; // Move to nt

// 3932
function GetCurrentThreadId: Cardinal; stdcall; external kernel32; // Move to nt

// 4252
function GetLastError: Cardinal; stdcall; external kernel32;

// 7733
procedure OutputDebugStringW(lpOutputString: PWideChar); stdcall;
  external kernel32;

// 12236
function LookupAccountSidW(lpSystemName: PWideChar; Sid: PSID;
  Name: PWideChar; var cbName: Cardinal; ReferencedDomainName: PWideChar;
  var cbReferencedDomainName: Cardinal; out peUse: TSidNameUse): LongBool;
  stdcall; external advapi32;

// 12294
function LookupAccountNameW(lpSystemName, lpAccountName: PWideChar;
  Sid: PSID; var cbSid: Cardinal; ReferencedDomainName: PWideChar;
  var cbReferencedDomainName: Cardinal; out peUse: TSidNameUse): LongBool;
  stdcall; external advapi32;

// 12718
function LogonUserW (lpszUsername: PWideChar; lpszDomain: PWideChar;
  lpszPassword: PWideChar; dwLogonType: TSecurityLogonType; dwLogonProvider:
  TLogonProvider; out hToken: THandle): LongBool; stdcall; external advapi32;

// ???
function LogonUserExExW(lpszUsername: PWideChar; lpszDomain: PWideChar;
  lpszPassword: PWideChar; dwLogonType: TSecurityLogonType; dwLogonProvider:
  TLogonProvider; pTokenGroups: PTokenGroups; out hToken: THandle;
  ppLogonSid: PPointer; pProfileBuffer: PPointer; pdwProfileLength: PCardinal;
  QuotaLimits: Pointer): LongBool; stdcall; external advapi32;

implementation

end.
