unit io_unit;

interface

uses Windows, Messages, Globals, SysUtils, General, Classes, Dialogs, IniFiles,
     Forms, Math, StrGeneral, System.UITypes;

type  ptStrings     = ^tStrings;

Function IOcheck (filnavn : fNameType) : longint;
Procedure CreateMassIndex;
Procedure SetAAmassValues (var aaLocal : aaType);
Procedure LoadMassFile (var aaLoad : aaType; fName : fNameType);
Procedure SaveMassFile (var aaCopy : aaType; fName : fNameType);
Procedure ResetTerminals;
Function LoadTerminals (fName : fNameType) : integer;
Procedure SaveTerminals (const aaCopy : aaType; fName : fNameType);
Function CheckFileFormat (aName : fNameType; mode : word) : integer;
Function CheckDBFileType (fName : fNameType) : integer;
Function Check4FastA (fName : fNameType) : integer;
Function CountSeqInFastA (fName : string) : integer;
Function LoadAtomDist (var tbl : atomDistArr) : boolean;
Function ContainStdChar (const fname : string; var chErr : char) : boolean;
Function ChkFileWrite (const fName : string; showMsg : boolean) : integer;

implementation

const aa1Const : aa_name1_type = ('-','X','A','C','D','E','F','G',
                'H','I','K','L','M','N','P','Q','R','S','T',
                'V','W','Y','B','U','Z','Æ','Ø','Å','¤','Û','ß','1','2','-');
      aa3Const : aa_name3_type = ('H2O','Xxx','Ala','Cys','Asp','Glu','Phe','Gly',
                'His','Ile','Lys','Leu','Met','Asn','Pro','Gln','Arg','Ser','Thr',
                'Val','Trp','Tyr','Bbb','Uuu','Zzz','Æææ','Øøø','Ååå','¤¤¤','Ûüü',
                'ßßß','111','222','---');
      aaNameConst : aa_name_array = ('Base mass','Unknown','Alanine','Cysteine','Asp. acid',
                'Glu. acid','Phenylala.','Glycine','Histidine','Isoleu.','Lysine','Leucine',
                'Methionine','Asparagine','Proline','Glutamine','Arginine','Serine','Threonine',
                'Valine','Tryptopha.','Tyrosine','Unknown','Unknown','Unknown','Unknown','Unknown',
                'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Split');
      aaCompConst : formula_array = ('H2O1','C6H8N1O1','C3H5N1O1','C3H4N1O1S1','C4H5N1O3',
                'C5H7N1O3','C9H9N1O1','C2H3N1O1','C6H7N3O1','C6H11N1O1','C6H12N2O1','C6H11N1O1',
                'C5H9N1O1S1','C4H6N2O2','C5H7N1O1','C5H8N2O2','C6H12N4O1','C3H5N1O2','C4H7N1O2',
                'C5H9N1O1','C11H10N2O1','C9H9N1O2','','','','','', '','','','','','','');
      NnameConst : termStrArray = ('Hydrogen', 'Pyroglutamic acid', 'N-formylation', 'N-myristylation',
                                'N-acetylation', 'Biotin', '', '', '', '', '', '', '');
      NcompConst : termStrArray = ('H1', 'C5H6N1O2', 'C1H1O1', 'C14H27O1',
                                       'C2H3O1', 'C10H14N2O2S1', '', '', '', '', '', '', '');
      CnameConst : termStrArray = ('Free acid', 'Amidation', '', '', '', '', '',
                                                         '', '', '', '', '', '');
      CcompConst : termStrArray = ('O1H1', 'H2N1', '', '', '', '', '', '', '', '', '', '', '');

{-----------------------------------------------------------------------------}

Function IOcheck (filnavn : fNameType) : longint;
var  checkfile : file;
begin
  result := -1;
  if FileExists (filnavn) then
  begin
    fileMode := 0;
    AssignFile (checkfile, filnavn);
    try
      Reset (checkfile, 1);
      try
        result := FileSize (checkFile);
      finally
        CloseFile (checkFile);
        fileMode := 2;
      end;
    except
      on EInOutError do
        result := -1;
    end;
    fileMode := 2;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure CreateMassIndex;
{Creates the mass index into the mass array in the global aa variable}
var j : integer;
begin
  FillChar (aa.aaIndex, SizeOf (aa.aaIndex), 0);         {clear index}
  aa.aaStr1 := '';
  aa.aaStr3 := '';
  for j := 0 to maxAA do
  begin
    aa.aaIndex [ord (aa.name1 [j])] := j;         {aaIndex [i] points to residue i}
    aa.aaStr1 := aa.aaStr1 + aa.name1 [j];
    aa.aaStr3 := aa.aaStr3 + aa.name3 [j];
  end;
