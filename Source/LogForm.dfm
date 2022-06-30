object FormLog: TFormLog
  Left = 0
  Top = 0
  Caption = 'MS MALDI sequencer - Log'
  ClientHeight = 340
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LogList: TListBox
    Left = 0
    Top = 0
    Width = 724
    Height = 299
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object ButtomPanel: TAdvPanel
    Left = 0
    Top = 299
    Width = 724
    Height = 41
    Align = alBottom
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
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
    object SaveBtn: TAdvGlowButton
      Left = 605
      Top = 6
      Width = 100
      Height = 29
      Caption = 'Save log'
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
        2200232323002424240025252500262626002D282800352B2A003C2D2C00432F
        2E0049313000533433005C3635006C3937007A3A3800833B3800893B38008C3B
        38008F3B3800913A3800923A3700923A37009339360093383600933835009337
        35009336340093363400933433009333320093323100922F2E00922D2D00922C
        2B00922B2B00922B2B00922C2B00922D2C00922E2E0092302F00923231009334
        330094373500943A3700953C3900953D3A00953F3B0097403D0098413E009A42
        3E009A423F009B423F009C4340009E4341009C4340009A433F0099433F009843
        3F0097433F0097433F0096433F0096433F0095434000934541008F4743008A4A
        4700854D4B007F524F0079575500735C5B006F6060006D6363006B6666006A6A
        6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F0070707000717171007272
        7200737373007474740075757500767676007777770078787800797979007A7A
        7A007B7B7B007C7C7C007D7D7D007E7E7E00817B7B008A777700917474009871
        71009E6E6E00A46B6B00A9696900AD676700B1666600B8646400BE636300C162
        6200C4636300C6636300C7646500C8646500C9646500CA656600CB666600CB66
        6600CB666600CA666600CB666600CC666600CD666600CD666600CD666600CD66
        6600CD656600CC656600CB656600CA656600CA666600C9666600C9666600C867
        6700C8686800C86A6A00C86C6C00C76D6D00C66F6E00C6717000C5747300C478
        7700C47C7B00C37F7E00C3858400C48A8A00C5919000C4969500C4989800C299
        9900C59C9B00C89E9E00C9A0A000C9A3A300CAA8A800C9AEAE00CAB3B300CAB9
        B900CBBDBE00CDC1C200CEC5C600CFC8C900CEC9CA00CEC9CA00CECACB00CECA
        CB00CECBCB00CDCBCC00CDCBCC00CECBCC00CDCBCC00CECBCC00CECACC00CFC8
        CC00D2BECF00D6AED200DC94D900E27DDE00E961E500EF47EC00F335F100F721
        F600FB0CFB00FD06FD00FE02FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
        FE00FE00FE00FE00FE00FE00FE00FE00FE00FE01FE00FE02FE00FD07FD00FB1C
        FA00F641F600F169F100ED8CED00E9ACE900E6C5E600E5D4E400E4DAE400E4E0
        E400E5E3E500E6E5E700E8E8E900ECECED00F0F1F100F5F5F500F7F7F700F8F8
        F800F8F8F800F8F8F800F8F8F800F8F8F800F8F8F800DEDEDEDEDEDEDEDEDEDE
        DEDEDEDEDEDEDEDE5B5BB2B2B2B2B2B2B2485BDEDEDEDE5B9A8CF24343F4F3F2
        C943565BDEDEDE5B9B8AF34343F2F4F2C843565BDEDEDE5B9B8AF34343F2F4F4
        C843565BDEDEDE5B9B8AF4F4F2F2F2F2C843565BDEDEDE5B9B8CA2A8A8A48BA5
        9F8B9B5BDEDEDE5B88ABB4B7B7B7B5B5B7B7965BDEDEDE5B96FFFFFFFFFFFFFF
        FFFF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDE5B96FFC7C7C7C7C7C7
        C7FF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDE5B96FFC7C7C7C7C7C7
        C7FF965BDEDEDE5B96FFFFFFFFFFFFFFFFFF965BDEDEDEDE5BFFFFFFFFFFFFFF
        FFFF5BDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDEDE}
      Rounded = True
      TabOrder = 0
      OnClick = SaveBtnClick
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
    object ClearBtn: TAdvGlowButton
      Left = 499
      Top = 6
      Width = 100
      Height = 29
      Caption = 'Clear log'
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      Picture.Data = {
        424DF60000000000000076000000280000001000000010000000010004000000
        000080000000120B0000120B0000000000000000000000000000000080000080
        00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
        000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0050000500055555550000
        0000555055550055000550555555005550055555555550055005005555555500
        5050110555555555050999105555500555099991055550050550999030555500
        5055090B03055555555550B0B03055550555550B0B33555555555550BBB35550
        555555550BBB55555555555550BB555555555555550B}
      Rounded = True
      TabOrder = 1
      OnClick = ClearBtnClick
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
  end
  object SaveDlg: TSaveDialog
    DefaultExt = 'txt'
    Filter = 
      'Text file (*.txt)|*.txt|Log file (*.log)|*.log|All files (*.*)|*' +
      '.*'
    Left = 400
    Top = 307
  end
end
