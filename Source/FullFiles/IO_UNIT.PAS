unit io_unit;        {general file input/output routines for GPMAW v. 3.0}

interface

uses Windows, Messages, Globals, SysUtils, General, Classes, Dialogs, IniFiles,
     Forms, Math, StrGeneral, System.UITypes;

const modFileStamp = 'MODIFICATION V.3.01';

type  ptStrings     = ^tStrings;

Function IOcheck (filnavn : fNameType) : longint;
Procedure CreateMassIndex;
Procedure SetAAmassValues (var aaLocal : aaType);
Procedure LoadMassFile (var aaLoad : aaType; fName : fNameType);
Procedure SaveMassFile (var aaCopy : aaType; fName : fNameType);
Procedure ResetTerminals;
Function LoadTerminals (fName : fNameType) : integer;
Procedure SaveTerminals (const aaCopy : aaType; fName : fNameType);
Procedure SyncMSsearch (gl : globalDefRec;msSearch : pMSsearchRec);
Function CheckFileFormat (aName : fNameType; mode : word) : integer;
Function LoadPeptideMass (fileName : fNameType;var table : tPepMassTable;
                              mode, tblTp : integer; pts : ptStrings) : integer;
Procedure SavePeptideMass (fileName : fNameType; var pepMS : MSsearchRec);
Function CleanPepMStbl (var msList : tPepMassTable) : integer;
Function IsModifRecOK (modRec : modifRecord) : boolean;
Function LoadModifList (var mList : modifType;const fName : fNameType) : boolean;
Function SaveModifList (var mList : modifType;fName : fNameType) : boolean;
Function CheckDBFileType (fName : fNameType) : integer;
Function Check4FastA (fName : fNameType) : integer;
Function CountSeqInFastA (fName : string) : integer;
Procedure FillUserList (dirName : AnsiString);
Function LoadXlinkList (var tbl : xLinkTbl) : boolean;
Procedure SaveXlinkList (var tbl : xLinkTbl);
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
              if RealInRange (Abs (rTmp), 0.1, 14.1) = 0 then
              begin
                pKaCharge [i] := Sign (rTmp);
                pKaVal [i] := Abs (rTmp);
              end;
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
        if Abs (pKaVal [i]) >= 0.1 then
        begin
          s := Copy (name [i] + '          ', 1, 10);         //right pad w. spaces
          rTmp := pKaVal [i] * pKaCharge [i];
          WriteLn (f, Format ('%s%4.2f', [s, rTmp]));
        end else WriteLn (f, name [i]);
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

Procedure SyncMSsearch (gl : globalDefRec;msSearch : pMSsearchRec);

begin
  if msSearch^.precis = 0.0 then
    msSearch^.precis := gl.searchTol;
  if msSearch^.msMode = 0 then
    msSearch^.msMode := gl.disp and bit2;
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

Function LoadPeptideMass (fileName : fNameType;var table : tPepMassTable;
                              mode, tblTp : integer; pts : ptStrings) : integer;
//tblTp : 0=only mass; 1=mass and intensity
//pts : GP multiple files         mode : file type  0, 2, 4, 6, 8, 9, 10, 50, 51, 52, 53, 54, 55

Function GetVal (po : integer; S : shortString; delim : shortString) : real;
begin
  Result := Str2Real (ExtractWord (po, S, delim), 0.0);
end;

var S1, S2 : shortString;                   dblTmp : extended;
    i, j, numPep, first : integer;          pBuff : pLargeBuff;
    lastMass, index, bufIndex : word;       F : textFile;         FF : file;
    lastbuf, count, spNdx, tiNdx : integer; sLong : AnsiString;