end;

{-----------------------------------------------------------------------------}

Procedure SetAAmassValues (var aaLocal : aaType);
var i, j : integer;
begin
  with aaLocal do
  begin
    FillChar (mass, SizeOf (mass), 0);
    for i := 0 to maxAA do
    begin
      for j := 1 to maxAtom do
      begin
        mass [2, i] := mass [2, i] + compos [i, j] * atoms.ave [j];
        mass [3, i] := mass [3, i] + compos [i, j] * atoms.mono [j];
      end;
      mass [1, i] := Round (mass [2, i]);
      IntMass [2, i] := Round (mass [2, i] * 1000);
      IntMass [3, i] := Round (mass [3, i] * 1000);
    end;
  end;
end;

{-----------------------------------------------------------------------------}

Procedure LoadMassFile (var aaLoad : aaType; fName : fNameType);
var f : text;     i : integer;         s : string;        rTmp : real;
begin
  if FileExists (fName) then
    with aaLoad do
    begin
      AssignFile (f, fName);
      try
        Reset (f);
        try
          FillChar (aaLoad.composStr, SizeOf (aaLoad.composStr), 0);
          i := 0;
          while (not EOF (f)) and (i <= maxAA) do
          begin
            ReadLn (f, name1 [i]);
            ReadLn (f, name3 [i]);
  //          ReadLn (f, name [i]);
            ReadLn (f, s);
            if Length (s) > 10 then
            begin
              name [i] := ShortString (Trim (Copy (s, 1, 10)));
              s := Copy (s, 11, Length (s) - 10);
              rTmp := Str2Real (s, 0.0);
            end else name [i] := ShortString (s);
            ReadLn (f, composStr [i]);         //extract pKa value
            Inc (i);
          end;
        finally
          CloseFile (f);
        end;
      except
        on EInOutError do
        begin
          MyMsgDlg ('Error reading mass file ' + fName + '§Resetting to default values.', mtError, [mbOK], 0);
          name1 := aa1Const;
          name3 := aa3Const;
          name := aaNameConst;
          composStr := aaCompConst;
        end;
      end;
      name1 [maxAA] := '-';              //peptide split
      name3 [maxAA] := '---';
      composStr [maxAA] := 'H2O1';
      FillChar (compos, SizeOf (compos), 0);
      for i := 0 to maxAA do
        if Length (composStr [i]) > 1 then
          CnvComposStr (composStr [i], compos [i]);
      SetAAmassValues (aaLoad);
      CreateMassIndex;
    end;
end;

{-----------------------------------------------------------------------------}

Procedure SaveMassFile (var aaCopy : aaType; fName : fNameType);
var f : text;     i : integer;           s : string;           rTmp : real;
begin
  AssignFile (f, fName);
  try
    ReWrite (f);
    with aaCopy do
      for i := 0 to maxAA do
      begin
        WriteLn (f, name1 [i]);
        WriteLn (f, name3 [i]);
        WriteLn (f, name [i]);
        WriteLn (f, composStr [i]);
      end;
  finally
    CloseFile (f);
  end;
end;

{-----------------------------------------------------------------------------}

Procedure ResetTerminals;
var k : integer;
begin
  for k := 0 to maxTerm do
  begin
    aa.Nterm [k].name := NNameConst [k];
    aa.Nterm [k].compStr := NcompConst [k];
    aa.Cterm [k].name := CNameConst [k];
    aa.Cterm [k].compStr := CcompConst [k];
  end;
end;

{-----------------------------------------------------------------------------}

Function LoadTerminals (fName : fNameType) : integer;
var f : text;     i, j : integer;

