unit utilVersion;

interface

type
  TEXEVersionData = record
    CompanyName, FileDescription, FileVersion, InternalName, LegalCopyright,
      LegalTrademarks, OriginalFileName, ProductName, ProductVersion, Comments,
      PrivateBuild, SpecialBuild: string;
  end;

// Get the file version of the application.
function GetEXEVersionData(const FileName: string): TEXEVersionData;
function FileDescription: String; // 'An application that .... '
function LegalCopyright: String; // 'Copyright 2019-2022'
function ProductVersion: String; // Major.Minor
function FileVersion: String; // Major.Minor.Release.Build

// EXAMPLE :: Proprietary KEY. Must be manually entered by the developer.
// Use ADDKEY (Right Mouse Menu) in DELPHI RAD - Project.Options.Version Info
function DateOfRelease: String;

implementation

uses
  Winapi.Windows, System.SysUtils, System.Classes, Math;

function GetVersionInfo(AIdent: String): String;
type
  TLang = packed record
    Lng, Page: WORD;
  end;
  TLangs = array [0 .. 10000] of TLang;
  PLangs = ^TLangs;
var
  BLngs: PLangs;
  BLngsCnt: Cardinal;
  BLangId: String;
  RM: TMemoryStream;
  RS: TResourceStream;
  BP: PChar;
  BL: Cardinal;
  BId: String;

begin
  // Assume error
  Result := '';

  RM := TMemoryStream.Create;
  try
    // Load the version resource into memory
    RS := TResourceStream.CreateFromID(HInstance, 1, RT_VERSION);
    try
      RM.CopyFrom(RS, RS.Size);
    finally
      FreeAndNil(RS);
    end;
    // Extract the translations list
    if not VerQueryValue(RM.Memory, '\\VarFileInfo\\Translation',
      Pointer(BLngs), BL) then
      Exit; // Failed to parse the translations table
    BLngsCnt := BL div sizeof(TLang);
    if BLngsCnt <= 0 then
      Exit; // No translations available
    // Use the first translation from the table (in most cases will be OK)
    with BLngs[0] do
      BLangId := IntToHex(Lng, 4) + IntToHex(Page, 4);
    // Extract field by parameter
    BId := '\\StringFileInfo\\' + BLangId + '\\' + AIdent;
    if not VerQueryValue(RM.Memory, PChar(BId), Pointer(BP), BL) then
      Exit; // No such field
    // Prepare result
    Result := BP;
  finally
    FreeAndNil(RM);
  end;
end;

function FileDescription: String;
begin
  Result := GetVersionInfo('FileDescription');
end;

function LegalCopyright: String;
begin
  Result := GetVersionInfo('LegalCopyright');
end;

function DateOfRelease: String;
begin
  Result := GetVersionInfo('DateOfRelease');
end;

function ProductVersion: String;
begin
  Result := GetVersionInfo('ProductVersion');
end;

function FileVersion: String;
begin
  Result := GetVersionInfo('FileVersion');
end;

function GetAppVersionStr: string;
var
  Exe: string;
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFIXEDFILEINFO;
begin
  Exe := ParamStr(0);
  Size := GetFileVersionInfoSize(PChar(Exe), Handle);
  if Size = 0 then
    RaiseLastOSError;
  SetLength(Buffer, Size);
  if not GetFileVersionInfo(PChar(Exe), Handle, Size, Buffer) then
    RaiseLastOSError;
  if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
    RaiseLastOSError;
  Result := Format('%d.%d.%d.%d', [LongRec(FixedPtr.dwFileVersionMS).Hi,
    // major
    LongRec(FixedPtr.dwFileVersionMS).Lo, // minor
    LongRec(FixedPtr.dwFileVersionLS).Hi, // release
    LongRec(FixedPtr.dwFileVersionLS).Lo]) // build
end;

function GetEXEVersionData(const FileName: string): TEXEVersionData;
type
  PLandCodepage = ^TLandCodepage;

  TLandCodepage = record
    wLanguage, wCodePage: WORD;
  end;
var
  dummy, len: Cardinal;
  buf, pntr: Pointer;
  lang: string;
begin
  len := GetFileVersionInfoSize(PChar(FileName), dummy);
  if len = 0 then
    RaiseLastOSError;
  GetMem(buf, len);
  try
    if not GetFileVersionInfo(PChar(FileName), 0, len, buf) then
      RaiseLastOSError;

    if not VerQueryValue(buf, '\VarFileInfo\Translation\', pntr, len) then
      RaiseLastOSError;

    lang := Format('%.4x%.4x', [PLandCodepage(pntr)^.wLanguage,
      PLandCodepage(pntr)^.wCodePage]);

    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\CompanyName'),
      pntr, len) { and (@len <> nil) } then
      Result.CompanyName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileDescription'),
      pntr, len) { and (@len <> nil) } then
      Result.FileDescription := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\FileVersion'),
      pntr, len) { and (@len <> nil) } then
      Result.FileVersion := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\InternalName'),
      pntr, len) { and (@len <> nil) } then
      Result.InternalName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalCopyright'),
      pntr, len) { and (@len <> nil) } then
      Result.LegalCopyright := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\LegalTrademarks'),
      pntr, len) { and (@len <> nil) } then
      Result.LegalTrademarks := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang +
      '\OriginalFileName'), pntr, len) { and (@len <> nil) } then
      Result.OriginalFileName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductName'),
      pntr, len) { and (@len <> nil) } then
      Result.ProductName := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\ProductVersion'),
      pntr, len) { and (@len <> nil) } then
      Result.ProductVersion := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\Comments'), pntr,
      len) { and (@len <> nil) } then
      Result.Comments := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\PrivateBuild'),
      pntr, len) { and (@len <> nil) } then
      Result.PrivateBuild := PChar(pntr);
    if VerQueryValue(buf, PChar('\StringFileInfo\' + lang + '\SpecialBuild'),
      pntr, len) { and (@len <> nil) } then
      Result.SpecialBuild := PChar(pntr);
  finally
    FreeMem(buf);
  end;

end;

end.
