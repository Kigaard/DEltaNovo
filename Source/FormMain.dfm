object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'DEltaNovo'
  ClientHeight = 758
  ClientWidth = 965
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object BottomPanel: TAdvPanel
    Left = 0
    Top = 719
    Width = 965
    Height = 39
    Align = alBottom
    Color = clWhite
    TabOrder = 0
    UseDockManager = True
    Version = '2.6.0.0'
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
    object CloseBtn: TAdvGlowButton
      Left = 819
      Top = 6
      Width = 100
      Height = 29
      Caption = 'E&xit'
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
      TabOrder = 0
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
    object ShowLogWindowChk: TAdvOfficeCheckBox
      Left = 176
      Top = 6
      Width = 132
      Height = 20
      Checked = True
      TabOrder = 1
      OnClick = ShowLogWindowChkClick
      Alignment = taLeftJustify
      Caption = 'Show log window'
      ReturnIsTab = False
      State = cbChecked
      Version = '1.8.0.5'
    end
    object ShowSpectrumWindowChk: TAdvOfficeCheckBox
      Left = 8
      Top = 6
      Width = 162
      Height = 20
      Checked = True
      TabOrder = 2
      OnClick = ShowSpectrumWindowChkClick
      Alignment = taLeftJustify
      Caption = 'Show spectrum window'
      ReturnIsTab = False
      State = cbChecked
      Version = '1.8.0.5'
    end
    object OpenProjectBtn: TAdvGlowButton
      Left = 713
      Top = 6
      Width = 100
      Height = 29
      Caption = 'Open project'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 3
      OnClick = OpenProjectBtnClick
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
    Top = 552
    Width = 965
    Height = 167
    Align = alBottom
    ColCount = 11
    DrawingStyle = gdsClassic
    FixedColor = 6710886
    FixedCols = 0
    RowCount = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goThumbTracking, goFixedColClick, goFixedRowDefAlign]
    ParentFont = False
    TabOrder = 1
    OnClick = ResultGridClick
    OnDrawCell = ResultGridDrawCell
    OnFixedCellClick = ResultGridFixedCellClick
    GridLineColor = 14474202
    GridFixedLineColor = 14474202
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = 16250613
    ActiveCellColorTo = 16250613
    Bands.Active = True
    BorderColor = 15000546
    ColumnHeaders.Strings = (
      'ID'
      'Sequence'
      'Score'
      'Precursor'
      'Mass deviation'
      'Basis N'
      'Mod N'
      'Combined N'
      'Basis C'
      'Mod C'
      'Combined C')
    ColumnSize.Stretch = True
    ControlLook.FixedGradientMirrorFrom = 16250613
    ControlLook.FixedGradientMirrorTo = 16250613
    ControlLook.FixedGradientHoverFrom = 16248808
    ControlLook.FixedGradientHoverTo = 16248808
    ControlLook.FixedGradientHoverMirrorFrom = 16248808
    ControlLook.FixedGradientHoverMirrorTo = 16248808
    ControlLook.FixedGradientHoverBorder = 16371364
    ControlLook.FixedGradientDownFrom = 16244937
    ControlLook.FixedGradientDownTo = 16244937
    ControlLook.FixedGradientDownMirrorFrom = 16244937
    ControlLook.FixedGradientDownMirrorTo = 16244937
    ControlLook.FixedGradientDownBorder = 14983778
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
    FixedColWidth = 97
    FixedRowHeight = 22
    FixedRowAlways = True
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clBlack
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    HoverButtons.Buttons = <>
    HTMLSettings.ImageFolder = 'images'
    HTMLSettings.ImageBaseName = 'img'
    Look = glOffice2007
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
    RowHeaders.Strings = (
      'Sequence'
      'Score')
    SearchFooter.Color = 16250613
    SearchFooter.ColorTo = 16250613
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
    SelectionColor = 14327846
    SelectionTextColor = clWhite
    ShowDesignHelper = False
    SortSettings.HeaderColor = 16250613
    SortSettings.HeaderColorTo = 16250613
    SortSettings.HeaderMirrorColor = 16250613
    SortSettings.HeaderMirrorColorTo = 16250613
    UIStyle = tsWindows10
    Version = '8.6.4.2'
    ColWidths = (
      97
      96
      96
      96
      96
      96
      96
      96
      96
      96
      0)
  end
  object SettingsPanel: TAdvPanel
    Left = 0
    Top = 0
    Width = 965
    Height = 504
    Align = alClient
    TabOrder = 2
    UseDockManager = True
    Version = '2.6.0.0'
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
    StatusBar.Font.Height = -12
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object Label7: TLabel
      Left = 12
      Top = 14
      Width = 93
      Height = 15
      Alignment = taRightJustify
      Caption = 'Basis N-terminus:'
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 12
      Top = 40
      Width = 115
      Height = 15
      Caption = 'Modified N-terminus:'
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 12
      Top = 69
      Width = 92
      Height = 15
      Caption = 'Basis C-terminus:'
      Layout = tlCenter
    end
    object Label15: TLabel
      Left = 261
      Top = 156
      Width = 93
      Height = 15
      Caption = 'MS/MS precision:'
      Layout = tlCenter
    end
    object Label13: TLabel
      Left = 713
      Top = 37
      Width = 22
      Height = 15
      Caption = #916'M:'
      Layout = tlCenter
    end
    object Label14: TLabel
      Left = 714
      Top = 95
      Width = 22
      Height = 15
      Caption = #916'M:'
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 200
      Top = 454
      Width = 60
      Height = 15
      Caption = 'main peaks'
      Layout = tlCenter
    end
    object Label12: TLabel
      Left = 15
      Top = 422
      Width = 232
      Height = 15
      Alignment = taCenter
      Caption = 'Settings for (Semi-)automatic sequencing'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 12
      Top = 127
      Width = 40
      Height = 15
      Caption = 'Project:'
      Layout = tlCenter
    end
    object Label21: TLabel
      Left = 16
      Top = 245
      Width = 120
      Height = 15
      Caption = 'Variable modifications:'
    end
    object Label22: TLabel
      Left = 200
      Top = 245
      Width = 107
      Height = 15
      Caption = 'Fixed modifications:'
    end
    object Label23: TLabel
      Left = 16
      Top = 224
      Width = 75
      Height = 15
      Alignment = taCenter
      Caption = 'Modifications'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label24: TLabel
      Left = 388
      Top = 364
      Width = 90
      Height = 15
      Caption = 'Modification file:'
    end
    object FileModLabel: TLabel
      Left = 502
      Top = 364
      Width = 3
      Height = 15
    end
    object Label27: TLabel
      Left = 14
      Top = 454
      Width = 89
      Height = 15
      Caption = 'Select maximum'
      Layout = tlCenter
    end
    object Label28: TLabel
      Left = 261
      Top = 185
      Width = 32
      Height = 15
      Caption = 'Show '
      Layout = tlCenter
    end
    object Label29: TLabel
      Left = 390
      Top = 185
      Width = 127
      Height = 15
      Caption = 'highest candidate peaks'
      Layout = tlCenter
    end
    object Label17: TLabel
      Left = 286
      Top = 454
      Width = 113
      Height = 15
      Caption = 'Minimum tag length:'
      Layout = tlCenter
    end
    object Label20: TLabel
      Left = 12
      Top = 98
      Width = 114
      Height = 15
      Caption = 'Modified C-terminus:'
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 714
      Top = 185
      Width = 113
      Height = 15
      Caption = 'C-term mass change:'
      Layout = tlCenter
    end
    object Label16: TLabel
      Left = 713
      Top = 156
      Width = 114
      Height = 15
      Caption = 'N-term mass change:'
      Layout = tlCenter
    end
    object DeltaMassNTxt: TAdvEdit
      Left = 741
      Top = 37
      Width = 60
      Height = 23
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      Suffix = ' Da'
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 0
      Text = '0.00'
      Visible = True
      Version = '4.0.1.1'
    end
    object DeltaMassCTxt: TAdvEdit
      Left = 742
      Top = 95
      Width = 60
      Height = 23
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      Suffix = ' Da'
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 1
      Text = '0.00'
      Visible = True
      Version = '4.0.1.1'
    end
    object PrecisionDaTxt: TAdvEdit
      Left = 360
      Top = 156
      Width = 60
      Height = 23
      EditType = etFloat
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      Suffix = ' Da'
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 2
      Text = '0.1'
      Visible = True
      OnChange = PrecisionDaTxtChange
      Version = '4.0.1.1'
    end
    object FileBasisCTxt: TEdit
      Left = 133
      Top = 69
      Width = 493
      Height = 23
      ReadOnly = True
      TabOrder = 3
    end
    object FileBasisNTxt: TEdit
      Left = 133
      Top = 11
      Width = 493
      Height = 23
      ReadOnly = True
      TabOrder = 4
    end
    object FileModNTxt: TEdit
      Left = 133
      Top = 40
      Width = 493
      Height = 23
      ReadOnly = True
      TabOrder = 5
    end
    object RunBtn: TAdvGlowButton
      Left = 790
      Top = 459
      Width = 129
      Height = 33
      Caption = '&Run'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        0200030303000404040005050500060606000707070008080800090909000A0A
        0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F0010101000111111001212
        1200131313001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C0046433E00655646007D654D009B775300B4875A00C492
        6000D19B6400DAA16700E0A46700E3A56700E4A56500E4A46200E4A25F00E49F
        5900E29C5400E0974D00DF944800DE924500DE8F4100DD8F4000DD8E3F00DD8D
        3E00DD8D3C00DD8C3A00DD8A3700DC893500DC883400DB863100D9842D00D67E
        2600D57A2000D3781D00D2751900D0721700CF711500CF701300CF6E0F00D06D
        0B00D06B0700CF6A0400D0690300CE680200CD670100CB660100CA650100C964
        0200C8640200C7630300C7620300C4620400C2610600BF600800BC5F0A00B85E
        0C00B55D0E00B35B0E00B15A1000AF591100AC581200A8551400A4531500A252
        1600A1521700A05117009F5118009C4F1900974D1C00924A1E008C4721008644
        2300824225007F4026007C3F2800793D2900773C2A00753B2B00723A2D007039
        2E006E382F006E393100703B32007340350078483C0081584A00886B5F008C78
        6F008F807A0091858000938B870094908E009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00ACACAC00ADADAD00B2B0AD00B8B3AE00BDB5AE00C1B8AE00C5BA
        AF00CCBCAB00D4BDA500DCBEA000E3BF9A00E7BF9500EABE9200EBBE9000EDBE
        8D00EEBE8D00EEBF8E00EEC09100EEC29400EFC49800EFC69D00EFC9A200F0CB
        A500F1CDA900F1CFAC00F1D0AE00F2D1B000F3D4B300F4D6B700F5D8BC00F6DC
        C300F6E0C900F7E2CC00F8E5D200F9E9D900FAECDD00FAEDDF00FBEEE100FBEF
        E300FBF1E600FCF2E900FCF4EC00FCF5EE00FDF6F000FDF8F200FDF9F500FEFA
        F700FEFBF900FEFDFB00FEFDFC00FEFDFC00FEFDFD00FEFDFC00FEFCFB00FEFC
        FA00FEFBF900FEFAF700FEF9F500FDF8F300FDF7F200FDF5F100FDF2F000FDE8
        EF00FDDEEF00FDD4EF00FDC8F000FDBAF000FDA0F200FD7DF400FE56F700FE3A
        F900FE23FB00FE14FC00FE0BFD00FE05FE00FE02FE00FE01FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FCFCFCFCFC8C8B83838B
        8CFCFCFCFCFCFCFCFC8984766F68686E75838CFCFCFCFCFC8578656566696767
        6565788CFCFCFC837665695FB7546D69686865788CFCFC7F65666961CDD44E6D
        6968686583FC7870625E605DCBDFD746696A6865748C765D5A595959CCDFDFDF
        B7616A666E8C73554E50504ECDDFDFDFDFC95E69678B7249464A4A4ACEDFDFDF
        DFC35F6967897546C2464646CFDFDFDFBA6D6A666E8C734CCAC3BBBBD1DFD446
        64696865758CFC5FC3D1C7BCD4D2495B5D68696584FCFC724ECCD3C8C9465659
        5D63657A8AFCFCFC744EC8D1CCC2BA464B5B7985FCFCFCFCFC745F44B8C2BE45
        5A7F85FCFCFCFCFCFCFCFC767375787779FCFCFCFCFC}
      Rounded = True
      TabOrder = 6
      OnClick = RunBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object LeuIleEqualChk: TAdvOfficeCheckBox
      Left = 535
      Top = 156
      Width = 160
      Height = 23
      TabOrder = 7
      Alignment = taLeftJustify
      Caption = 'Leucine (L) = Isoleucine (I)'
      ReturnIsTab = False
      Version = '1.8.0.5'
    end
    object LysGlnEqualChk: TAdvOfficeCheckBox
      Left = 535
      Top = 185
      Width = 160
      Height = 23
      TabOrder = 8
      Alignment = taLeftJustify
      Caption = 'Lysine (K) = Glutamine (Q)'
      ReturnIsTab = False
      Version = '1.8.0.5'
    end
    object FileProjectTxt: TEdit
      Left = 133
      Top = 127
      Width = 493
      Height = 23
      ReadOnly = True
      TabOrder = 9
    end
    object MinTagLengthUd: TAdvUpDownEdit
      Left = 405
      Top = 454
      Width = 85
      Height = 23
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 10
      MaxValue = 30
      IncrementFloat = 1.000000000000000000
      Text = '2'
      Value = 2.000000000000000000
    end
    object EditModificationBtn: TAdvGlowButton
      Left = 388
      Top = 388
      Width = 145
      Height = 23
      Caption = 'Edit modifications'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000980000009800000098
        0000009800000098000000980000009800000098000000980000009800000097
        0000009700000095000000920000018E01000188010002800200047504000763
        0700095409000C450C000F3A0F0010341000132D130015271500172017001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        5200535353005454540055555500565656005757570058585800595959005A5A
        5A005B5B5B005C5C5C005D5D5D005E5E5E006867650073706C007D787300958F
        8800A9A29A00B9B2AA00CAC2B800D9D0C500E8DED200F1E8DD00F8F0E700FBF5
        ED00FDF8F200FEF9F500FEFAF600FEFBF700FEFCF800FEFCF900FEFCFA00FEFC
        FA00FEFCFA00FEFCFA00FEFCF900FEFBF800FEFBF700FEFAF400FEF9F200FEF8
        F000FEF7EF00FEF7EE00FEF6ED00FEF6EC00FEF5EB00FEF5EA00FEF4E900FEF4
        E800FEF3E600FEF2E400FEF1E200FEF0DE00FEEFDD00FEEEDB00FEEDDA00FEED
        D900FEEDD900FEEDD800FEECD800FEECD700FEEBD600FEEBD500FEEBD400FEEA
        D300FEE9D100FEE8CF00FEE8CE00FEE7CC00FEE5C900FEE3C500FEE2C200FEE1
        C000FEE0BE00FEDFBD00FEDFBC00FEDFBC00FEDEBB00FEDEBA00FEDDB900FEDD
        B800FDDCB700FDDCB600FDDBB500FDDBB500FCDBB700FBDBB800F9DBB900F6DA
        BA00F1D7BA00EAD3BA00E2CFB900D9C9B700CBC0B400C1BAB200B5B3B100B2B2
        B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9B900BABA
        BA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C4B5C400C9A9
        C900CD9FCD00D295D200D58BD500DB7ADB00E263E200E850E800ED40ED00F133
        F100F526F500F916F900FB0CFB00FD07FD00FD04FD00FE02FE00FE01FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FC00FA0CE500F420C000EC3A8C00E5515F00DE653700DB712100D87A0F00D77E
        0700D6800200D6810100D6810000D6810000D5820000D5820000D5820000D582
        0000D5820000D5820000D5820000D5820000D5820000DEDEDEDEDEDEDEDEDEDE
        DEDEDEDEDEDEDEDEFBFBFBFBFBFBFBFBFBFBFBFBDEDEDEFB8890949698999DA2
        A5A5A5A5FBDEDEFB868990939798999CA2A5A5A5FBDEDEFB8409090909090909
        090909A5FBDEDEFB80848688909496989A9DA2A5FBDEDEFB7C09090909090909
        090909A2FBDEDEFB797C80838688909497989A9DFBDEDEFB6E09090909090909
        0909099AFBDEDEFB726E797C8184868890949698FBDEDEFB7109090909090909
        09090997FBDEDEFB7171756E797C808387889094FBDEDEFB7109090909090909
        09090990FBDEDEFB71717171756E797C80838688FBDEDEDEFBFBFBFBFBFBFBFB
        FBFBFBFBDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE}
      Rounded = True
      TabOrder = 11
      OnClick = EditModificationBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object SelectModFileBtn: TAdvGlowButton
      Left = 539
      Top = 388
      Width = 137
      Height = 23
      Caption = 'Select modification file'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Rounded = True
      TabOrder = 12
      OnClick = SelectModFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object VarModSelect: TListBox
      Left = 12
      Top = 266
      Width = 182
      Height = 150
      ExtendedSelect = False
      ItemHeight = 15
      MultiSelect = True
      TabOrder = 13
      OnClick = VarModSelectClick
    end
    object FixModSelect: TListBox
      Left = 200
      Top = 266
      Width = 182
      Height = 150
      ExtendedSelect = False
      ItemHeight = 15
      MultiSelect = True
      TabOrder = 14
      OnClick = FixModSelectClick
    end
    object BrowseBaseNFileBtn: TAdvGlowButton
      Left = 632
      Top = 11
      Width = 75
      Height = 23
      Caption = 'Browse...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 15
      OnClick = BrowseBaseNFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object BrowseModNFileBtn: TAdvGlowButton
      Left = 632
      Top = 40
      Width = 75
      Height = 23
      Caption = 'Browse...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 16
      OnClick = BrowseModNFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object BrowseBaseCFileBtn: TAdvGlowButton
      Left = 632
      Top = 69
      Width = 75
      Height = 23
      Caption = 'Browse...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 17
      OnClick = BrowseBaseCFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object BrowseSaveProjectFileBtn: TAdvGlowButton
      Left = 632
      Top = 127
      Width = 170
      Height = 23
      Caption = 'Select project location...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 18
      OnClick = BrowseSaveProjectFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object MaxMainPeaksUd: TAdvUpDownEdit
      Left = 109
      Top = 454
      Width = 85
      Height = 23
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 19
      MaxValue = 250
      IncrementFloat = 1.000000000000000000
      Text = '10'
      Value = 10.000000000000000000
    end
    object CandidateShowPeaksUd: TAdvUpDownEdit
      Left = 299
      Top = 185
      Width = 85
      Height = 23
      EmptyTextFocused = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = 4474440
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      TabOrder = 20
      MaxValue = 250
      MinValue = 1
      IncrementFloat = 1.000000000000000000
      Text = '5'
      Value = 5.000000000000000000
    end
    object BrowseModCFileBtn: TAdvGlowButton
      Left = 632
      Top = 98
      Width = 75
      Height = 23
      Caption = 'Browse...'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424D360500000000000036040000280000001000000010000000010008000000
        0000000100000000000000000000000100000001000000000000010101000202
        020003090300040F0400041A060005270700053B08000549090005570A000460
        0A0004640B0005600B0005580B00074B0C00093E0D000C2D0E000E230F00101C
        1100121812001414140015151500161616001717170018181800191919001A1A
        1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F0020202000212121002222
        2200232323002424240025252500262626002727270028282800292929002A2A
        2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F0030303000313131003232
        3200333333003434340035353500363636003737370038383800393939003A3A
        3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F0040404000414141004242
        4200434343004444440045454500464646004747470048484800494949004A4A
        4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F0050505000515151005252
        52005353530054545400555555005656560057575700625262007F447F009738
        9700B926B900E011E000F405F400FB02FB00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01
        FE00FD01FD00FC03FC00FA05FA00F708F700F20EF200EB16EB00E023E000D135
        D100C347C300B25DB200A86BA800A274A2009C7D9C0096879600919191009292
        9200939393009494940095959500969696009797970098989800999999009A9A
        9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1A100A2A2
        A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9A900AAAA
        AA00ABABAB00AEB0B000B1B6B600B5C0C200B8CACD00BBD4D800BCDCE200C2E6
        EC00C6ECF200C8EFF500CAF2F800CDF3F900CAF4FA00C7F4FB00C5F5FC00C2F5
        FC00BDF5FC00B4F5FC00ACF5FC00A2F5FC0098F4FC0094F5FC0092F4FC008EF4
        FC008AF3FC0087F3FC0086F1FC0084EFFC0081EDFB007EEBFB007BE8FB0078E5
        FA0077E1FA0075DFF90071DDF9006DDAF90069D7F80065D3F80062D1F8005FD0
        F8005DCEF8005ACCF80058CAF70056C9F70054C7F60051C5F4004EC2F10048BD
        EA0041B6E2003BB1DC0035ACD70031A8D4002DA4D10029A0CE00279DCB002399
        C8002197C6001F94C4001B90C1001489BB000C7FB4000578AF000477AE000375
        AD000275AC000274AC000274AC000274AC000274AC000274AB000375A9000579
        A300087F9800108C89001A9D790021A96F0024AF680022AB610022AB590023AD
        4F0021AB490021AA420020A83C001EA638001BA2330070EEEEEEEEEEEEEEEEEE
        EEEEEEEE7070EEE6DBD0D9D9D9D9D9D9D9D9E2EE7070EEDDE4CBD7D7D7D7D7D7
        D7D7E1D0EE70EED5EEBFD2D2D2D2D2D2D2D2E0BFEE70EED2E7CCCBCECECECECE
        CECEDFBEEE70EECEDFDCBFCACACACACACA0BDEBEDAEEEECDD2E7B6BCBBBBBBBC
        0BFC0BB6B5EEEEC8C8E7EEEEEEEEEE0BF7F7FA0BEEEEEEC5C4C4C5C4C4C50BFA
        F7F7F7FA0B70EEB6C3C3C3C3C30B0B0B0BF7FA0B0B0B70EEB6C2C2C2F0DFDFDF
        0BF8FD0B70707070EEEEEEEE707070700BFA0B7070707070707070707070700B
        FFFF0B7070707070707070707070700BFF0B70707070707070707070700B0B0B
        0B707070707070707070700B0B0B0B70707070707070}
      Rounded = True
      TabOrder = 21
      OnClick = BrowseModCFileBtnClick
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
      Appearance.ColorMirror = clWhite
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
    object FileModCTxt: TEdit
      Left = 133
      Top = 98
      Width = 493
      Height = 23
      ReadOnly = True
      TabOrder = 22
    end
    object BasisNCSpectraEqualChk: TAdvOfficeCheckBox
      Left = 713
      Top = 66
      Width = 192
      Height = 23
      TabOrder = 23
      OnClick = BasisNCSpectraEqualChkClick
      Alignment = taLeftJustify
      Caption = 'Basis N- and C-terminus equal'
      ReturnIsTab = False
      Version = '1.8.0.5'
    end
    object LoadAllSpectraChk: TAdvOfficeCheckBox
      Left = 713
      Top = 8
      Width = 206
      Height = 23
      TabOrder = 24
      Alignment = taLeftJustify
      Caption = 'Load all spectra (Only for MGF files)'
      ReturnIsTab = False
      Version = '1.8.0.5'
    end
    object SequencingModeCb: TAdvOfficeRadioGroup
      Left = 16
      Top = 156
      Width = 239
      Height = 52
      BorderColor = 12895944
      CaptionFont.Charset = DEFAULT_CHARSET
      CaptionFont.Color = clWindowText
      CaptionFont.Height = -11
      CaptionFont.Name = 'Tahoma'
      CaptionFont.Style = []
      Transparent = False
      Version = '1.8.0.5'
      Caption = 'Sequencing mode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 3881787
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentCtl3D = True
      ParentFont = False
      TabOrder = 25
      OnClick = SequencingModeCbClick
      UIStyle = tsOffice2019White
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Manual'
        'Automatic')
      ButtonVertAlign = tlBottom
      Ellipsis = False
    end
    object CTermMassTxt: TAdvEdit
      Left = 833
      Top = 182
      Width = 60
      Height = 23
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      Suffix = ' Da'
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 26
      Text = '0.00'
      Visible = True
      Version = '4.0.1.1'
    end
    object NTermMassTxt: TAdvEdit
      Left = 833
      Top = 153
      Width = 60
      Height = 23
      EmptyTextStyle = []
      FlatLineColor = 11250603
      FocusColor = clWindow
      FocusFontColor = 3881787
      Suffix = ' Da'
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Font.Charset = DEFAULT_CHARSET
      Lookup.Font.Color = clWindowText
      Lookup.Font.Height = -11
      Lookup.Font.Name = 'Arial'
      Lookup.Font.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 27
      Text = '0.00'
      Visible = True
      Version = '4.0.1.1'
    end
    object EnsureTagConnectChk: TAdvOfficeCheckBox
      Left = 516
      Top = 454
      Width = 149
      Height = 23
      TabOrder = 28
      Alignment = taLeftJustify
      Caption = 'Ensure tag connectivity'
      ReturnIsTab = False
      Version = '1.8.0.5'
    end
  end
  object ResultPanel: TAdvPanel
    Left = 0
    Top = 504
    Width = 965
    Height = 48
    Align = alBottom
    TabOrder = 3
    UseDockManager = True
    Version = '2.6.0.0'
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
    StatusBar.Font.Height = -12
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = clWhite
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 200
    object Label1: TLabel
      Left = 9
      Top = 6
      Width = 54
      Height = 15
      Caption = 'Sequence:'
    end
    object Label2: TLabel
      Left = 250
      Top = 6
      Width = 58
      Height = 15
      Caption = 'Tag length:'
    end
    object Label3: TLabel
      Left = 8
      Top = 27
      Width = 85
      Height = 15
      Caption = 'Precursor (m/z):'
    end
    object Label4: TLabel
      Left = 250
      Top = 27
      Width = 41
      Height = 15
      Caption = 'Charge:'
    end
    object Label5: TLabel
      Left = 405
      Top = 27
      Width = 55
      Height = 15
      Caption = 'Mass (Da):'
    end
    object SequenceResultLabel: TLabel
      Left = 125
      Top = 6
      Width = 3
      Height = 15
    end
    object ScoreResultLabel: TLabel
      Left = 466
      Top = 6
      Width = 3
      Height = 15
    end
    object PrecursorResultLabel: TLabel
      Left = 125
      Top = 27
      Width = 3
      Height = 15
    end
    object ChargeResultLabel: TLabel
      Left = 314
      Top = 27
      Width = 3
      Height = 15
    end
    object MassResultLabel: TLabel
      Left = 466
      Top = 27
      Width = 3
      Height = 15
    end
    object Label11: TLabel
      Left = 405
      Top = 6
      Width = 32
      Height = 15
      Caption = 'Score:'
    end
    object TagLengthResultLabel: TLabel
      Left = 314
      Top = 6
      Width = 3
      Height = 15
    end
    object Label18: TLabel
      Left = 535
      Top = 6
      Width = 84
      Height = 15
      Caption = 'Modification(s):'
    end
    object ModificationResultLabel: TLabel
      Left = 535
      Top = 27
      Width = 3
      Height = 15
    end
  end
  object SpectrumOpenDlg: TOpenDialog
    DefaultExt = 'txt'
    Filter = 
      'MGF file (*.mgf)|*.mgf|MALDI files (*.txt, *.xls)|*.txt;*.xls|Al' +
      'l files (*.*)|*.*'
    Left = 684
    Top = 100
  end
  object ProjectOpenDlg: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'De Novo Sequencer Project file (*.dnproj)|*.dnproj'
    Left = 724
    Top = 596
  end
  object ProjectSaveDlg: TSaveDialog
    DefaultExt = '.dnproj'
    Filter = 'De Novo Sequencer Project file (*.dnproj)|*.dnproj'
    Left = 648
    Top = 128
  end
  object ModOpenDlg: TOpenDialog
    DefaultExt = '*.MOD'
    Filter = 'Modification file (*.MOD)|*.MOD'
    Left = 656
    Top = 384
  end
end
