unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.ExtCtrls, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, JSON;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    LoginEdit: TEdit;
    PassEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    GroupEdit: TEdit;
    Label3: TLabel;
    MessageMemo: TMemo;
    AttachEdit: TEdit;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    LogMemo: TMemo;
    StartButton: TButton;
    Timer1: TTimer;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    cmbGroups: TComboBox;
    lstStat: TListBox;
    Label5: TLabel;
    btnInfo: TButton;
    Label6: TLabel;
    procedure GetToken;
    procedure Button1Click(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    function  Pars(st,st_begin,st_end:WideString):WideString;
    procedure cmbGroupsClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  token:string;

implementation

{$R *.dfm}

procedure TForm1.btnInfoClick(Sender: TObject);
begin
  logmemo.Lines.Add('���������-������ ��� ��������������� �����  ��� �������� ��������� ��');
  logmemo.Lines.Add('�����: ������� ������ �-41 ������� ������');
  logmemo.Lines.Add('������� ������ � �����������: ������� ����� � ������ ��� ��������� ������');
  logmemo.Lines.Add('�������� ������ �� ������ ����� ����� (��� �� �����)');
  logmemo.Lines.Add('�� ������ ����� ��������� ����������, � �� ������� ��������� ��������� �� ����� ������');
  logmemo.Lines.Add('������ ��������� ��������� ������! � ��������� ����� ���������� ������.');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  GetToken;
end;

procedure TForm1.StartButtonClick(Sender: TObject);
begin
  if length(token)>0 then timer1.Enabled:=true;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  response:string;
  id:string;
  pos1:integer;
  Info: TStringList;
  group_id: string;
  checkMsg: boolean;
begin
  timer1.Enabled:=false;
  if MessageMemo.Text = '' then begin
    checkMsg:= False;
    logmemo.Lines.Add('������ ��������� ������ ���������!');
  end
  else checkMsg:= True;

  // �������� ID ���������� �����  
  try
    response:=idhttp1.Get('https://api.vk.com/method/wall.get?owner_id=-'+GroupEdit.text+'&access_token='+token+'&v=5.52');
  except
    logmemo.Lines.Add('������ ��������� ID �����');
  end;
  id:=pars(response,'"id":',',"');
  //cmbGroups.Items.Add(token);
  sleep(500);
  // ������� ��������� ����
  if length(id)>0 then
    begin
    try
      //response:=idhttp1.Get('https://api.vk.com/method/wall.delete?owner_id=-'+GroupEdit.text+'&post_id='+id+'&access_token='+token+'&v=5.52');
    except
      logmemo.Lines.Add('������ �������� �����');
    end;
  end;
  //sleep(500);
  // ������� ����� ����
  try

      if checkMsg = True then begin

      //lstStat.Items.Add(cmbGroups.Items.Strings[cmbGroups.ItemIndex]);
      group_id := pars(cmbGroups.Items.Strings[cmbGroups.ItemIndex],'(',')');

      Info := TStringList.Create;
      //Info.Add('owner_id=-'+GroupEdit.text);
      Info.Add('owner_id=-'+group_id);
      Info.Add('from_group=1');
      Info.Add('access_token='+token);
      Info.Add('message='+messagememo.text);
      Info.Add('attachments='+attachedit.text);
      Info.Add('v=5.95');

      response:=idhttp1.Post('https://api.vk.com/method/wall.post',Info);

      end;

  except
    logmemo.Lines.Add('������ �������� �����');
  end;
//  logmemo.Lines.Add(id);

  //logmemo.Lines.Add(response);

  if checkMsg = True then logmemo.Lines.Add('��������� ������������!');

  Info.Free;
end;

function TForm1.Pars(st,st_begin,st_end:WideString):WideString;
begin

  if pos(st_begin,st)<>0 then
    Delete(st,1,pos(st_begin,st)+length(st_begin)-1)
  else
  begin
    Pars:='';
    exit;
  end;
  if pos(st_end,st)<>0 then
    Delete(st,pos(st_end,st),length(st))
  else
  begin
    Pars:='';
    exit;
  end;
    Pars:=st;
  end;

procedure TForm1.cmbGroupsClick(Sender: TObject);
var
  response:string;
  groupStat: string;
  subsCount: string;
  country: string;
  city: string;
  views: string;
  mobile: string;
begin

  //����� ������ � ��������� ����������

  try
    response:=idhttp1.Get('https://api.vk.com/method/stats.get?group_id=182683919&interval=day&intervals_count=1&access_token='+token+'&v=5.95');
    //logmemo.Lines.Add(response);
    lstStat.Clear;

    subsCount:=pars(response,'"reach_subscribers":',',"');
    lstStat.Items.Add('����� �����������: '+subsCount);

    mobile:=pars(response, '"mobile_reach"', ',"');
    lstStat.Items.Add('����� � ���������: '+mobile);

    country:=pars(response,'"countries":',']');
    country:=pars(country,'"name":"','"}');
    lstStat.Items.Add('������ ������: '+country);

    city:=pars(response,'"cities":[{','},');
    city:=pars(city,',"name":"','"');
    lstStat.Items.Add('����� ������: '+city);

    views:=pars(response,'"views":',',"');
    //views:=pars(views,'','');
    lstStat.Items.Add('���������� �� ����: '+views);

  except
    logmemo.Lines.Add('������ ��������� ID �����');
  end;

end;

procedure TForm1.GetToken;
var
  temp: string;

  Info: TStringList;
  parser: TStringList;

  response:string;
  //pars:TArray<string>;

  i, j:integer;

  id: string;

  getGroupName: string;
  pars1:TArray<string>;

  getGroupId: integer;

begin


  try
    response:=idhttp1.Get('https://oauth.vk.com/token?grant_type=password&client_id=2274003&scope=wall&client_secret=hHbZxrka2uZ6jB1inYsH&username='+LoginEdit.Text+'&password='+PassEdit.text+'&v=5.52');
  except
    logmemo.Lines.Add('������ ���������� ��� ��������� access token');

  end;

  if Pos('token', response)<>0 then begin
    temp:=copy(response, pos('access_token":"', response), pos('","expires_in', response)-3);
    delete(temp, 1, 15);
    token:=temp;
    logmemo.Lines.Add('token �������, �� ������������');

    //SMACK DAT SHIT
    //logmemo.Lines.Add(token);
    try
      response:=idhttp1.Get('https://api.vk.com/method/groups.get?extended=1&access_token='+token+'&v=5.95&filter=admin');
      //logmemo.Lines.Add(response);

      try
        getGroupName:=pars(response,'"name":"','","');
        //cmbGroups.Items.Add(getGroupName);
        id:=pars(response,'"id":',',"');
        cmbGroups.Items.Add(getGroupName+', id = ('+id+')');


      except
        logmemo.Lines.Add('WRONG');
      end;

    except
      logmemo.Lines.Add('���� � �� ������');
    end;
    //

  end
  else
  begin
    logmemo.Lines.Add('token �� �������');
  end;

end;

end.

