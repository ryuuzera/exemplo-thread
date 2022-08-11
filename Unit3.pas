unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.StdCtrls,
  Vcl.Samples.Gauges,Vcl.ExtCtrls, acPNG;

procedure AtribuiEventosMouse(aForm: TForm);
procedure MouseHoverColor(aPanel: TPanel);
procedure MouseLeaveColor(aPanel: TPanel);

implementation

uses Unit1;

procedure AtribuiEventosMouse(aForm: TForm);
var
  i, n, k, index, indexIco: integer;
begin
  for n := 0 to Pred(aForm.ComponentCount) do
  begin
     if (aForm.Components[n].ClassName = 'TPanel') and (aForm.Components[n].Tag = 25) then
      index := n;
  end;
  for i := 0 to Pred(aForm.ComponentCount) do
  begin
    if (aForm.Components[i].ClassName = 'TPanel') and (aForm.Components[i].Tag = 10) then
    begin
      TPanel(aForm.Components[i]).Color := COR_BOTAO;
      TPanel(aForm.Components[i]).OnMouseMove  := TPanel(aForm.Components[index]).OnMouseMove;
      TPanel(aForm.Components[i]).OnMouseLeave :=  TPanel(aForm.Components[index]).OnMouseLeave;
      TPanel(aForm.Components[i]).OnMouseDown :=  TPanel(aForm.Components[index]).OnMouseDown;
      TPanel(aForm.Components[i]).OnMouseUp :=  TPanel(aForm.Components[index]).OnMouseUp;
      TPanel(aForm.Components[i]).Cursor := crHandPoint;
    end;
  end;
end;

procedure MouseHoverColor(aPanel: TPanel);
begin
  aPanel.Color := COR_BOTAO_HOVER;
end;

procedure MouseLeaveColor(aPanel: TPanel);
begin
  aPanel.Color := COR_BOTAO;
end;
end.