begin
  fileMode := 0;
  Fillchar (table, SizeOf (table), 0);
  lastMass := 0;
  result := 0;
  if (tblTp = 1) and (mode in [0..3]) then
  begin
    MyMsgDlg ('Incorrect file type', mtError, [mbOK], 0);
    Exit;
  end;
  if mode in [0, 2, 4, 6, 8, 9, 10, 50, 51, 52, 53, 54, 55] then
  begin
    AssignFile (F, fileName);
    Reset (F);
  end;
  case mode of
    0 : begin                          //text file, but not defined type
          repeat
            ReadLn (F, S1);
            if not (S1 [1] in ['!', '<', '>', ';']) then           //not comment line
            begin
              ReadLn (F, S1);
              j := 1;                  //remove leading non-decimal characters
              while (j < Length (S1)) and not (S1 [j] in ['0'..'9']) do
                Inc (j);
              S1 := Copy (S1, j, Length (S1) - j + 1);
              S2 := ExtractWord (1, S1, ShortString (#8#9' '));
              dblTmp := Str2real (S2, 0.0);
              if (dblTmp > 0.0) and (lastMass < maxPepMSTable) then
              begin
                Inc (lastMass);
                table [lastMass].mass := dblTmp;
                if (WordCountS (S1, #8#9' ') > 1) then
                begin
                  S2 := ExtractWord (2, S1, ShortString (#8#9' '));
                  if Str2ExtS (S2, dblTmp) then
                    table [lastMass].height := dblTmp;
                end;
              end;
            end;
          until EOF (F) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
    2 : begin                                 {GPMAW peptide format}
          ReadLn (F, S1);
          repeat
            Inc (lastMass);
            ReadLn (F, S1);
            S2 := ExtractWord (1, S1, ShortString (#8#9' '));
            table [lastMass].mass := Str2real (S2, 0.0);
            if (table [lastMass].mass > 100000.0) or
                          (table [lastMass].mass < 1.0) then
              table [lastMass].mass := 0.0;
          until EOF (F) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
    3 : begin                              {HP catalog format}
          AssignFile (FF, fileName);
          Reset (FF, 1);
          if FileSize (FF) < largeBuffSize then
          begin
            pBuff := New (pLargeBuff);
            BlockRead (FF, pBuff^, FileSize (FF));
            Move (pBuff^ [678], j, SizeOf (j));
            lastMass := word (j);
            numPep := Min (integer(lastMass), maxPepMSTable);
            first := Max (1, integer (lastMass) - maxPepMSTable + 1);
            for j := first to first + numPep - 1 do
            begin
              Move (pBuff^ [936 + (j - 1) * 160], dblTmp, SizeOf (double));
              Str (dblTmp, S1);
              table [j - first + 1].mass := Str2real (S1, 0.0);
            end;
            Dispose (pBuff);
          end;
          CloseFile (FF);
        end;
    4 : begin                                 {PerSeptive GRAMS tof}
          Repeat
            ReadLn (f, S1)
          until (Copy (S1, 1, 8) = 'Center X') or Eof (f);
          if not EOF (f) then
          begin
            ReadLn (f, S1);
            while not EOF (f) and (lastMass < maxPepMSTable) do
            begin
              Inc (lastMass);
              ReadLn (f, S1);
              if (Length (Trim (S1)) = 0) and not EOF (f) then
                ReadLn (f, S1);
              S1 := Trim (S1);        {1:mass; 2:height; 3:left edge; 4:right}
              S2 := ExtractWord (1, S1, ShortString (' '));
              if (lastMass > maxPepMSTable) and (Str2Real (S2, 0.0) > 0.1) then
              begin
                for j := 1 to maxPepMSTable - 1 do
                  table [j] := table [j + 1];
                lastMass := maxPepMSTable;
              end;
              table [lastMass].mass := Str2Real (S2, 0.0);
              S2 := ExtractWord (2, S1, ShortString (' '));
              if tblTp = 1 then
                table [lastMass].height := Str2Real (S2, 0.0);
              if not EOF (f) then
                ReadLn (f, S1);
              if (Length (Trim (S1)) = 0) and not EOF (f) then
                ReadLn (f, S1);
            end;
          end;
          CloseFile (f);
        end;
    5 : begin                                {Bruker TOF}
          AssignFile (FF, fileName);
          Reset (FF, 1);
          if FileSize (FF) < largeBuffSize then
          begin
            pBuff := New (pLargeBuff);
            BlockRead (FF, pBuff^, FileSize (FF), lastBuf);
            index := 0;
            bufIndex := lastBuf - 1;
            repeat
              GetBufLine (pBuff, index, bufIndex, S1);
            until (index >= lastBuf) or
               (S1 = '/*********************** Peak List Report **********************/');
            GetBufLine (pBuff, index, bufIndex, S1);
            repeat
              GetBufLine (pBuff, index, bufIndex, S1);
              Inc (lastMass);
              S2 := ExtractWord (2, S1, ShortString (' '));        {mass}
              table [lastMass].mass := Str2real (S2, 0.0);
              if tblTp = 1 then
              begin
                S2 := ExtractWord (4, S1, ShortString (' '));         {intensity}
                table [lastMass].height := Str2real (S2, 0.0) ;
                if table [lastMass].height < 1.0 then
                  table [lastMass].height := table [lastMass].height * 10000;
              end;
            until (index >= lastBuf - 2) or (lastMass >= maxPepMSTable);
            Dispose (pBuff);
          end;
          CloseFile (FF);
        end;
    6 : begin                                 {ASCII PEAK TABLE mass intensity}
          for i := 1 to 4 do
            ReadLn (F, S1);                   {identifier and 3 lines of freetext}
          repeat
            Inc (lastMass);
            ReadLn (F, S1);
            S2 := ExtractWord (1, S1, ShortString (#8#9' '));
            table [lastMass].mass := Str2real (S2, 0.0);
            S2 := ExtractWord (2, S1, ShortString (#8#9' '));
            if tblTp = 1 then
              table [lastMass].height := Str2real (S2, 0.0);
            if (table [lastMass].mass > 100000.0) or
                          (table [lastMass].mass < 1.0) then
              table [lastMass].mass := 0.0;
          until EOF (F) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
    7 : begin                                 {IonSpec mass intensity}
          AssignFile (F, fileName);
          Reset (F);                          {info in line 2}
          repeat
            ReadLn (F, S1);
          until (Copy (S1, 1, 4) = '----') or EOF (F);
          if not EOF (F) then
            repeat
              Inc (lastMass);
              ReadLn (F, S1);
              S2 := ExtractWord (1, S1, ShortString (#8#9' '));
              table [lastMass].mass := Str2real (S2, 0.0);
              S2 := ExtractWord (3, S1, ShortString (#8#9' '));
              if tblTp = 1 then
                table [lastMass].height := Str2real (S2, 0.0);
              if (table [lastMass].mass > 100000.0) or
                            (table [lastMass].mass < 1.0) then
                table [lastMass].mass := 0.0;
            until EOF (F) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
    8 : begin
          repeat
            Inc (lastMass);
            ReadLn (F, S1);
            S1 := Trim (S1);
            table [lastMass].mass := Str2Real (S1, 0.0);
          until (EOF (F)) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
    9 : begin                        //ABI Sciex Analyst software
          repeat
            ReadLn (F, S1);
          until EOF (F) or (Copy (S1, 1, 16) = 'Analysis Results');
          if not EOF (F) then
          begin
            ReadLn (F, S1);
            i := 0;
            repeat
              Inc (i);
              s2 := Trim (ExtractWord (i, S1, #9));
            until (s2 = '') or (s2 = 'Mass (mono.)');
            while not EOF (F) do
            begin
              Inc (LastMass);
              ReadLn (F, S1);
              S1 := Trim (ExtractWord (i, S1, #9' '));
              table [lastMass].mass := Str2Real (S1, 0.0);
            end;
          end;
          CloseFile (F);
        end;
    10 : begin                                           // m/z massml
          repeat
            ReadLn (F, sLong);
            sLong := Trim (sLong);
            if (Length (sLong) < 128) and (Copy (sLong, 1, 5) = 'MASS=') then
            begin
              S1 := sLong;
              S1 := TrimS (ExtractWord (2, S1, ShortString ('"')));
              Inc (lastMass);
              table [lastMass].mass := Str2Real (S1, 0.0);
            end;
          until (EOF (F)) or (lastMass >= maxPepMSTable);
          CloseFile (F);
        end;
   11 : begin                                          // Bruker xml
          AssignFile (F, fileName);
          Reset (F);
          repeat
            ReadLn (F, S1);
            S1 := TrimS (S1);
            if Copy (S1, 1, 6) = '<mass>' then
            begin
              S1 := TrimS (ExtractWord (2, S1, ShortString ('<>')));
              Inc (lastMass);
              table [lastMass].mass := Str2Real (S1, 0.0);
            end;
          until (EOF (F)) or (lastMass >= maxPepMSTable);
          CloseFile (F);
       end;
// 50-54 are recognized only on the extension
   50 : begin                                //mgf
          count := 0;
          repeat
            Inc (count);
            ReadLn (F, s1);
            if Trim (s1) = 'BEGIN IONS' then
            begin
              Inc (LastMass);
              repeat
                ReadLn (F, s1);
//                if Copy (s1, 1, 6) = 'TITLE=' then ;
                if Copy (s1, 1, 8) = 'PEPMASS=' then
                begin
                  s1 := Trim (Copy (s1, 9, Length (s1) - 8));
                  Table [lastMass].mass := GetVal (1, s1, ' '#9);
                  Table [lastMass].height := GetVal (2, s1, ' '#9);
                  table [lastMass].msmsNdx := count;
                  repeat                               //skip ms/ms part
                    ReadLn (F, S1);
                    Inc (count);
                  until (Trim (S1) = 'END IONS') or EOF (F);   //empty line or end of file
                end;
              until EOF (F) or (Trim (s1) = '');
            end;
          until EOF (F) or (LastMass >= maxPepMStable);
          CloseFile (F);
        end;
   51 : begin                                //msm.
          count := 0;
          repeat
            Inc (count);
            ReadLn (F, s1);
            if Trim (s1) = 'BEGIN IONS' then
            begin
              Inc (LastMass);
              if Copy (s1, 1, 8) = 'PEPMASS=' then
              begin
                table [lastMass].mass := Str2Real (Copy (S1, 9, Length (s1) - 8), 0);
                table [lastMass].msmsNdx := count;
                repeat
                  ReadLn (F, s1);
                  Inc (count);
                until (Trim (s1) = 'END IONS') or EOF (f);
              end;
            end;
          until EOF (F);
          CloseFile (F);
        end;
   52 : begin                                //pkx.
          Count := 0;
          repeat
            Inc (Count);
            ReadLn (F, S1);                  //mass intensity charge time
            if (WordCountS (S1, ' '#9) = 4) and (lastMass < maxPepMStable) then
            begin
              Inc (LastMass);
              table [lastMass].mass := GetVal (1, S1, ' ');
              table [lastMass].height := GetVal (2, S1, ' ');      //#3 = charge
              table [lastMass].msmsNdx := count;
              repeat                               //skip ms/ms part
                ReadLn (F, S1);
                Inc (count);
              until (Length (S1) = 0) or EOF (F);   //empty line or end of file
            end else
              ReadLn (F, S1);
          until EOF (F);
          CloseFile (F);
        end;
   53 : begin                                //pkl
          Count := 0;
          repeat
            Inc (Count);
            ReadLn (F, S1);                  //mass intensity charge
            if (WordCountS (S1, ' '#9) = 3) and (lastMass < maxPepMStable) then
            begin
              Inc (LastMass);
              table [lastMass].mass := GetVal (1, S1, ' '#9);
              table [lastMass].height := GetVal (2, S1, ' '#9);
              table [lastMass].msmsNdx := count;
              repeat                               //skip ms/ms part
                ReadLn (F, S1);
                Inc (count);
              until (Length (S1) = 0) or EOF (F);   //empty line or end of file
            end else
              ReadLn (F, S1);
          until EOF (F);
          CloseFile (F);
        end;
   54 : begin                              //GPM  (GP multiple file)
          count := 0;
          tiNdx := -1;
          repeat
            ReadLn (F, s1);
            Inc (Count);
            if Copy (s1, 1, 6) = 'TITLE=' then
            begin
              spNdx := count;
              if pts <> nil then
              begin
                pts^.Add (Copy (s1, 7, Length (s1) - 6));
                Inc (tiNdx);
              end;
              repeat
                ReadLn (F, s1);
                Inc (Count);
                if (WordCountS (s1, ' '#9) = 2) and (GetVal (1, s1, ' '#9) > 0.1) then
                begin
                  Inc (LastMass);
                  table [lastMass].mass := GetVal (1, s1, ' '#9);
                  table [lastMass].height := GetVal (2, s1, ' '#9);
                  table [lastMass].msmsNdx := spNdx;       //index to name line
                  table [lastMass].titleNdx := tiNdx;
                end;
              until (s1 = '') or (lastMass >= maxPepMsTable);
              table [lastMass].msmsNdx := count;           //???
            end;
          until EOF (F) or (lastMass >= maxPepMsTable);
        end;
   55 : begin                                //dta file format
          Count := 0;
          repeat
            Inc (Count);
            ReadLn (F, S1);                  //mass intensity charge
            if (WordCountS (S1, ' '#9) = 2) and (lastMass < maxPepMStable) then
            begin
              Inc (LastMass);
              table [lastMass].mass := GetVal (1, S1, ' '#9);
              table [lastMass].height := GetVal (2, S1, ' '#9);
              table [lastMass].msmsNdx := count;
              repeat                               //skip ms/ms part
                ReadLn (F, S1);
                Inc (count);
              until (Length (S1) = 0) or EOF (F);   //empty line or end of file
            end else
              ReadLn (F, S1);
          until EOF (F);
          CloseFile (F);
        end
   else MyMsgDlg ('File type not recognised', mtInformation, [mbOK], 0);
  end;                   {case}
  fileMode := 2;
  for i := 1 to maxPepMSTable do
    if table [i].mass > 0 then
      table [i].enabled := true;
  if lastMass >= maxPepMSTable then
    MyMsgDlg ('File contains too many peptides.§High mass ' +
           IntToStr (maxPepMSTable) + ' peptides transferred', mtInformation, [mbOK], 0);
  result := 1;
  while table [result].enabled and (result <= maxPepMStable) do
    Inc (result);
end;

{-----------------------------------------------------------------------------}

Procedure SavePeptideMass (fileName : fNameType; var pepMS : MSsearchRec);
var F : textFile;          i : integer;
begin
  if (Length (ExtractFileExt (FileName)) = 0) and (Pos ('.', fileName) = 0) then
      fileName := fileName + '.PEP';
  AssignFile (F, fileName);
  Rewrite (F);
  WriteLn (F, '!GPMAW PEPTIDE');
  for i := 1 to maxPepMSTable do
  begin
    if (pepMS.table [i].mass > 100000.0) or (pepMS.table [i].mass < 1.2) then
      pepMS.table [i].mass := 0.0;
    if pepMS.table [i].mass > 0.01 then
      WriteLn (F, Real2Str (pepMS.table [i].mass, 10, 4) + #9 + Real2Str (pepMS.precis, 4, 2));
  end;
  CloseFile (F);
end;

{-----------------------------------------------------------------------------}

Function CleanPepMStbl (var msList : tPepMassTable) : integer;
//result = number of entries in msList
var i, j : integer;      tbl : tPepMassTable;
begin
  FillChar (tbl, SizeOf (tbl), 0);
  j := 0;
  for i := 1 to maxPepMStable do
    if Abs (msList [i].mass) > 1.1 then
      tbl [FInc (j)] := msList [i];
  msList := tbl;
  result := j;
end;

{-----------------------------------------------------------------------------}

Function IsModifRecOK (modRec : modifRecord) : boolean;
//var masses : massType;
begin
{  if not modRec.massOnly then
    ComposStr2Mass (modRec.formula, masses); }
  modRec.charge := Abs (modRec.charge);
  if modRec.charge > 2 then
    modRec.charge := 1;
  if (modRec.name <> '') and (Abs (modRec.ave) > 0.2) and (modRec.valResStr <> '') then
    result := true
  else result := false;
end;

{-----------------------------------------------------------------------------}

Function LoadModifList (var mList : modifType;const fName : fNameType) : boolean;
//located in C:\ProgramData\gpmaw\system
var f : file;           s : shortString;      masses : massType;
    i : integer;        tf : textFile;        modRec : modifRecord;
begin
  result := false;
  if not FileExists (fName) then
  begin
    MyMsgDlg ('Cannot load modification file §§File '+ fName + ' does not exist!',
                                                             mtError, [mbOK], 0);
    Exit;
  end;
  if IOCheck (fName) = 1640 then              {old modification file}
  begin
    AssignFile (f, fName);
    Reset (f, 1);
    BlockRead (f, s, 20);
    if s = 'MODIFICATION V.3.0 ' then         //1997
      for i := 1 to maxDBmodif do
        with mList.dBase [i] do
        begin
          BlockRead (f, name, SizeOf (name));
          BlockRead (f, formula, SizeOf (formula));
          BlockRead (f, valResStr, SizeOf (valResStr));
          ResStr2Set (valResStr, validRes, aa.aaStr1);
          BlockRead (f, enabled, SizeOf (enabled));
          ComposStr2Mass (formula, masses);
          ave := masses [2];
          mono := masses [3];
        end;
    CloseFile (f);
  end
  else begin
    mList := Default (modifType);
try
    AssignFile (tf, fName);
    Reset (tf);
    while not EOF (tf) do
    begin
      ReadLn (tf, S);
    end;
    CloseFile (tf);
    Reset (tf);
    ReadLn (tf, S);
    if S = modFileStamp then         {s = 'MODIFICATION V.3.01}
      for i := 1 to maxDBmodif do
        with modRec do                      // mList.dBase [i]
        begin
          ReadLn (tf, s);
          if s [1] in ['>', '<'] then
          begin
            name := Copy (s, 2, 19);
            terminal := Pos (s [1], '><');
          end else begin
            name := Copy (s, 1, 20);
            terminal := 0;
          end;
          ReadLn (tf, s);                   //either formula or 2 x mass value
          S := Trim (S);
          if WordCountS (s, ' ') = 1 then        //formula
          begin
            formula := copy (s, 1, 20);
            massOnly := false;
            ComposStr2AveMono (formula, ave, mono);
          end else begin                        //mass values
            formula := 'mass only';
            massOnly := true;
            ave := Str2real (ExtractWord (1, S, ' '), 0.0);
            mono := Str2real (ExtractWord (2, S, ' '), 0.0);
          end;
          ReadLn (tf, S);
          valResStr := Copy (s, 1, 20);
          ResStr2Set (valResStr, validRes);
          ReadLn (tf, S);                     //enabled - charge - pI
          if WordCountS (s, ' ') = 3 then
          begin
            enabled := not (boolean (S [1] = '0'));
            charge :=  Str2long (ExtractWord (2, S, ' '), 1);
            pKa := Str2real (ExtractWord (3, S, ' '), 0.0);
          end else
          begin
            enabled := not (boolean (S = '0'));            //SS = 0 or 1
            charge := 1;                                //0 = -1; 2 = +1
            pKa := 0.0;
          end;
          if IsModifRecOK (modRec) then
            mList.dBase [FInc (mList.tableMax)] := modRec;
        end;
    for i := mList.tableMax + 1 to maxDBmodif do
      mList.dBase [i].charge := 1;
    CloseFile (tf);
    result := true;
except
    result := false;
end;
  end;
  mList.shortFName := shortString (Copy (ExtractFileName (fName), 1, 40));
  mList.longFname := fName;
end;

{-----------------------------------------------------------------------------}

Function SaveModifList (var mList : modifType; fName : fNameType) : boolean;
var f : textFile;       i : integer;         
begin
try
  AssignFile (f, fName);
  Rewrite (f);
  WriteLn (f, modFileStamp);
  for i := 1 to maxDBmodif do
    with mList.dBase [i] do
    begin
      ResStr2Set (valResStr, validRes);
      case terminal of
        0 : WriteLn (f, name);
        1 : WriteLn (f, '>' + Copy (name, 1, 19));
        2 : WriteLn (f, '<' + Copy (name, 1, 19));
        else WriteLn (f, name);
      end;
      if not massOnly then
        WriteLn (f, formula)
      else WriteLn (f, Format ('%7.4f %7.4f', [ave, mono]));
      WriteLn (f, ChSet2Str (validRes));
      if enabled then
        WriteLn (f, Format ('1 %d %5.2f', [charge, pKa]))
      else WriteLn (f, Format ('0 %d %5.2f', [charge, pKa]));
    end;
  CloseFile (f);
  result := true;
except
  result := false
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

Procedure FillUserList (dirName : AnsiString);
var SearchRec: TSearchRec;          index : integer;
Procedure AddFile (s : string);
var tmpS, short : ShortString;       f : textFile;
begin
  AssignFile (f, dirName + s + '.INI');
  Reset (f);
  ReadLn (f, tmpS);
  short := shortString (s);
  if Copy (tmpS, 1, 9) = '[DISPLAY]' then
    if (CompUCString (short, 'gpmaw') <> 0) and (CompUCString (short, 'dbSearch') <> 0) then
      userFile [FInc (index)] := short;
  CloseFile (f);
end;
begin
  FillChar (UserFile, sizeOf (UserFile), 0);
  userFile [0] := 'gpmaw';
  index := 0;
  if FindFirst (dirName  + '*.ini', faAnyFile, SearchRec) = 0 then
  begin
    AddFile (JustName (SearchRec.Name));
    While FindNext (searchRec) = 0 do
      AddFile (JustName (SearchRec.Name));
  end;
  FindClose (SearchRec);
end;

{-----------------------------------------------------------------------------}

Function LoadXlinkList (var tbl : xLinkTbl) : boolean;
var f : textFile;            line : AnsiString;
begin
  result := false;
  tbl.count := 0;
  if FileExists (systemDir + 'XLINKER.REA') then
  begin
    AssignFile (f, systemDir + 'XLINKER.REA');
    Reset (f);
    ReadLn (f, line);
    if line = 'XLINK1' then
      while not EOF (f) do
      begin
        Inc (tbl.count);
        ReadLn (f, tbl.links [tbl.count].name);
        ReadLn (f, tbl.links [tbl.count].linkRes [1]);
        ReadLn (f, tbl.links [tbl.count].linkRes [2]);
        ReadLn (f, tbl.links [tbl.count].linkType);
        ReadLn (f, tbl.links [tbl.count].xLink);
        ReadLn (f, tbl.links [tbl.count].nonLink);
        ReadLn (f, tbl.links [tbl.count].redLink);
        result := true;
      end;
    CloseFile (f);
  end else
  begin
     MyMsgDlg ('Cannot find cross-linking agents, resetting to defaults', mtInformation, [mbOK], 0);
     FillChar (tbl, SizeOf (tbl), 0);
     tbl.count := 5;
     tbl.links [1].name := 'EDC/EDAC';   tbl.links [1].linkRes [1] := 0;
     tbl.links [1].linkRes [2] := 1;     tbl.links [1].linkType := 1;
     tbl.links [1].xLink := '-H2O1';
     tbl.links [2].name := 'DSP/DSSP';   tbl.links [2].linkRes [1] := 1;
     tbl.links [2].linkRes [2] := 1;     tbl.links [2].linkType := 2;
     tbl.links [2].xLink := 'C6O2S3H6';  tbl.links [2].nonLink := 'C6O3S3H8';
     tbl.links [3].name := 'DSS/BS3';    tbl.links [3].linkRes [1] := 1;
     tbl.links [3].linkRes [2] := 1;     tbl.links [3].linkType := 2;
     tbl.links [3].xLink := 'C8O2H10';   tbl.links [3].nonLink := 'C8O3H12';
     tbl.links [4].name := 'DST';        tbl.links [4].linkRes [1] := 1;
     tbl.links [4].linkRes [2] := 1;     tbl.links [4].linkType := 2;
     tbl.links [4].xLink := 'C4O4H2';    tbl.links [4].nonLink := 'C4O5H4';
     tbl.links [5].name := 'DSP/DTSSP';  tbl.links [5].linkRes [1] := 1;
     tbl.links [5].linkRes [2] := 1;     tbl.links [5].linkType := 2;
     tbl.links [5].xLink := 'C6O2S2H6';  tbl.links [5].nonLink := 'C6O3S2H8';
     tbl.links [5].redLink := 'C3O1S1H4';
     SaveXlinkList (tbl);
  end;
end;

{-----------------------------------------------------------------------------}

Procedure SaveXlinkList (var tbl : xLinkTbl);
var f : textFile;       i : integer;
begin
  AssignFile (f, systemDir + 'XLINKER.REA');
  ReWrite (f);
  WriteLn (f, 'XLINK1');
  for i := 1 to tbl.count do
  begin
    WriteLn (f, tbl.links [i].name);
    WriteLn (f, tbl.links [i].linkRes [1]);
    WriteLn (f, tbl.links [i].linkRes [2]);
    WriteLn (f, tbl.links [i].linkType);
    WriteLn (f, tbl.links [i].xLink);
    WriteLn (f, tbl.links [i].nonLink);
    WriteLn (f, tbl.links [i].redLink);
  end;
  CloseFile (f);
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
