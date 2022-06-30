object MsSeqForm: TMsSeqForm
  Left = 0
  Top = 0
  Caption = 'MS MALDI sequencer'
  ClientHeight = 433
  ClientWidth = 622
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object BottomPanel: TAdvPanel
    Left = 0
    Top = 356
    Width = 622
    Height = 77
    Align = alBottom
    Color = clWhite
    TabOrder = 0
    UseDockManager = True
    Version = '2.6.1.0'
    BorderColor = clBlack
    Caption.Color = clWhite
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -12
    Caption.Font.Name = 'Segoe UI'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = clSilver
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 4473924
    StatusBar.Font.Height = -15
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object ViewSpecChk: TAdvOfficeCheckBox
      Left = 24
      Top = 44
      Width = 157
      Height = 20
      Checked = True
      TabOrder = 0
      OnClick = ViewSpecChkClick
      Alignment = taLeftJustify
      Caption = 'View msms spectrum'
      ReturnIsTab = False
      State = cbChecked
      Version = '1.8.1.0'
    end
    object CloseBtn: TAdvGlowButton
      Left = 498
      Top = 32
      Width = 100
      Height = 29
      Caption = 'Exit'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        00000004000000000000000000000000000000000000FF00FF00FF00FF008484
        8400FF00FF0084848400FF00FF0084848400FF00FF0084848400FF00FF008484
        840000000000FF00FF0084848400FF00FF0084848400FF00FF0084848400FF00
        FF0084848400FF00FF0084848400FF00FF0084848400FF00FF0084848400FF00
        FF0000000000000000000000000084848400FF00FF00FF00FF00000000000000
        0000000000000000000000000000000000000000000084848400FF00FF008484
        84000000000084848400848484000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF0000000000FFFF0000FFFF0000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFF0000FFFF0000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF000000FF00000000000000FFFF0000FFFF
        0000000000008484840000000000848484000000000000000000000000000000
        0000000000000000000000000000FF000000FF000000FF00000000000000FFFF
        0000000000000000000000000000848484000000000000000000FF000000FF00
        0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
        00000000000084848400000000008484840000000000FF00FF00000000000000
        0000000000000000000000000000FF000000FF000000FF00000000000000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF000000FF00000000000000FFFF0000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000000000000000000000000FFFF0000FFFF0000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF0000000000FF00FF0000000000FFFF0000FFFF0000FFFF
        00000000000084848400848484008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF
        0000FFFF000000000000000000008484840000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000FFFF0000FFFF0000FFFF
        0000FFFF0000FFFF0000FFFF00000000000000000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      Rounded = True
      TabOrder = 1
      OnClick = CloseBtnClick
      Appearance.BorderColor = 11382963
      Appearance.BorderColorHot = 11565130
      Appearance.BorderColorCheckedHot = 11565130
      Appearance.BorderColorDown = 11565130
      Appearance.BorderColorChecked = 13744549
      Appearance.BorderColorDisabled = 13948116
      Appearance.Color = clWhite
      Appearance.ColorTo = clWhite
      Appearance.ColorChecked = 13744549
      Appearance.ColorCheckedTo = 13744549
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 11565130
      Appearance.ColorDownTo = 11565130
      Appearance.ColorHot = 16444643
      Appearance.ColorHotTo = 16444643
      Appearance.ColorMirror = clSilver
      Appearance.ColorMirrorTo = clWhite
      Appearance.ColorMirrorHot = 16444643
      Appearance.ColorMirrorHotTo = 16444643
      Appearance.ColorMirrorDown = 11565130
      Appearance.ColorMirrorDownTo = 11565130
      Appearance.ColorMirrorChecked = 13744549
      Appearance.ColorMirrorCheckedTo = 13744549
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
    end
    object OpenBtn: TAdvGlowButton
      Left = 24
      Top = 8
      Width = 80
      Height = 24
      Caption = 'Open'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000080100021003000319
        05000521070006280900072F0B00083B0D0009490F000A5411000B6013000B69
        14000B7015000C7616000C7A16000C7D17000C7F17000C8117000C8217000C83
        17000C8317000C8417000C8417000C8417000C8417000C8418000C8418000C84
        18000C8418000C8418000C8318000C8318000C8218000C8118000D8018000D7E
        18000E7C19000F79190010741A00116F1B0014691C0016601E00195920001D50
        2200204924002245260025412800283D2A002A392C002D352E00313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        5200535353005454540055555500565656005757570058585800595959005A5A
        5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F0060606000616161006262
        6200636363006464640065656500666666006767670068686800696969006A6A
        6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F006F7B8000787E9600817F
        AA009176BF00A566D100C247E400E61EF500F60AFC00FC03FE00FE01FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE01FE00FD02FE00FC03FE00FA05FE00F809FE00F310FD00EC1BFB00E12C
        F800D242F300BE62EC00AD7EE300A48FDB00A296D300A19ECA00A1A6BF00A2AE
        B300ABABAB00AFB0B100B2B6B600B6BBBB00B9BFC000BCC3C400C2CACB00C7D0
        D100CDDBDD00D0E6E900D3EFF200D4F3F700D5F5FA00D6F6FB00D8F7FB00D6F7
        FC00D4F7FC00D1F7FC00CEF7FC00CAF6FD00C3F6FC00BAF6FC00B6F7FD00B1F7
        FC00ACF7FC00A9F7FC00A5F7FC00A2F7FD009FF6FD009EF4FD009DF3FC009BF1
        FC0099F0FC0095EEFC0092EBFB008FE9FB008CE7FB0089E5FB0086E3FB0084E1
        FA0080DEF9007BDCFA0079DAF90077DAF90074D8F90072D6F8006DD2F60066CD
        F2005EC7EB0058C3E70050BEE1004BBBDD0048B9D90046B8D40046BACB0046BD
        C10047C0B70047C4AB004BCC980049CD890046CC80003FC679003DC374003BC2
        740038BF730035BC730030B872002CB27D0028AD8B0022A698001A9DAA001396
        B6000D92B9000A8FBC00088EBD00078DBE00078DBE00078DBE00078DBE00078D
        BE00078DBE00078DBD00078DBD00078DBC00078DBB008AFBFBFBFBFBFBFBFBFB
        FBFBFBFB8A8AFBF1DBD2DADADADADADADADAE0FB8A8AFBDEE0CAD8D8D9D8D8D8
        D8D9DFD3FB8AFBD8FBC3D4D4D4D4D4D4D4D4DFC3FB8AFBD4F2CBCDD1D1D1D1D1
        D1D1DFC2FB8AFBD1DFDCC3CECECECECECE1ADEC1DAFBFBCFD6F1B9BEBEBEBEBE
        1AEC1AB9B8FBFBCCCCF2FBFBFBFBFB1AE7E5E91AFBFBFBC8C7C7C8C7C7C81AE7
        E6E6E5E91A8AFBB9C6C6C6C6C61A1A1A1AE6E71A1A1A8AFBB9C5C5C5FFDFDFDF
        1AE7EC1A8A8A8A8AFBFBFBFB8A8A8A8A1AE81A8A8A8A8A8A8A8A8A8A8A8A8A1A
        EDED1A8A8A8A8A8A8A8A8A8A8A8A8A1AED1A8A8A8A8A8A8A8A8A8A8A8A1A1A1A
        1A8A8A8A8A8A8A8A8A8A8A1A1A1A1A8A8A8A8A8A8A8A}
      Rounded = True
      TabOrder = 2
      OnClick = OpenBtnClick
      Appearance.BorderColor = 11382963
      Appearance.BorderColorHot = 11565130
      Appearance.BorderColorCheckedHot = 11565130
      Appearance.BorderColorDown = 11565130
      Appearance.BorderColorChecked = 13744549
      Appearance.BorderColorDisabled = 13948116
      Appearance.Color = clWhite
      Appearance.ColorTo = clWhite
      Appearance.ColorChecked = 13744549
      Appearance.ColorCheckedTo = 13744549
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 11565130
      Appearance.ColorDownTo = 11565130
      Appearance.ColorHot = 16444643
      Appearance.ColorHotTo = 16444643
      Appearance.ColorMirror = clSilver
      Appearance.ColorMirrorTo = clWhite
      Appearance.ColorMirrorHot = 16444643
      Appearance.ColorMirrorHotTo = 16444643
      Appearance.ColorMirrorDown = 11565130
      Appearance.ColorMirrorDownTo = 11565130
      Appearance.ColorMirrorChecked = 13744549
      Appearance.ColorMirrorCheckedTo = 13744549
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.TextColorChecked = 3750459
      Appearance.TextColorDown = 2303013
      Appearance.TextColorHot = 2303013
      Appearance.TextColorDisabled = 13948116
    end
  end
  object ResultGrid: TAdvStringGrid
    Left = 0
    Top = 156
    Width = 622
    Height = 200
    Align = alBottom
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    GridFixedLineColor = 12236209
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 10344697
    ActiveCellColorTo = 6210033
    ControlLook.FixedGradientFrom = 15262687
    ControlLook.FixedGradientTo = 15262687
    ControlLook.FixedGradientMirrorFrom = 15262687
    ControlLook.FixedGradientMirrorTo = 15262687
    ControlLook.FixedGradientHoverFrom = 15000287
    ControlLook.FixedGradientHoverTo = 14406605
    ControlLook.FixedGradientHoverMirrorFrom = 14406605
    ControlLook.FixedGradientHoverMirrorTo = 13813180
    ControlLook.FixedGradientHoverBorder = 12033927
    ControlLook.FixedGradientDownFrom = 14991773
    ControlLook.FixedGradientDownTo = 14991773
    ControlLook.FixedGradientDownMirrorFrom = 14991773
    ControlLook.FixedGradientDownMirrorTo = 14991773
    ControlLook.FixedGradientDownBorder = 14991773
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -12
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -12
    ControlLook.DropDownFooter.Font.Name = 'Segoe UI'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -12
    FilterDropDown.Font.Name = 'Segoe UI'
    FilterDropDown.Font.Style = []
    FilterDropDown.TextChecked = 'Checked'
    FilterDropDown.TextUnChecked = 'Unchecked'
    FilterDropDownClear = '(All)'
    FilterEdit.TypeNames.Strings = (
      'Starts with'
      'Ends with'
      'Contains'
      'Not contains'
      'Equal'
      'Not equal'
      'Larger than'
      'Smaller than'
      'Clear')
    FixedColWidth = 32
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glCustom
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -12
    PrintSettings.Font.Name = 'Segoe UI'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -12
    PrintSettings.FixedFont.Name = 'Segoe UI'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -12
    PrintSettings.HeaderFont.Name = 'Segoe UI'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -12
    PrintSettings.FooterFont.Name = 'Segoe UI'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.Color = 15262687
    SearchFooter.ColorTo = 15262687
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -12
    SearchFooter.Font.Name = 'Segoe UI'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurrence'
    SearchFooter.HintFindPrev = 'Find previous occurrence'
    SearchFooter.HintHighlight = 'Highlight occurrences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SearchFooter.ResultFormat = '(%d of %d)'
    SelectionColor = 16767927
    UIStyle = tsOffice2007Luna
    Version = '8.6.7.0'
    ColWidths = (
      32
      98
      93
      93
      111)
  end
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 156
    Align = alClient
    Color = clWhite
    TabOrder = 2
    UseDockManager = True
    Version = '2.6.1.0'
    Caption.Color = clWhite
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWindowText
    Caption.Font.Height = -12
    Caption.Font.Name = 'Segoe UI'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 0
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = clSilver
    DoubleBuffered = True
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clNone
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 4473924
    StatusBar.Font.Height = -12
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    ExplicitLeft = 336
    ExplicitTop = 60
    ExplicitWidth = 300
    ExplicitHeight = 200
    FullHeight = 200
  end
  object OpenDlg: TOpenDialog
    DefaultExt = 'txt'
    Filter = 
      'text file (*.txt)|*.txt|spreadsheet (*.xls)|*.xls|All files (*.*' +
      ')|*.*'
    Left = 36
    Top = 28
  end
end
