﻿unit MyCustomWindow;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Threading, Vcl.ExtCtrls, Types;
type
  mybutton = (myYes, myOK, myNo, myCancel, myRetry, myAbort, myIgnore, myCustom);
const
  MY_ERROR = 658175;
  MY_WARNING = 710655;
  MY_INFORMATION = 16714250;
  MY_PASS = 704522;
function MyMessageBox(title, content: String; color: Integer; button: TArray<MyButton>; custom: TArray<String> = []; defbutton: Integer = 1): Integer;
function MyInputBox(title, content: String; color: Integer; defcontent: String = ''): String;
procedure MyPictureBox(title, content: String; web: TStream);
function MyPicMsgBox(title, content: String; web: TStream): Boolean;
function MyMultiButtonBox(title: String; color: Integer; button: TArray<String>; defbutton: Integer = 1): Integer;
implementation
uses LanguageMethod;
type
  btn = class(TForm)
    procedure MCWButtonClick(Sender: TObject);
    procedure MCWOKClick(Sender: TObject);
    procedure MCWCancelClick(Sender: TObject);
    procedure MCWShow(Sender: TObject);
    procedure MCWMultiButtonClick(Sender: TObject);
    procedure MCWScrollboxMouseWheel(Sender: TObject;
      Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
  end;
var
  bt: btn;
  tbt: array of TButton;
  ResMessage: Integer;
  ResInput: String;
  ResMsg: Boolean;
  FormMCW: TForm;
  TitleMCW: TLabel;
  PicTitleMCW: TMemo;
  CutMCW: TLabel;
  ContentMCW: TMemo;
  InputMCW: TEdit;
  ScrollBoxMCW: TScrollBox;
  OkMCW, CancelMCW: TButton;
  PictureMCW: TImage;
var
  db: Integer;
  len: Integer;
//初始化窗口
procedure InitMCW(nme: String);
begin
  FormMCW := TForm.Create(nil);
  if (nme = 'MyPictureBox') or (nme = 'MyPicMsgBox') then begin
    with FormMCW do begin
      Name := nme;
      ClientHeight := 730;
      ClientWidth := 988;
      Color := clBtnFace;
      BorderStyle := bsDialog;
      Position := poDesktopCenter;
      OnShow := bt.MCWShow;
      Caption := '';
    end;
    PictureMCW := TImage.Create(FormMCW);
    with PictureMCW do begin
      Parent := FormMCW;
      Name := 'Image';
      Left := 8;
      Top := 8;
      Width := 200;
      Height := 200;
      Stretch := true;
    end;
    PicTitleMCW := TMemo.Create(FormMCW);
    with PicTitleMCW do begin
      Parent := FormMCW;
      Name := 'Title';
      Left := 214;
      Top := 8;
      Width := 766;
      Height := 179;
      Font.Charset := ANSI_CHARSET;
      Font.Name := '微软雅黑';
      Font.Height := -25;
      Font.Style := [fsBold];
      Font.Color := clWindowText;
      Color := clbtnface;
      BorderStyle := bsNone;
      ReadOnly := True;
      ScrollBars := ssVertical;
    end;
    CutMCW := TLabel.Create(FormMCW);
    with CutMCW do begin
      Parent := FormMCW;
      Name := 'CutLine';
      Left := 215;
      Top := 193;
      Width := 765;
      Height := 15;
      AutoSize := true;
      Caption := '------------------------------------------------------------------------------------------------------------------------------------------------------';
    end;
    ContentMCW := TMemo.Create(FormMCW);
    with ContentMCW do begin
      Parent := FormMCW;
      Name := 'Content';
      Left := 8;
      Top := 214;
      Width := 972;
      Height := 467;
      Font.Charset := ANSI_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -19;
      Font.Name := '微软雅黑';
      Color := clbtnface;
      BorderStyle := bsNone;
      ReadOnly := True;
      ScrollBars := ssVertical;
    end;
    if nme = 'MyPicMsgBox' then begin
      OkMCW := TButton.Create(FormMCW);
      with OkMCW do begin
        Parent := FormMCW;
        Name := 'PictureOK';
        Left := 714;
        Top := 687;
        Width := 129;
        Height := 39;
        Caption := GetLanguage('inputbox_button_yes.caption');
        OnClick := bt.MCWOKClick;
      end;
      CancelMCW := TButton.Create(FormMCW);
      with CancelMCW do begin
        Parent := FormMCW;
        Name := 'PictureCancel';
        Left := 851;
        Top := 687;
        Width := 129;
        Height := 39;
        Caption := GetLanguage('inputbox_button_no.caption');
        OnClick := bt.MCWCancelClick;
      end;
    end else begin
      OkMCW := TButton.Create(FormMCW);
      with OkMCW do begin
        Parent := FormMCW;
        Name := 'PictureOK';
        Left := 851;
        Top := 687;
        Width := 129;
        Height := 39;
        Caption := GetLanguage('picturebox_button_ok.caption');
        OnClick := bt.MCWOKClick;
      end;
    end;
    exit;
  end;
  with FormMCW do begin
    Name := nme;
    ClientHeight := 257;
    ClientWidth := 500;
    Color := clBtnFace;
    BorderStyle := bsDialog;
    Position := poDesktopCenter;
    OnShow := bt.MCWShow;
    Caption := '';
  end;
  TitleMCW := TLabel.Create(FormMCW);
  with TitleMCW do begin
    Parent := FormMCW;
    Name := 'Title';
    AutoSize := False;
    Left := 8;
    Top := 8;
    Width := 484;
    Height := 25;
    Font.Charset := ANSI_CHARSET;
    Font.Name := '微软雅黑';
    Font.Height := -20;
    Font.Style := [fsBold];
  end;
  CutMCW := TLabel.Create(FormMCW);
  with CutMCW do begin
    Parent := FormMCW;
    Name := 'CutLine';
    Left := 8;
    Top := 39;
    Width := 484;
    Height := 15;
    AutoSize := true;
    Caption := '-------------------------------------------------------------------------------------------------';
  end;
  if nme = 'MyMultiButtonBox' then begin
    ScrollBoxMCW := TScrollBox.Create(FormMCW);
    with ScrollBoxMCW do begin
      Parent := FormMCW;
      Name := 'ScrollBox';
      Width := 484;
      Height := 193;
      Top := 60;
      Left := 8;
      VertScrollBar.Tracking := true;
      HorzScrollBar.Tracking := true;
      OnMouseWheel := bt.MCWScrollBoxMouseWheel;
    end;
    exit;
  end;
  ContentMCW := TMemo.Create(FormMCW);
  with ContentMCW do begin
    Parent := FormMCW;
    Name := 'Content';
    Left := 8;
    Top := 60;
    Width := 484;
    Height := 126;
    Font.Color := rgb(0, 0, 0);
    Font.Charset := ANSI_CHARSET;
    Font.Name := '微软雅黑';
    Font.Height := -16;
    Color := clbtnface;
    BorderStyle := bsNone;
    ReadOnly := True;
    ScrollBars := ssVertical;
  end;
  if nme = 'MyInputBox' then begin
    InputMCW := TEdit.Create(FormMCW);
    with InputMCW do begin
      Parent := FormMCW;
      Name := 'Input';
      Left := 8;
      Top := 192;
      Width := 484;
      Height := 23;
      Font.Charset := ANSI_CHARSET;
      Text := '';
    end;
    OkMCW := TButton.Create(FormMCW);
    with OkMCW do begin
      Parent := FormMCW;
      Name := 'InputOk';
      Left := 286;
      Top := 221;
      Width := 100;
      Height := 28;
      Caption := GetLanguage('inputbox_button_yes.caption');
      OnClick := bt.MCWOKClick;
    end;
    CancelMCW := TButton.Create(FormMCW);
    with CancelMCW do begin
      Parent := FormMCW;
      Name := 'InputCancel';
      Left := 392;
      Top := 221;
      Width := 100;
      Height := 28;
      Caption := GetLanguage('inputbox_button_no.caption');
      OnClick := bt.MCWCancelClick;
    end;
  end;
end;
procedure btn.MCWScrollboxMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
  LTopLeft, LTopRight, LBottomLeft, LBottomRight: SmallInt;
  LPoint: TPoint;
  ScrollBox: TScrollBox;
begin
  ScrollBox := TScrollBox(Sender);
  LPoint := ScrollBox.ClientToScreen(Point(0,0));
  LTopLeft := LPoint.X;
  LTopRight := LTopLeft + ScrollBox.ClientWidth;
  LBottomLeft := LPoint.Y;
  LBottomRight := LBottomLeft + ScrollBox.ClientWidth;
  if (MousePos.X >= LTopLeft) and
    (MousePos.X <= LTopRight) and
    (MousePos.Y >= LBottomLeft) and
    (MousePos.Y <= LBottomRight) then
  begin
    ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position - WheelDelta;
    Handled := True;
  end;
end;
//多重按钮点击
procedure btn.MCWMultiButtonClick(Sender: TObject);
begin
  var res: String := (Sender as TButton).Name;
  ResMessage := strtoint(res.Replace('b', ''));
  FormMCW.Close;
end;
procedure btn.MCWOKClick(Sender: TObject);
begin
  if FormMCW.Name = 'MyPicMsgBox' then begin
    ResMsg := true;
    FormMCW.Close;
  end else begin
    if (Sender as TButton).Name = 'PictureOK' then begin
      FormMCW.Close;
    end else begin
      ResInput := InputMCW.Text;
      FormMCW.Close;
    end;
  end;
end;
procedure btn.MCWCancelClick(Sender: TObject);
begin
  ResInput := '';
  ResMsg := false;
  FormMCW.Close;
end;
procedure btn.MCWButtonClick(Sender: TObject);
begin
  case (Sender as TButton).Left of
    74: ResMessage := 4;
    180: ResMessage := 3;
    286: ResMessage := 2;
    392: ResMessage := 1;
  end;
  FormMCW.Close;
end;
procedure btn.MCWShow(Sender: TObject);
begin
  if (FormMCW.Name = 'MyPicMsgBox') or (FormMCW.Name = 'MyPictureBox') then begin
    OkMCW.SetFocus;
  end else if FormMCW.Name = 'MyInputBox' then begin
    InputMCW.SetFocus;
  end else if (FormMCW.Name = 'MyMessageBox') or (FormMCW.Name = 'MyMultiButtonBox') then begin
    if (db > len) or (db < 1) then raise Exception.Create('So much default button');
    tbt[db - 1].SetFocus;
  end;
end;
//自定义信息框
function MyMessageBox(title, content: String; color: Integer; button: TArray<MyButton>; custom: TArray<String> = []; defbutton: Integer = 1): Integer;
begin
  TThread.Synchronize(nil, procedure begin
    InitMCW('MyMessageBox');
    ContentMCW.Lines.Clear;
    TitleMCW.Caption := title;
    ContentMCW.Lines.Add(content);
    TitleMCW.Font.Color := color;
    CutMCW.Font.Color := color;
    len := Length(button);
    if (len < 1) or (len > 4) then raise Exception.Create('So much button');
    SetLength(tbt, len);
    for var I := 0 to len - 1 do begin
      tbt[I] := TButton.Create(FormMCW);
      tbt[I].Parent := FormMCW;
      tbt[I].Width := 100;
      tbt[I].Height := 50;
      tbt[I].Top := 192;
      tbt[I].WordWrap := true;
      case I of
        0: tbt[I].Left := 392;
        1: tbt[I].Left := 286;
        2: tbt[I].Left := 180;
        3: tbt[I].Left := 74;
      end;
      tbt[I].OnClick := bt.MCWButtonClick;
    end;
    db := defbutton;
    var O := 0;
    var P := 0;
    for var I := 0 to len - 1 do begin
      case button[I] of
        myYes: tbt[O].Caption := GetLanguage('messagebox_button_yes.caption');
        myOK: tbt[O].Caption := GetLanguage('messagebox_button_ok.caption');
        myNo: tbt[O].Caption := GetLanguage('messagebox_button_no.caption');
        myCancel: tbt[O].Caption := GetLanguage('messagebox_button_cancel.caption');
        myRetry: tbt[O].Caption := GetLanguage('messagebox_button_retry.caption');
        myAbort: tbt[O].Caption := GetLanguage('messagebox_button_abort.caption');
        myIgnore: tbt[O].Caption := GetLanguage('messagebox_button_ignore.caption');
        myCustom: begin tbt[O].Caption := custom[P]; inc(P); end;
      end;
      inc(O);
    end;
    FormMCW.ShowModal;
  end);
  Result := ResMessage;
  ResMessage := 0;
end;
//自定义多按钮框
function MyMultiButtonBox(title: String; color: Integer; button: TArray<String>; defbutton: Integer = 1): Integer;
begin
  TThread.Synchronize(nil, procedure begin
    InitMCW('MyMultiButtonBox');
    TitleMCW.Caption := title;
    TitleMCW.Font.Color := color;
    CutMCW.Font.Color := color;
    len := Length(button);
    SetLength(tbt, len);
    for var I := 0 to len - 1 do begin
      tbt[I] := TButton.Create(ScrollBoxMCW);
      tbt[I].Parent := ScrollBoxMCW;
      tbt[I].Name := Concat('b', inttostr(I + 1));
      tbt[I].Width := 444;
      tbt[I].Height := 40;
      tbt[I].Left := 8;
      tbt[I].Top := 8 + I * 44;
      tbt[I].Caption := button[I];
      tbt[I].WordWrap := true;
      tbt[I].OnClick := bt.MCWMultiButtonClick;
    end;
    db := defbutton;
    FormMCW.ShowModal;
  end);
  Result := ResMessage;
  ResMessage := 0;
end;
//自定义输入框
function MyInputBox(title, content: String; color: Integer; defcontent: String = ''): String;
begin
  TThread.Synchronize(nil, procedure begin
    InitMCW('MyInputBox');
    ContentMCW.Lines.Clear;
    TitleMCW.Caption := title;
    ContentMCW.Lines.Add(content);
    TitleMCW.Font.Color := color;
    CutMCW.Font.Color := color;
    InputMCW.Text := defcontent;
    FormMCW.ShowModal;
  end);
  Result := ResInput;
  ResInput := '';
end;
//自定义图片信息框【专用于模组信息显示】
procedure MyPictureBox(title, content: String; web: TStream);
begin
  TThread.Synchronize(nil, procedure begin
    InitMCW('MyPictureBox');
    PicTitleMCW.Lines.Clear;
    ContentMCW.Lines.Clear;
    PicTitleMCW.Lines.Add(title);
    ContentMCW.Lines.Add(content);
    if web <> nil then
      try PictureMCW.Picture.LoadFromStream(web); except end;
    FormMCW.ShowModal;
  end);
end;
//自定义图片选择框【用于整合包导入时输出文字】
function MyPicMsgBox(title, content: String; web: TStream): Boolean;
begin
  TThread.Synchronize(nil, procedure begin
    InitMCW('MyPicMsgBox');
    PicTitleMCW.Lines.Clear;
    ContentMCW.Lines.Clear;
    PicTitleMCW.Lines.Add(title);
    ContentMCW.Lines.Add(content);
    if web <> nil then
      try PictureMCW.Picture.LoadFromStream(web); except end;
    FormMCW.ShowModal;
  end);
  Result := ResMsg;
  ResMsg := false;
end;
end.

