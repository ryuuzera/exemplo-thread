unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls,
  Vcl.Samples.Gauges, Vcl.ExtCtrls, acPNG;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PN_EVENTOS: TPanel;
    procedure PN_EVENTOSMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PN_EVENTOSMouseLeave(Sender: TObject);
    procedure PN_EVENTOSMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PN_EVENTOSMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);

  private
    procedure TerminaThread(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    FLista: TStringlist
  end;

var
  Form1: TForm1;

  const
  COR_BOTAO_HOVER = $00E32261;
  COR_BOTAO = $009E1441;

implementation

{$R *.dfm}

uses Unit2, Unit3;


procedure TForm1.FormCreate(Sender: TObject);
begin
  AtribuiEventosMouse(Self);
end;

procedure TForm1.Panel2Click(Sender: TObject);
var
  Task : TThread;
begin
  Form2 := TForm2.Create(nil);
  Task := TThread.CreateAnonymousThread(procedure
  var I: Integer;
  begin
    FLista := TStringlist.Create;
    TThread.Synchronize(nil, procedure
    begin
      Form2.Show; //Precisa chamar pelo sincronize
    end);
    for i := 0 to 100 do
    begin
      sleep(100); //Executa algum procedimento
      FLista.Add('Registro '+ i.ToString +' Adicionado na lista');
      TThread.Synchronize(nil, procedure
      begin
        Memo1.Lines.Add('Inserindo Dados no Memo');
        Form2.ProgressBar1.Position := Form2.ProgressBar1.Position +1 //interage com componente visual
      end);
    end;
  end);
  Task.FreeOnTerminate := True;
  Task.OnTerminate := TerminaThread;
  Task.Start;
end;

procedure TForm1.Panel3Click(Sender: TObject);
var i: integer;
begin
  Form2 := TForm2.Create(nil);
  FLista := TStringlist.Create;
  Form2.Show;
  try
    for i := 0 to 100 do
    begin
      sleep(100); //Executa algum procedimento
      FLista.Add('Registro '+ i.ToString +' Adicionado na lista');
      Memo1.Lines.Add('Inserindo Dados no Memo');
      Form2.ProgressBar1.Position := Form2.ProgressBar1.Position +1        //interage com componente visual
    end;
    Showmessage('Tarefa Finalizada!!' + slinebreak + 'Dados da Lista: '+ slinebreak + FLista.Text);
  finally
    Form2.Free;
    FLista.Free;
  end;
end;

procedure TForm1.PN_EVENTOSMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TPanel(Sender).BevelInner := bvLowered;
end;

procedure TForm1.PN_EVENTOSMouseLeave(Sender: TObject);
begin
  MouseLeaveColor(TPanel(Sender));
end;

procedure TForm1.PN_EVENTOSMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  MouseHoverColor(TPanel(Sender));
end;

procedure TForm1.PN_EVENTOSMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TPanel(Sender).BevelInner := bvNone;
end;

procedure TForm1.TerminaThread(Sender: TObject);
begin
  Showmessage('Thread Finalizada!!' + slinebreak + 'Dados da Lista: '+ slinebreak + FLista.Text);
  Form2.Close;
  if Assigned(Form2) then
    Form2.Free;
  Flista.Free;
end;

end.