begin
  result := 0;
  if not FileExists (fName ) then
  begin
    ResetTerminals;
    result := 16;
  end else begin
    AssignFile (f, fName);
    try
      Reset (f);
      try
        i := 0;
        while (not EOF (f)) and (i <= maxTerm) do             {=10}
        begin
          ReadLn (f, aa.Nterm [i].name);
          ReadLn (f, aa.NTerm [i].compStr);
          ReadLn (f, aa.Cterm [i].name);
          ReadLn (f, aa.Cterm [i].compStr);
          Inc (i);
        end;
      finally
        CloseFile (f);
      end;
    except
      on EInOutError do
        ResetTerminals;
    end;
    end;
  if (aa.Nterm [0].CompStr = '') or (aa.Cterm [0].compStr = '') then
    ResetTerminals;
  for i := 0 to maxTerm do
  begin
    for j := 1 to 3 do
    begin
      aa.Nterm [i].mass [j] := 0.0;
      aa.Cterm [i].mass [j] := 0.0;
    end;
    if Length (aa.Nterm [i].compStr) > 1 then
      ComposStr2Mass (aa.Nterm [i].compStr, aa.Nterm [i].mass);
    if Length (aa.Cterm [i].compStr) > 1 then
      ComposStr2Mass (aa.Cterm [i].compStr, aa.Cterm [i].mass);
  end;
end;

{-----------------------------------------------------------------------------}

Procedure SaveTerminals (const aaCopy : aaType; fName : fNameType);
var f : textFile;     i : integer;
begin
  if FileExists (fName) then
    if not DeleteFile (fName) then
      MyMsgDlg ('Cannot delete file §' + fName, mtError, [mbOK], 0);
{$I-}
  AssignFile (f, fName);
  try
    ReWrite (f);
    with aaCopy do
      for i := 0 to maxTerm do
      begin
        WriteLn (f, Nterm [i].name);
        WriteLn (f, Nterm [i].compStr);
        WriteLn (f, Cterm [i].name);
        WriteLn (f, Cterm [i].compStr);
        Sleep (1);
      end;
  finally
    CloseFile (f);
  end;
  if IOResult <> 0 then
    MyMsgDlg ('Problems with saving:§' + fName + '§§Error code: ' + IntToStr (IOResult), mtError, [mbOK], 0);
{$I+}
end;

{-----------------------------------------------------------------------------}

Function CheckFileFormat (aName : fNameType; mode : word) : integer;
{result : -2=zero filesize; -1=file not present;
          0=ASCII; 1=not ASCII; 2=GPMAW peptide; 3=HP TOF catalog; 4=PerSeptive;
          9=ABI Sciex; 10=MoverZ; 11=Bruker xlm}
//mode : 1, 3=check for ASCII; 2=check for peptide file; 10= ASCII without returns

const msExt : shortString = ('mgf msm pkx pkl gpm dta');
      ChkStrID : array [2..9] of ansistring = ('!GPMAW PEPTIDE','TOF_CATALOG_VER2',
                    '"PEAK TABLE"', '/####', 'ASCII PEAK TABLE', 'MASS/INTENSITY TABLE',
                    '@@@@@@', 'DATASET NAME:');
      ChkOffset : array [2..9] of integer = (1,3,1,1,1,1,0,1);
type smallChBuff = array [1..1048] of ansichar;
var F : file;                        i, extPos, bSize : longint;
    buffer : smallChBuff;            txtF : textFile;
    line, sFirst : str80;            rTmp : real;

Function CheckString (p : smallChBuff) : integer;
var i, j : integer;           check : boolean;
begin
  result := 0;
  for i := 2 to 9 do
  begin
    check := true;
    for j := ChkOffset [i] to ChkOffset [i] + Length (ChkStrID [i]) - 1 do
      if p [j] <> ChkStrID [i] [j - ChkOffset [i] + 1] then
        check := false;
    if check then
      result := i;
  end;
