unit StrGeneral;

interface

uses Windows, Globals, SysUtils, StdCtrls, Classes, SHFolder, General, Dialogs;

type LStrRec = record
       AllocSize : Longint;
       RefCount  : Longint;
       Length    : Longint;
     end;
const StMaxFileLen  = 260;
      DosDelimSet  : set of AnsiChar = ['\', ':', #0];
      DosDelimSetW : WideString = '\:';
      StrOffset = SizeOf (LStrRec);

Procedure SetCaption (var control : tLabel; s : String);
Function GetCaption (control : tLabel) : AnsiString;
Function GetEditText (control : tEdit) : shortString;
Function Pos (const substr : shortString; const str : shortString) : integer; overload;
Function Trim (const s : shortString) : shortstring;    overload;
Function Trim (const s : ansiString) : ansistring;    overload;
Function CharExists (C : char; S : string) : boolean;    overload;
function CharExists (const S : String; C : Char) : Boolean; register; overload;
function WordCount (const S, WordDelims : String) : word;  overload;
Function CharCount (const ch : char; s : string) : integer;
function ExtractWord (N : Cardinal; const S, WordDelims : String) : String; overload
function ExtractWord (N : Cardinal; const S, WordDelims : ShortString) : ShortString; overload
function ExtractWord (N : Cardinal; const S : ansistring; WordDelims : String) : AnsiString; overload
function StrStPos (const P, S : String; var Pos : Cardinal) : Boolean;
Function Filter (Const F, S : string) : string;
function StrChPos (const P : String; C : Char; var Pos : Cardinal) : Boolean;
function Substitute (const S, FromStr, ToStr : String) : String;
function TrimChars (const S, Chars : String) : String;
function RightTrimChars (const S, Chars : String) : String;
function LeftTrimChars (const S, Chars : String) : String;
Function RemoveChar (const s : string; ch : ansiChar) : string;
Function LastCh (const s : string) : char;
function StripHTML (S: string): string;

{File related functions--------------------------------------------------------}
Function DOSString (const S : string) : string;
function HasExtension (const Name : String; var DotPos : word) : Boolean;
Function JustNoExtension (name : string) : string;
Function JustName (fName : string) : string;
Function JustExtension (fName : string) : string;
Procedure CopyFile (source, target : fNameType);
Function IsFileReadOnly (fName : fNameType): boolean;
Function IsDirReadOnly (dName, s : string; var errMsg : string): integer;
function GetSpecialFolderPath (folder : integer) : string;
Procedure MyChDir (s : fNameType);
Function GetFileSize (s : fNameType) : longint;
Function GetFileSize64 (s : string) : int64;
function GetFileAge (const FileName: AnsiString): Integer;              overload;
function GetFileAge (const FileName: String): Integer;                  overload;
Function FileIsASCII (const FileName : string;const chkSize : integer) : boolean;
Function RemoveFile (const fName : string) : integer;           //0= success; 1= error
Function IsDirWriteable (const aName : string) : boolean;
Function CheckName4spaces (f : string) : boolean;
Function CheckAndMakeDir (path, dir : string; silent : boolean) : integer;
Function CheckDeleteFile (f : string) : boolean;
Function CountFiles (dr, pattern : string) : integer;

{StStrL functions--------------------------------------------------------------}
function AnsiPadCh (const S : AnsiString; C : AnsiChar; Len : Integer) : AnsiString;
function PadCh (const S : String; C : Char; Len : Integer) : String; overload;
function RightTrimCharsL (const S, Chars : String) : String;
Function Uppercase (const s : AnsiString) : Ansistring;  overload;
  {-Determines whether a given character exists in a string. }
function WordCountL (const S, WordDelims : String) : Integer;
  {-Given an array of word delimiters, return the number of words in a string.}
function ExtractWordL (N : Cardinal; const S, WordDelims : String) : String; OverLoad;
function StrStDeleteL (const S : AnsiString; Pos, Count : Cardinal) : AnsiString;
function StrStDelete (const S : String; Pos, Count : Cardinal) : String;
function CopyLeftL (const S : AnsiString; Len : Cardinal) : AnsiString;
function TrimCharsL (const S, Chars : String) : String;
function Str2LongL (const S : AnsiString; var I : LongInt) : Boolean;
function ReplaceStringAll (const S, OldStr, NewStr : String;
                                 var Replacements : integer) : String; overload;
Function Parse_line (var line : String; delim : char; cut : boolean) : String;     Overload;

{---StStrS functions---}
Function Parse_line (var line : shortString; delim : ansichar; cut : boolean) : AnsiString; Overload;
Function ParseLineFrom (var line : shortString; from : integer) : shortString;
  {-Pad a string on the right with spaces.}
function PadCh (const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;  OverLoad;
function CharStrS (C : AnsiChar; Len : Cardinal) : ShortString;
  {-Return a string filled with the specified character.}
function CharExistsS (const S : ShortString; C : AnsiChar) : Boolean;
function SubstituteS (const S, FromStr, ToStr : ShortString) : ShortString;
function ReplaceString (const S, OldString, NewString : ShortString; N : Cardinal;
                        var Replacements : Cardinal) : ShortString;  overload;
function ReplaceString (const S, OldString, NewString : String; N : integer;
                           var Replacements : integer) : String;       overload;
function ReplaceStringAll (const S, OldString, NewString : ShortString;
                           var Replacements : Cardinal) : ShortString; overload;
function FilterS (const S, Filters : ShortString) : ShortString;
function StrStDeleteS (const S : ShortString; Pos, Count : Cardinal) : ShortString;
  {-Delete characters at a specified position in a string.}
function Real2StrS (R : Double; Width : Byte; Places : ShortInt) : ShortString;
function LeftPadCh (const S : String; C : AnsiChar; Len : Cardinal) : String;
  {-Pad a string on the left with a specified character.}
function RightTrimCharsS (const S, Chars : ShortString) : ShortString;
function WordPosition (N : Cardinal; const S, WordDelims : ShortString;
                                                  var Pos : Cardinal) : Boolean;  overload;
function WordPosition (N : Cardinal; const S, WordDelims : String;
                                                  var Pos : Cardinal) : Boolean;  overload;
function StrStPosS (const P, S : ShortString; var Pos : Cardinal) : Boolean;
function TrimS (const S : ShortString) : ShortString;
function WordCountS (const S, WordDelims : ShortString) : Cardinal;
function Str2ExtS (const S : ShortString; var R : Extended) : Boolean;
function JustExtensionS (const Name : ShortString) : ShortString;
function HasExtensionS (const Name : ShortString; var DotPos : Cardinal) : Boolean;
function Str2RealS (const S : ShortString; var R : real) : Boolean;
function JustFilename (const PathName : ShortString) : ShortString;    overload;
function JustFilename (const PathName : String) : String;              overload;
function CompUCString (S1, S2 : ShortString) : Integer;                overload;
function CompUCString (S1, S2 : String) : Integer;                     overload;
procedure WordWrapS (const InSt : ShortString; var OutSt, Overlap : ShortString;
                                      Margin : Cardinal; PadToMargin : Boolean);
function StrChPosS (const P : ShortString; C : AnsiChar; var Pos : Cardinal) : Boolean;
function JustPathnameS (const PathName : ShortString) : ShortString;
function ValPrepS (const S : ShortString) : ShortString;

procedure ExchangeStructs (var I, J; Size : Cardinal);

implementation

{-----------------------------------------------------------------------------}

Procedure SetCaption (var control : tLabel; s : String);
begin
  control.caption := String (s);
end;

{-----------------------------------------------------------------------------}

Function GetCaption (control : tLabel) : AnsiString;
begin
  if Length (control.Caption) > 255 then
    Result := ShortString (Copy (Control.Caption, 1, 255))
  else Result := ShortString (control.caption);
end;

{-----------------------------------------------------------------------------}

Function GetEditText (control : tEdit) : shortString;
begin
  Result := ShortString (control.Text);
end;

{-----------------------------------------------------------------------------}

Function Pos (const substr : shortString; const str : shortString) : integer; overload;
begin
  result := Pos (rawbyteString (subStr), rawbyteString (str));
end;

{-----------------------------------------------------------------------------}

function Trim (const S : ShortString) : ShortString;                    overload;
  {-Return a string with leading and trailing spaces removed.}
var  I : Word;
begin
  Result := S;
  while (Length (Result) > 0) and (Result [Length (Result)] = ' ') do
    Dec (Result [0]);
  I := 1;
  while (I <= Length (Result)) and (S [I] = ' ') do
    Inc (I);
  Dec (I);
  if I > 0 then
    Delete (Result, 1, I);
end;

{-----------------------------------------------------------------------------}

Function Trim (const s : ansiString) : ansistring;    overload;
var  i,  j : Word;
begin
  i := Length (s);
  while s [i] = ' ' do
    Dec (i);
  j := 1;
  while (j <= i) and (S [j] = ' ') do
    Inc (j);
  Result := Copy (S, j, i - j + 1);
end;

{-----------------------------------------------------------------------------}

Function CharExists (C : char; S : string) : boolean;
begin
  Result := Bool (Pos (C, S) > 0);
end;

function CharExists (const S : String; C : Char) : Boolean;
begin
  Result := Bool (Pos (C, S) > 0);
end;

{-----------------------------------------------------------------------------}

function WordCount (const S, WordDelims : String) : word;
  {-Given an array of word delimiters, return the number of words in a string.}
var  I,  SLen   : Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do
  begin
    while (I <= SLen) and CharExists (S[I], WordDelims) do     {skip over delimiters}
      Inc(I);
    if I <= SLen then                                  {if we're not beyond end of S, we're at the start of a word}
      Inc(Result);
    while (I <= SLen) and not CharExists (S[I], WordDelims) do  {find the end of the current word}
      Inc(I);
  end;
end;
{-----------------------------------------------------------------------------}

Function CharCount (const ch : char; s : string) : integer;
var i : integer;
begin
  result := 0;
  for i := 1 to Length (s) do
    if S [i] = ch then
      Inc (result);
end;

{-----------------------------------------------------------------------------}

function ExtractWord (N : Cardinal; const S, WordDelims : String) : String;
  {-Given an array of word delimiters, return the N'th word in a string.}
var C   : Cardinal;             I, J   : Longint;
begin
  Result := '';
  if WordPosition (N, S, WordDelims, C) then
  begin
    I := C;
    J := I;
    while (I <= Length (S)) and not CharExists (S [I], WordDelims) do
      Inc (I);                                               {find the end of the current word}
    SetLength (Result, I - J);
    Move (S [J], Result [1], (I - J) * SizeOf (Char));
  end;
end;

{-----------------------------------------------------------------------------}

function ExtractWord (N : Cardinal; const S, WordDelims : ShortString) : ShortString;
  {-Given an array of word delimiters, return the N'th word in a string.}
var I : Cardinal;           Len  : Byte;             SLen : Byte absolute S;
begin
  Len := 0;
  if WordPosition (N, S, WordDelims, I) then
    {find the end of the current word}
    while (I <= SLen) and not CharExistsS (WordDelims, S [I]) do
    begin
      {add the I'th character to result}
      Inc (Len);
      Result [Len] := S [I];
      Inc (I);
    end;
  Result [0] := AnsiChar (Len);
end;

{-----------------------------------------------------------------------------}

function ExtractWord (N : Cardinal; const S : ansistring; WordDelims : String) : AnsiString;
  {-Given an array of word delimiters, return the N'th word in a string.}
begin
  result := ExtractWord (N, ShortString (S), ShortString (WordDelims));
end;

{-----------------------------------------------------------------------------}

function StrStPos (const P, S : String; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified substring within a string.}
begin
  Pos := System.Pos (S, P);
  Result := Pos <> 0;
end;

{-----------------------------------------------------------------------------}

Function Filter (Const F, S : string) : string;
//filter string S for char in string F
var tmp : string;            i : integer;
begin
  tmp := '';
  for i := 1 to Length (s) do
    if not CharExists (S [i], F) then
      tmp := tmp + S [i];
  result := tmp;
end;

{-----------------------------------------------------------------------------}

function StrChPos (const P : String; C : Char; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified character within a string.}
var i : integer;
begin
  Result := true;
  for i := 1 to length (P) do
    if (P [i] = C) then
    begin
      Pos := i;
      Exit;
    end;
  Result := false;
  Pos := 0;
end;

{-----------------------------------------------------------------------------}

function Substitute (const S, FromStr, ToStr : String) : String;
  {-Map the characters found in FromStr to the corresponding ones in ToStr.}
var i, P : Cardinal;
begin
  Result := S;
  if Length (FromStr) = Length (ToStr) then
    for i := 1 to Length (Result) do begin
      if StrChPos (FromStr, S [I], P) then
        Result [I] := ToStr [P];
    end;
end;

{-----------------------------------------------------------------------------}

function TrimChars (const S, Chars : String) : String;
begin
  Result := RightTrimChars (S, Chars);
  Result := LeftTrimChars (Result, Chars);
end;

{-----------------------------------------------------------------------------}

function RightTrimChars (const S, Chars : String) : String;
begin
  Result := S;
  while (Result <> '') and (Pos (Result [Length (Result)], Chars) > 0) do
    System.Delete (Result, Length (Result), 1);
end;

{-----------------------------------------------------------------------------}

function LeftTrimChars (const S, Chars : String) : String;
begin
  Result := S;
  while (Result <> '') and (pos (Result [1], Chars) > 0) do
    System.Delete (Result, 1, 1);
end;

{------------------------------------------------------------------------------}

Function RemoveChar (const s : string; ch : ansiChar) : string;
var i : integer;
begin
  result := '';
  for i := 1 to Length (s) do
    if AnsiChar (s [i]) <> ch then
      result := result + s [i];
end;

{------------------------------------------------------------------------------}

Function LastCh (const s : string) : char;
begin                                        //returns last character in a string
  result := s [Length (s)];
end;

{------------------------------------------------------------------------------}

function StripHTML (S: string): string;
var TagBegin, TagEnd, TagLength: integer;
begin
  TagBegin := Pos( '<', S);            // search position of first <
  while (TagBegin > 0) do
  begin                                // while there is a < in S
    TagEnd := Pos('>', S);             // find the matching >
    TagLength := TagEnd - TagBegin + 1;
    Delete(S, TagBegin, TagLength);    // delete the tag
    TagBegin:= Pos( '<', S);           // search for next <
  end;
  Result := S;                         // give the result
end;

{================ File utilities ==============================================}

Function DOSString (const S : string) : string;     //returns a valid DOS string witout space char
var i : integer;
begin
  result := '';
  for i := 1 to Length (s) do
    if s [i] = ' ' then
      result := result + '%20'
    else result := result + s[i];
end;

{-----------------------------------------------------------------------------}

function HasExtension (const Name : String; var DotPos : word) : Boolean;
var i : word;
begin
  DotPos := 0;
  for i := Length (Name) downto 1 do
    if (Name [i] = '.') then
    begin
      DotPos := i;
      Break;
    end;
  Result := (DotPos > 0)
//    and not CharExistsW(System.Copy(Name, Succ(DotPos), StMaxFileLen), '\');
end;

{-----------------------------------------------------------------------------}

Function JustNoExtension (name : string) : string;
//returns whole path and name, but without extension
begin
  Result := ExtractFileDir (name) + '\' + JustName (name);
end;

{-----------------------------------------------------------------------------}

Function JustName (fName : string) : string;
var   dotPos : word;
begin
  Result := ExtractFileName (fName);
  if HasExtension (Result, dotpos) then
    Result := System.Copy (Result, 1, DotPos-1);
end;

{-----------------------------------------------------------------------------}

Function JustExtension (fName : string) : string;
begin                                             //extension without the dot '.'
  Result := ExtractFileExt (fName);
  if Result [1] = '.' then
    Result := Copy (result, 2, Length (result) - 1);
end;

{-----------------------------------------------------------------------------}

Procedure CopyFile (source, target : fNameType);
var stream1, stream2 : tFileStream;
begin
  stream1 := tFileStream.Create (source, fmOpenRead);
  try
    stream2 := tFileStream.Create (target, fmOpenWrite or fmCreate);
    try
      Stream2.CopyFrom (stream1, stream1.size)
    finally
      stream2.free;
    end;
  finally
    stream1.Free;
  end;
end;

{-----------------------------------------------------------------------------}

Function IsFileReadOnly (fName : fNameType): boolean;
var n : integer;
begin
  n := FileGetAttr (fName);
  result := ((n and faReadOnly) > 0);
end;

{-----------------------------------------------------------------------------}

Function IsDirReadOnly (dName, s : string; var errMsg : string): integer;
var f : TextFile;          fName : string;            //errMsg is directory function
begin
  result := -4;
  errMsg := 'Write error in ' + s + ' directory';
  if ((FileGetAttr (pChar (dName)) and faReadOnly) = faReadOnly) then
    Exit
  else result := 0;
  errMsg := 'No write error found in ' + s + ' directory';
  if not DirectoryExists (dName) then
  begin
    result := -1;
    errMsg := 'Cannot find ' + s + ' directory';
  end else begin
    dName := InclBackslash (dName);
    fName := dName + 'gpmawTest.txt';
    FileMode := 2;
    AssignFile (f, fName);
    {$I-}
    ReWrite(F);
    {$I+}
//    WriteLn (f, 'test');
    if IOResult <> 0 then
    begin
      Result := -3;
      errMsg := 'Cannot write to ' + s + ' directory';
    end else
      CloseFile (f);
    if FileExists (fName) then
      if not SysUtils.DeleteFile (fName) then
      begin
        result := -2;
        errMsg := 'Cannot delete files in ' + s + ' directory';
      end;
  end;
end;

{-----------------------------------------------------------------------------}

function GetSpecialFolderPath (folder : integer) : string;
const SHGFP_TYPE_CURRENT = 0;
var path: array [0..MAX_PATH] of char;
begin
 if SUCCEEDED (SHGetFolderPath (0, folder, 0, SHGFP_TYPE_CURRENT, @path[0])) then
   Result := IncludeTrailingPathDelimiter (path)
 else Result := '';
end;

{-----------------------------------------------------------------------------}

Procedure MyChDir (s : fNameType);
begin
 {$I-} ChDir (ExcludeTrailingBackslash (s)); {$I+}
  if IOResult <> 0 then
    MyMsgDlg ('Unable to find directory§' + s, mtInformation, [mbOK], 0);
end;

{-----------------------------------------------------------------------------}

Function GetFileSize (s : fNameType) : longint;
var f : file;
begin
  Result := -1;
  if not FileExists (s) then Exit;
  Filemode := 0;                    //read only
  Assign (f, s);
  Reset (f, 1);
  Result := FileSize (f);
  Closefile (f);
  FileMode := 2;                    //read/write
end;

{-----------------------------------------------------------------------------}

Function GetFileSize64 (s : string) : int64;
var sr : tSearchRec;
begin
  Result := -1;
  if not FileExists (s) then Exit;
  if FindFirst (s, faAnyfile, sr) = 0 then
    result := sr.Size
  else result := -1;
  FindClose (sr);
end;

{-----------------------------------------------------------------------------}

function GetFileAge (const FileName: AnsiString): Integer;
var  s : string;
begin
  s := String (FileName);
  Result := GetFileAge (s);
end;

{-----------------------------------------------------------------------------}

function GetFileAge (const FileName: String): Integer;
var Handle: THandle;               FindData: TWin32FindData;
    LocalFileTime: TFileTime;      s : string;
begin
  s := String (FileName);
  Handle := FindFirstFile (pChar (s), FindData);
  Result := -1;
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose (Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
    begin
      FileTimeToLocalFileTime (FindData.ftLastWriteTime, LocalFileTime);
      if FileTimeToDosDateTime (LocalFileTime, LongRec (Result).Hi,
                                                       LongRec (Result).Lo) then
        Exit;
    end;
  end;
  Result := -1;
end;

{-----------------------------------------------------------------------------}

Function FileIsASCII (const FileName : string;const chkSize : integer) : boolean;
var f : file;          buf : array [1..20000] of byte;
    i, n, nn : integer;
begin
  Result := false;
  if not FileExists (FileName) then Exit;
  Filemode := 0;                    //read only
  Assign (f, FileName);
  Reset (f, 1);
  result := true;
  n := Min (chkSize, 20000);
  n := Min (FileSize (f), n);
  BlockRead (f, buf, n, nn);
  for i := 1 to nn do
    if buf [i] in [0..8, 11, 12, 14..31] then
      result := false;
  Closefile (f);
  FileMode := 2;                    //read/write
end;

{-----------------------------------------------------------------------------}

Function RemoveFile (const fName : string) : integer;           //0= success; 1= error
begin
  result := Ord (FileExists (fName));
  if result = 0 then
    DeleteFile (fName);
end;

{-----------------------------------------------------------------------------}

function IsDirWriteable (const AName: string): Boolean;
var FileName: String;                H: hFile;
begin
  FileName := IncludeTrailingPathDelimiter (AName) + 'chk.tmp';
  H := CreateFile (PChar (FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
          CREATE_NEW, FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE, 0);
  Result := (H <> INVALID_HANDLE_VALUE);
  if Result then
    CloseHandle (H);
end;

{-----------------------------------------------------------------------------}

Function CheckName4spaces (f : string) : boolean;
begin
  if Pos (' ', f) = 0 then
    result := true
  else begin
    MyMsgDlg ('The selected directory/filename:§' + f + '§contains space characters§§' +
             'Please rename/move file to a location without', mtError, [mbOK], 0);
    result := false;
  end;
end;

{----------------------------------------------------------------------------}

Function CheckAndMakeDir (path, dir : string; silent : boolean) : integer;
//result: 0=directory exists; 1=directory created; 2=failed creating directory
begin
  path := InclBackslash (path);
  result := 0;
  if not DirectoryExists (path + dir) then               //system files
  begin
    result := 1;
    if not CreateDir (path + dir) then
    begin
      if not silent then
        MyMsgDlg ('Unable to create directory:§' + path + dir, mtError, [mbOK], 0);
      result := 2;
    end;
  end;
end;

{----------------------------------------------------------------------------}

Function CheckDeleteFile (f : string) : boolean;

begin
  result := false;
  if FileExists (f) then
    result := Deletefile (f);
end;

{----------------------------------------------------------------------------}

Function CountFiles (dr, pattern : string) : integer;
var searchRec : tSearchRec;
begin
  result := 0;
  SetCurrentDir (dr);
try
  if FindFirst (pattern, faAnyFile, searchRec) = 0 then
  begin
    FInc (result);
    while FindNext (searchRec) = 0 do
      FInc (result);
  end;
finally
  FindClose (searchRec);
end;
end;

{================ StStr utilities ======StStrL=================================}

function PadCh (const S : String; C : Char; Len : Integer) : String;
var i: Integer;
begin                   {-Pad a string on the right with a specified character.}
  Result := S;
  if Length (S) < Len then
    for i := Length (s) to Len do
      result := result + C;
end;

{----------------------------------------------------------------------------}

function RightTrimCharsL (const S, Chars : String) : String;
var CutOff : integer;
begin
  CutOff := length (S);
  while (CutOff > 0) do begin
    if not CharExists (Chars, S [CutOff]) then
      Break;
    dec (CutOff);
  end;
  if (CutOff = 0) then
    Result := ''
  else Result := Copy (S, 1, CutOff);
end;

{----------------------------------------------------------------------------}

function LeftTrimCharsL (const S, Chars : String) : string;
var CutOff, LenS   : integer;
begin
  LenS := length (S);
  CutOff := 1;
  while (CutOff <= LenS) do
  begin
    if not CharExists (Chars, S [CutOff]) then
      Break;
    inc (CutOff);
  end;
  if (CutOff > LenS) then
    Result := ''
  else Result := Copy (S, CutOff, LenS - CutOff + 1);
end;

{----------------------------------------------------------------------------}

Function Uppercase (const s : AnsiString) : Ansistring;  overload;
var i : integer;
begin
  result := '';
  for i := 1 to Length (s) do
    result := result + UpCase (s [i]);
end;

{-----------------------------------------------------------------------------}

function WordPosition (N : Cardinal; const S, WordDelims : String;
                                                 var Pos : Cardinal) : Boolean;
//-Given an array of word delimiters, set Pos to the start position of the
//    N'th word in a string.  Result indicates success/failure.
var Count, i : Longint;
begin
  Count := 0;
  i := 1;
  Result := False;
  while (i <= Length (S)) and (Count <> LongInt (N)) do begin      {skip over delimiters}
    while (i <= Length (S)) and CharExists (WordDelims, S [i]) do
      Inc (i);
    if i <= Length (S) then         //if we're not beyond end of S, we're at the start of a word
      Inc (Count);
    if Count <> LongInt (N) then    //if not finished, find the end of the current word
      while (i <= Length (S)) and not CharExists (WordDelims, S [i]) do
        Inc (i)
    else begin
      Pos := i;
      Result := True;
    end;
  end;
end;

{-----------------------------------------------------------------------------}

function WordPosition (N : Cardinal; const S, WordDelims : ShortString;
                                                  var Pos : Cardinal) : Boolean;
  {-Given an array of word delimiters, set Pos to the start position of the
    N'th word in a string.  Result indicates success/failure.}
var I     : Cardinal;          Count : Byte;         SLen  : Byte absolute S;
begin
  Count := 0;
  I := 1;
  Result := False;
  while (I <= SLen) and (Count <> N) do
  begin                                   {skip over delimiters}
    while (I <= SLen) and CharExistsS (WordDelims, S [I]) do
      Inc (I);
    if I <= SLen then                    {if we're not beyond end of S, we're at the start of a word}
      Inc (Count);
    if Count <> N then                   {if not finished, find the end of the current word}
      while (I <= SLen) and not CharExistsS (WordDelims, S [I]) do
        Inc (I)
    else begin
      Pos := I;
      Result := True;
    end;
  end;
end;

{-----------------------------------------------------------------------------}

function WordCountL (const S, WordDelims : String) : Integer;
  {-Given an array of word delimiters, return the number of words in a string.}
var  i : Cardinal;            SLen : Cardinal;
begin
  Result := 0;
  i := 1;
  SLen := Length(S);
  while i <= SLen do
  begin                       {skip over delimiters}
    while (i <= SLen) and CharExists (WordDelims, S [i]) do
      Inc(i);
    if i <= SLen then      {if we're not beyond end of S, we're at the start of a word}
      Inc(Result);
    while (i <= SLen) and not CharExists (WordDelims, S [i]) do  {find the end of the current word}
      Inc(i);
  end;
end;

{-----------------------------------------------------------------------------}

function ExtractWordL (N : Cardinal; const S, WordDelims : String) : String;
var C : Cardinal;               i, j   : Longint;
begin
  Result := '';
  if WordPosition (N, S, WordDelims, C) then
  begin
    i := C;
    j := i;                                   //find the end of the current word
    while (i <= Length (S)) and not CharExists (WordDelims, S [i]) do
      Inc (i);
    SetLength (Result, i - j);
    Move (S [j], Result [1], (i - j) * SizeOf (Char));
  end;
end;

{-----------------------------------------------------------------------------}

function StrStDeleteL (const S : AnsiString; Pos, Count : Cardinal) : AnsiString;
  {-Delete characters at a specified position in a string.}
begin
  Result := S;
  System.Delete (Result, Pos, Count);
end;

{----------------------------------------------------------------------------}

function StrStDelete (const S : String; Pos, Count : Cardinal) : String;
  {-Delete characters at a specified position in a string.}
begin
  Result := S;
  System.Delete (Result, Pos, Count);
end;

{----------------------------------------------------------------------------}

function CopyLeftL (const S : AnsiString; Len : Cardinal) : AnsiString;
  {-Return the left Len characters of a string}
begin
  if (Len < 1) or (S = '') then
    Result := ''
  else Result := Copy(S, 1, Len);
end;

{----------------------------------------------------------------------------}

function AnsiPadCh(const S : AnsiString; C : AnsiChar; Len : Integer) : AnsiString;
  {-Pad a string on the right with a specified character.}
begin
  if Length (S) >= Len then
    Result := S
  else begin
    SetLength (Result, Len);
    if Length (S) > 0 then               { copy current contents (if any) of S to Result }
      Move (S [1], Result [1], Length (S));
    FillChar (Result [Succ (Length (S))], Len - Length (S), C);   { add pad chars }
  end;
end;

{----------------------------------------------------------------------------}

function TrimCharsL (const S, Chars : String) : String;
begin
  Result := RightTrimCharsL (S, Chars);
  Result := LeftTrimCharsL (Result, Chars);
end;

{----------------------------------------------------------------------------}

function Str2LongL (const S : AnsiString; var I : LongInt) : Boolean;
  {-Convert a string to a long integer.}
var ec : Integer;
begin
  Val (S, I, ec);
  result := (ec = 0);
end;

{-----------------------------------------------------------------------------}

function ReplaceStringAll (const S, OldStr, NewStr : String;
                                    var Replacements : integer) : String;
var I, C, P1 : integer;          Tmp: String;
begin
  Result := S;
  if (S = '') or (OldStr = '') or (System.Pos (OldStr, S) = 0) then
    Replacements := 0
  else begin
    Tmp := S;
    P1 := System.Pos (OldStr, S);
    if (P1 > 0) then
    begin
      Result := Copy (Tmp, 1, P1-1);
      C := 0;
      while (P1 > 0) do
      begin
        for I := 1 to Replacements do
        begin
          Inc (C);
          Result := Result + NewStr;
        end;
        Tmp := Copy (Tmp, P1 + Length (OldStr), MaxInt);
        P1 := System.Pos (OldStr, Tmp);
        if (P1 > 0) then
          Result := Result + Copy (Tmp, 1, P1-1)
        else Result := Result + Tmp;
      end;
      replacements := C;
    end else
      replacements := 0;
  end;
end;

{=============================================================================}

function LeftPadCh (const S : String; C : AnsiChar; Len : Cardinal) : String;
  {-Pad a string on the left with a specified character.}
var i, n : cardinal;             s0 : string;
begin
  if Cardinal (Length (S)) >= Len then
    Result := S
  else begin
    n := len - Cardinal (Length (s));
    s0 := '';
    for i := 1 to n do
      s0 := s0 + c;
    result := s0 + s;
  end;
end;

{----------------------------------------------------------------------------}

function SubstituteS(const S, FromStr, ToStr : ShortString) : ShortString;
  {-Map the characters found in FromStr to the corresponding ones in ToStr.}
var P : Cardinal;       I : Byte;
begin
  Result := S;
  if Length (FromStr) = Length (ToStr) then
    for I := 1 to Length (Result) do begin
      if StrChPosS (FromStr, S[I], P) then
        Result [I] := ToStr [P];
    end;
end;

{----------------------------------------------------------------------------}

function ReplaceString(const S, OldString, NewString : ShortString; N : Cardinal;
                        var Replacements : Cardinal) : ShortString;
var i, C, P1 : Cardinal;                       TmpStr : ShortString;
begin
  if (S = '') or (OldString = '') or (System.Pos(OldString, S) = 0) then begin
    Result := S;
    Replacements := 0;
    Exit;
  end;
  TmpStr := S;
  i  := 1;
  P1 := System.Pos (OldString, TmpStr);
  C  := P1;
  while (i < N) and (C < Length (TmpStr)) do begin
    Inc (i);
    System.Delete (TmpStr, 1, P1 + Length (OldString));
    Inc (C, P1 + Length (OldString));
  end;
  Result := S;
  System.Delete (Result, C, Length (OldString));
  C := 0;
  for i := 1 to Replacements do begin
    if ((Length (NewString) + Length (Result)) <= 255) then begin
      Inc (C);
      System.Insert (NewString, Result, P1);
      Inc (P1, Length(NewString) + 1);
    end else begin
      Replacements := C;
      Exit;
    end;
  end;
end;

{----------------------------------------------------------------------------}

function ReplaceString (const S, OldString, NewString : String; N : integer;
                                          var Replacements : integer) : String;
var i, C, P1 : integer;                       TmpStr : String;
begin
  if (S = '') or (OldString = '') or (System.Pos (OldString, S) = 0) then
  begin
    Result := S;
    Replacements := 0;
    Exit;
  end;
  TmpStr := S;
  i  := 1;
  P1 := System.Pos (OldString, TmpStr);
  C  := P1;
  while (i < N) and (C < Length (TmpStr)) do
  begin
    Inc (i);
    System.Delete (TmpStr, 1, P1 + Length (OldString));
    Inc (C, P1 + Length (OldString));
  end;
  Result := S;
  System.Delete (Result, C, Length (OldString));
  C := 0;
  for i := 1 to Replacements do
  begin
    if ((Length (NewString) + Length (Result)) <= 255) then begin
      Inc (C);
      System.Insert (NewString, Result, P1);
      Inc (P1, Length(NewString) + 1);
    end else
    begin
      Replacements := C;
      Exit;
    end;
  end;
end;

{----------------------------------------------------------------------------}

function ReplaceStringAll (const S, OldString, NewString : ShortString;
                                    var Replacements : Cardinal) : ShortString;
//number of replacements reterned in 'Replacements'
var I, C, P1 : Cardinal;          Tmp: shortString;
begin
  Result := S;
  if (S = '') or (OldString = '') or (System.Pos (OldString, S) = 0) then
    Replacements := 0
  else begin
    Tmp := S;
    P1 := System.Pos (OldString, S);
    if (P1 > 0) then
    begin
      Result := Copy(Tmp, 1, P1-1);
      C := 0;
      while (P1 > 0) do
      begin
        for I := 1 to Replacements do
        begin
          Inc (C);
          Result := Result + NewString;
        end;
        Tmp := Copy (Tmp, P1 + Length (OldString), MaxInt);
        P1 := System.Pos (OldString, Tmp);
        if (P1 > 0) then
        begin
          Result := Result + Copy (Tmp, 1, P1-1);
        end else
          Result := Result + Tmp;
      end;
      Replacements := C;
    end else begin
      Result := S;
      Replacements := 0;
    end;
  end;
end;

{-----------------------------------------------------------------------------}

function FilterS (const S, Filters : ShortString) : ShortString;
  {-Remove characters from a string. The characters to remove are specified in ChSet.}
var I, Len : Cardinal;
begin
  Len := 0;
  for I := 1 to Length (S) do
    if not CharExistsS (Filters, S [I]) then begin
      Inc (Len);
      Result [Len] := S [I];
    end;
  Result[0] := AnsiChar (Len);
end;

{-----------------------------------------------------------------------------}

function StrStDeleteS (const S : ShortString; Pos, Count : Cardinal) : ShortString;
  {-Delete characters at a specified position in a string.}
begin
  Result := S;
  System.Delete(Result, Pos, Count);
end;

{-----------------------------------------------------------------------------}

Function Parse_line (var line : String; delim : char; cut : boolean) : String;
{Parse_line is returned as string before delimiter.
cut = false return line is whole input string -
cut = true return line string after delimiter}
var  i : integer;
begin
  result := '';
  if Length (line) = 0 then
    Exit;
  i := 1;
  while (line [i] <> delim) and (i <= Length (line)) do
    Inc (i);
  result := Copy (line, 1, i - 1);
  if cut and (Length (line) > i) then
    line := Copy (line, i + 1, Length (line) - i);
end;

{================ StStr utilities ======StStrS=================================}

Function Parse_line (var line : shortString; delim : ansichar; cut : boolean) : AnsiString;
{Parse_line is returned as string before delimiter.
cut = false return line is whole input string -
cut = true return line string after delimiter}
var  i : byte;
begin
  result := '';
  if Length (line) = 0 then Exit;
  i := 1;
  while (line [i] <> delim) and (i <= Length (line)) do
    Inc (i);
  result := Copy (line, 1, i - 1);
  if cut and (Length (line) > i) then
    line := Copy (line, i + 1, Length (line) - i);
end;

{-----------------------------------------------------------------------------}

Function ParseLineFrom (var line : shortString; from : integer) : shortString;
var  s1, s2 : shortString;
begin
  WordWrapS (line, s1, s2, from, false);
  line := s2;
  result := s1;
end;

{-----------------------------------------------------------------------------}

function PadCh (const S : ShortString; C : AnsiChar; Len : Cardinal) : ShortString;
  {-Pad a string on the right with a specified character.}
var SLen : Byte absolute S;
begin
  if Length(S) >= Len then
    Result := S
  else begin
    if Len > 255 then Len := 255;
    Result[0] := AnsiChar (Len);
    Move(S[1], Result[1], SLen);
    if SLen < 255 then
      FillChar (Result [Succ(SLen)], Len-SLen, C);
  end;
end;

{-----------------------------------------------------------------------------}

function CharStrS (C : AnsiChar; Len : Cardinal) : ShortString;
  {-Return a string filled with the specified character.}
begin
  if Len = 0 then
    Result [0] := #0
  else begin
    Result [0] := AnsiChar (Len);
    FillChar (Result [1], Len, C);
  end;
end;

{-----------------------------------------------------------------------------}

function CharExistsS (const S : ShortString; C : AnsiChar) : Boolean;
  {-Determine whether a given character exists in a string. }
var i : integer;
begin
  result := false;
  for i := 1 to Length (s) do
    if s [i] = c then
    begin
      result := true;
      break;
    end;
end;

{-----------------------------------------------------------------------------}

function Real2StrS (R : Double; Width : Byte; Places : ShortInt) : ShortString;
  {-Convert a real to a string.}
begin
  Str (R:Width:Places, Result);
end;

{-----------------------------------------------------------------------------}

function RightTrimCharsS (const S, Chars : ShortString) : ShortString;
var CutOff : integer;
begin
  CutOff := length (S);
  while (CutOff > 0) do
  begin
    if not CharExistsS (Chars, S [CutOff]) then
      Break;
    Dec (CutOff);
  end;
  if (CutOff = 0) then
    Result := ''
  else Result := Copy (S, 1, CutOff);
end;

{-----------------------------------------------------------------------------}

function StrStPosS (const P, S : ShortString; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified substring within a string.}
begin
  Pos := System.Pos (S, P);
  Result := Pos <> 0;
end;

{-----------------------------------------------------------------------------}

function TrimS (const S : ShortString) : ShortString;
  {-Return a string with leading and trailing white space removed.}
var I    : Cardinal;       SLen : Byte absolute Result;
begin
  Result := S;
  while (SLen > 0) and (Result [SLen] <= ' ') do
    Dec (SLen);
  I := 1;
  while (I <= SLen) and (Result [I] <= ' ') do
    Inc (I);
  Dec (I);
  if I > 0 then
    Delete (Result, 1, I);
end;

{-----------------------------------------------------------------------------}

function WordCountS (const S, WordDelims : ShortString) : Cardinal;
  {-Given an array of word delimiters, return the number of words in a string.}
var  I     : Integer;          SLen  : Byte;
begin
  Result := 0;
  I := 1;
  SLen := Length (S);
  while I <= SLen do
  begin                  //skip over delimiters
    while (I <= SLen) and CharExistsS (WordDelims, S [I]) do
      Inc (I);                                //if we're not beyond end of S, we're at the start of a word
    if I <= SLen then
      Inc (Result);
    {find the end of the current word}
    while (I <= SLen) and not CharExistsS (WordDelims, S [I]) do
      Inc (I);
  end;
end;

{-----------------------------------------------------------------------------}

function Str2ExtS (const S : ShortString; var R : Extended) : Boolean;
  {-Convert a string to an extended.}
var Code : Integer;          P : ShortString;        PLen : Byte absolute P;
begin
  P := Trim (S);
  Val (ValPrepS (P), R, Code);
  if Code <> 0 then
  begin
    R := Code;
    Result := False;
  end else
    Result := True;
end;

{-----------------------------------------------------------------------------}

function JustExtensionS (const Name : ShortString) : ShortString;
  {-Return just the extension of a pathname.}
var DotPos : Cardinal;
begin
  if HasExtensionS (Name, DotPos) then
    Result := Copy (Name, Succ (DotPos), StMaxFileLen)
  else Result := '';
end;

{-----------------------------------------------------------------------------}

function HasExtensionS (const Name : ShortString; var DotPos : Cardinal) : Boolean;
  {-Determine if a pathname contains an extension and, if so, return the
    position of the dot in front of the extension.}
var  I : Cardinal;
begin
  DotPos := 0;
  for I := Length (Name) downto 1 do
    if (Name[I] = '.') and (DotPos = 0) then
      DotPos := I;
  Result := (DotPos > 0) and not CharExistsS (Copy (Name, Succ (DotPos), StMaxFileLen), '\');
end;

{-----------------------------------------------------------------------------}

function HasExtensionL (const Name : String; var DotPos : Cardinal) : Boolean;
  {-Determine if a pathname contains an extension and, if so, return the
    position of the dot in front of the extension.}
var S : AnsiString;          I : Cardinal;
begin
  DotPos := 0;
  for I := Length (Name) downto 1 do
    if (Name[I] = '.') and (DotPos = 0) then
      DotPos := I;
  s := AnsiString (Name);
  Result := (DotPos > 0) and not CharExists (Copy (S, Succ (DotPos), 512), '\');
end;

{-----------------------------------------------------------------------------}

function Str2RealS (const S : ShortString; var R : real) : Boolean;
  {-Convert a string to a real.}
var Code : Integer;                 St   : ShortString;
    SLen : Byte absolute St;
begin
  St := S;
  while St[SLen] = ' ' do     {trim trailing blanks}
    Dec (SLen);
  Val (ValPrepS (St), R, Code);
  if Code <> 0 then
  begin
    R := Code;
    Result := False;
  end else
    Result := True;
end;

{-----------------------------------------------------------------------------}

function JustFilename (const PathName : ShortString) : ShortString;
  {-Return just the filename and extension of a pathname.}
var  i : Longint;
begin
  Result := '';
  if PathName = '' then
    Exit;
  i := Succ (Length (PathName));
  repeat
    Dec(i);
  until (i = 0) or (PathName [i] in DosDelimSet);                         {!!.01}
  Result := Copy (PathName, Succ (i), StMaxFileLen);
end;

{-----------------------------------------------------------------------------}

function JustFilename (const PathName : String) : String;
  {-Return just the filename and extension of a pathname.}
var I : Cardinal;
begin
  Result := '';
  if PathName = '' then Exit;
  I := Succ (Word (Length (PathName)));
  repeat
    Dec(I);
  until (I = 0) or (Pos (PathName[I], DosDelimSetW) > 0)                  {!!.01}
    or (PathName [I] = #0);                                               {!!.01}
  Result := System.Copy (PathName, Succ(I), StMaxFileLen);
end;

{-----------------------------------------------------------------------------}

function CompUCString (S1, S2 : ShortString) : Integer;
  {-Compare two strings. This compare is not case sensitive.}
var i : integer;
begin
  result := -1;            //different length strings
  if Length (s1) = Length (s2) then
  begin
    result := 0;
    s1 := UpperCase (s1);
    s2 := UpperCase (s2);
    for i := 1 to length (s1) do
      if s1 [i] <> s2 [i] then
      begin
        result := i;
        break;
      end;
  end;
end;

{-----------------------------------------------------------------------------}

function CompUCString (S1, S2 : String) : Integer;
  {-Compare two strings. This compare is not case sensitive.}
var i : integer;
begin
  result := -1;            //different length strings
  if Length (s1) = Length (s2) then
  begin
    result := 0;
    s1 := UpperCase (s1);
    s2 := UpperCase (s2);
    for i := 1 to length (s1) do
      if s1 [i] <> s2 [i] then
      begin
        result := i;
        break;
      end;
  end;
end;

{-----------------------------------------------------------------------------}

procedure WordWrapS (const InSt : ShortString; var OutSt, Overlap : ShortString;
                                      Margin : Cardinal; PadToMargin : Boolean);
  {-Wrap a text string at a specified margin.}
var EOS, BOS : Cardinal;                InStLen  : Byte;
  OutStLen : Byte absolute OutSt;       OvrLen   : Byte absolute Overlap;
begin
  InStLen := Length(InSt);
  { handle empty string on input }
  if InStLen = 0 then begin
    OutSt := '';
    Overlap := '';
    Exit;
  end;
  {find the end of the output string}
  if InStLen > Margin then begin
    EOS := Margin;                                   //find the end of the word at the margin, if any
    while (EOS <= InStLen) and (InSt [EOS] <> ' ') do
      Inc(EOS);
    if EOS > InStLen then
      EOS := InStLen;

    while (InSt [EOS] = ' ') and (EOS > 0) do      //trim trailing blanks
      Dec (EOS);
    if EOS > Margin then begin
      while (EOS > 0) and (InSt [EOS] <> ' ') do   //look for the space before the current word}
        Dec (EOS);
      if EOS = 0 then                              //if EOS = 0 then we can't wrap it
        EOS := Margin
      else                                         //trim trailing blanks
        while (InSt [EOS] = ' ') and (EOS > 0) do
          Dec (EOS);
    end;
  end else
    EOS := InStLen;
  {copy the unwrapped portion of the line}
  OutStLen := EOS;
  Move (InSt [1], OutSt [1], OutStLen);
  {find the start of the next word in the line}
  BOS := EOS+1;
  while (BOS <= InStLen) and (InSt [BOS] = ' ') do
    Inc (BOS);
  if BOS > InStLen then
    OvrLen := 0
  else begin
    {copy from the start of the next word to the end of the line}
    OvrLen := Succ (InStLen - BOS);
    Move (InSt [BOS], Overlap [1], OvrLen);
  end;
  {pad the end of the output string if requested}
  if PadToMargin and (OutStLen < Margin) then begin
    FillChar (OutSt [OutStLen + 1], Margin - OutStLen, ' ');
    OutStLen := Margin;
  end;
end;

{-----------------------------------------------------------------------------}

function StrChPosS (const P : ShortString; C : AnsiChar; var Pos : Cardinal) : Boolean;
  {-Return the position of a specified character within a string.}
var i : integer;
begin
  result := false;
  pos := 0;
  if Length (p) > 0 then
    for i := 1 to Length (p) do
      if P [i] = C then
      begin
        Pos := i;                            //character position
        result := true;                      //character found
        Break;
      end;
end;

{-----------------------------------------------------------------------------}

function JustPathnameS (const PathName : ShortString) : ShortString;
  {-Return just the drive and directory portion of a pathname.}
var i : Longint;
begin
  i := Succ (Length (PathName));
  repeat
    Dec (i);
  until (i = 0) or (PathName [i] in DosDelimSet);                         {!!.01}
  if i = 0 then                                 //Had no drive or directory name
    Result [0] := #0
  else if i = 1 then          //Either the root directory of default drive or invalid pathname
    Result := PathName [1]
    else if (PathName [I] = '\') then
    begin
      if PathName [Pred (I)] = ':' then  //Root directory of a drive, leave trailing backslash
        Result := Copy (PathName, 1, I)  //Subdirectory, remove the trailing backslash
      else Result := Copy (PathName, 1, Pred (I));
    end else                       //Either the default directory of a drive or invalid pathname
      Result := Copy (PathName, 1, I);
end;

{-----------------------------------------------------------------------------}

function ValPrepS (const S : ShortString) : ShortString;
  {-Prepares a string for calling Val.}
var P : Cardinal;           dcSep : ansiChar;
begin
  Result := Trim (S);
  dcSep := AnsiChar (FormatSettings.DecimalSeparator);
  if Result <> '' then
  begin
    if StrChPosS (Result, dcSep, P) then
    begin
      Result [P] := '.';
      if P = Byte(Result [0]) then
        Result [0] := AnsiChar (Pred (P));
    end;
  end else
    Result := '0';
end;

{=============================================================================}

procedure ExchangeStructs (var I, J; Size : Cardinal);
var pTemp: TBytes;
begin
  if Size <= 0 then
    Exit;
  SetLength (pTemp, Size);
  Move (I, pTemp [0], Length (pTemp));
  Move (J, I, Length (pTemp));
  Move (pTemp [0], J, Length (pTemp));
end;

{-----------------------------------------------------------------------------}

end.