end;
Function Check4Ascii (buf : integer) : integer;
var i : integer;
begin
  result := buf;
  for i := 1 to bSize do
    if not (buffer [i] in [#8,#9,#10,#13,#32..#255]) then
      result := 1;               {not ASCII file}
end;

begin
  result := 0;
  if not FileExists (aName) then
  begin
    result := -1;                     {not a valid file name}
    Exit;
  end;
  if GetFileSize (aName) = 0 then
  begin
    result := -2;                   {file size = zero}
    Exit
  end;
  fileMode := 2;
  AssignFile (F, aName);
  Reset (F, 1);
  BlockRead (F, buffer, 1024, bSize);
  i := 0;
  sFirst := '';
  while (buffer [FInc (i)] >= #32) and (i < 79) do
    sFirst := sFirst + buffer [i];
  for i := 1 to 50 do
    buffer [i] := UpCase (buffer [i]);
  case mode of
  1 : begin
        result := Check4Ascii (result);
        if result = 0 then
        begin
          result := 10;
          for i := 1 to bSize do
            if buffer [i] = #13 then
              result := 0;
        end;
      end;
  2 : begin
        extPos := System.Pos (JustExtension (aName), msExt);
        if extPos in [1, 5, 9, 13, 17, 21] then                    //msms peak list
          result := 50 + (extPos - 1) div 4
        else
        begin                                    //standard peak list
          result := checkString (buffer);
          if result = 0 then
          begin
            if sFirst = '<MASSML>' then                        // m/z
              result := 10
            else if sFirst = '<?xml version="1.0"?>' then            // Bruker xml
              result := 11
            else result := Check4Ascii (result);
          end;
        end;
      end;
  3 : begin
        result := Check4Ascii (result);
        if result = 0 then
          for i := 1 to bSize do
          begin
            if (buffer [i] = #13) then
              result := 127;
            if (buffer [i] = #10) and (result <> 127) then
              result := 128;
          end;
      end;
  end;
  CloseFile (F);
  if (mode = 2) and (result = 0) then        //peptide file but no recog. format
  begin                                      //check for mass on every line
    AssignFile (txtF, aName);
    Reset (txtF);
    result := 8;
    for i := 1 to 6 do                      //skip first two lines
      if not EOF (txtF) then                //we need at least 4 additional lines
      begin
        ReadLn (txtF, line);
        if ((i > 2) and (result <> 0) and not Str2RealS (line, rTmp)) then
          result := 0;
      end else
          result := 0;                        //not enough lines
    CloseFile (txtF);
  end;
end;

{-----------------------------------------------------------------------------}

Procedure GetBufLine (pBuff : pLargeBuff;var index, lastBuf : word;var S : ShortString);
begin
  S := '';
  while (pBuff^ [index] < #32) and (index < lastBuf) do
    Inc (index);
  while (pBuff^ [index] >= #32) and (index < lastBuf) and (Length (S) < 128) do
  begin
    S := S + pBuff^ [index];
    Inc (index);
  end;
end;

{-----------------------------------------------------------------------------}

Function CheckDBFileType (fName : fNameType) : integer;
// 1 = 3 line; 2 = 2 line; 3 = 2 line; 4 = 3 line; 5 = embl nr; 6 = Swiss
// 3, 4 = ASCII without return
Const NameLenChk = 14;
var f : textFile;        untF : file;
    i, x, sum, off, score, totLen, emblNrChk, mySwiss : integer;
    s : AnsiString;                            buff : smallBuff;
begin
    FileMode := 0;
    if CheckFileFormat (fName, 1) = 10 then
    begin                                               {ASCII without returns}
      AssignFile (untF, fName);
      Reset (untF, 1);
      BlockRead (untF, buff, 2000);
      CloseFile (untF);
      off := 0;
      sum := 0;
      for i := 1 to 3 do
      begin
        while (buff [off] <> '>') and (off < 1900) do
          Inc (off);
        x := 0;
        repeat
          Inc (x)
        until (buff [off + x] = #10) or (x > 20);
        Inc (sum, x);
        Inc (off, x);
      end;
      if (sum div 3) >= NameLenChk then
        result := 3                {id and name on the same line}
      else result := 4;            {id and name on different lines}
    end else begin                 {check FastA type 1 or 2}
      fileMode := 0;
      AssignFile (f, fName);
      Reset (f);
      totLen := 0;
      score := 0;
      emblNrChk := 0;
      mySwiss := 0;
      for i := 1 to 100 do
        if not EOF (f) then
        begin
          ReadLn (f, s);
          if s [1] = '>' then
          begin
            Inc (score);
            Inc (totLen, Length (s));
            if (s [2] = '/') and (s [3] = ':') then
              Inc (emblNrChk);
            if (s [4] = '|') then
              Inc (mySwiss);
          end;
        end;
      if score = 0 then
      begin
        result := -1;
        Exit;
      end;
      if TotLen div score >= NameLenChk then
      begin
        s := AnsiString (JustName (fName));
        s := UpperCase (s);
        if (mySwiss >= score - 1) and ((s = 'SWISS') or (s = 'SWISSNEW'))  then
          result := 6
        else result := 2                         {>IDname, seq (2 lines)}
      end else result:= 1;                     {>ID, name, seq on separate lines (3lines)}
      if emblNrChk >= score - 1 then
        result := 5;                       {embl nr}
      CloseFile (f);
    end;
    FileMode := 2;
end;

{-----------------------------------------------------------------------------}

Function Check4FastA (fName : fNameType) : integer;
var f : textFile;           s : AnsiString;
begin
  FileMode := 0;
  result := 0;
  if fileExists (fName) and (CheckFileFormat (fName, 1) = 0) then
  begin
    AssignFile (f, fName);
    Reset (f);
    ReadLn (f, s);
    CloseFile (f);
    if s [1] = '>' then
      result := CheckDBFileType (fName);  // 1 = 3 line; 2 = 2 line; 3 = 2 line; 4 = 3 line; 5 = embl nr; 6 = Swiss
            // 3, 4 = ASCII without return
  end;
  FileMode := 2;
end;

{-----------------------------------------------------------------------------}

Function CountSeqInFastA (fName : string) : integer;
var f : textFile;            s : ansiString;
begin
  result := 0;
  if FileExists (fName) and (CheckFileFormat (fName, 1) = 0) then
  begin
try
    AssignFile (f, fName);
    Reset (f);
    repeat
      ReadLn (f, s);
      if (s <> '') and (s [1] = '>') then
        Inc (result);
    until EOF (f);
finally
    CloseFile (f);
end;
  end;
end;

{-----------------------------------------------------------------------------}

Function LoadAtomDist (var tbl : atomDistArr) : boolean;
var f : textFile;       i, j : integer;
procedure AssignRes (i : integer; a : str2; ms, f1, f2, f3 : real);
begin
  tbl [i].aa := a;
  tbl [i].realMs := ms;
  tbl [i].freq [1] := f1;
  tbl [i].freq [2] := f2;
  tbl [i].freq [3] := f3;
  tbl [i].aCount := 2 + Ord (tbl [i].freq [3]  > 0.001);
end;
begin
  result := false;
  FillChar (tbl, SizeOf (tbl), 0);
  if not FileExists (systemDir + 'ATOMDIST.TXT') then
  begin
    AssignRes (1, 'H', 1.007825, 0.99985, 0.00015, 0.0);
    AssignRes (2, 'C', 12.0, 0.989, 0.011, 0.0);
    AssignRes (3, 'N', 14.003074, 0.9963, 0.0037, 0.0);
    AssignRes (4, 'O', 15.994915, 0.99762, 0.00038, 0.00200);
    AssignRes (5, 'S', 31.972072, 0.9502, 0.0075, 0.0421);
    AssignRes (6, 'P', 30.973763, 1.00, 0.0, 0.0);
    Exit;
  end;
  AssignFile (f, systemDir + 'ATOMDIST.TXT');
  FileMode := 0;
  Reset (f);
  i := 0;
  while not EOF (f) and (i <= maxAtom) do
  begin
    Inc (i);
    ReadLn (f, tbl [i].aa);
    ReadLn (f, tbl [i].realMs);
    tbl [i].nomMs := Round (tbl [i].realMs);
    for j := 1 to 3 do
      ReadLn (f, tbl [i].freq [j]);
    if tbl [i].freq [3] > 0.0 then
      tbl [i].aCount := 3
    else tbl [i].aCount := 2;
  end;
  CloseFile (f);
  FileMode := 2;
  result := true;
end;

{-----------------------------------------------------------------------------}

Function ContainStdChar (const fname : string; var chErr : char) : boolean;
var i : integer;
begin
  result := true;
  chErr := ' ';
  for i := 1 to Length (fName) do
    if not (CharInSet (fName [i], ['0'..'9'] + ['A'..'Z'] + ['a'..'z'] +
                                            ['_','-',' ','+','\',':','.'])) then
    begin
      result := false;
      chErr := fName [i];
    end;
end;

{-----------------------------------------------------------------------------}

Function ChkFileWrite (const fName : string; showMsg : boolean) : integer;
var  chkfile : TextFile;
begin
  fileMode := 2;
  AssignFile (chkfile, fName);
{$I-} Rewrite (chkFile); {$I+}
  result := IOresult;
  if result = 0 then
    CloseFile (chkFile)
  else if (result > 0) and (showMsg) then
    MyMsgDlg ('Unable to write file §' + fName + '§Error code ' + IntToStr (result) +
              '§Please use another directory/file', mtError, [mbOK], 0);
end;


{-----------------------------------------------------------------------------}

end.
