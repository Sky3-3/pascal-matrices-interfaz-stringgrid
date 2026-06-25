unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_cargar: TButton;
    btn_elefila: TButton;
    btn_elecol: TButton;
    btn_letrarepeat: TButton;
    btn_letramay: TButton;
    btn_letracam: TButton;
    btn_mostrar: TButton;
    btn_m: TButton;
    btn_letrawhile: TButton;
    btn_letracontar: TButton;
    edt_letrarepeat: TEdit;
    edt_col: TEdit;
    grid_letras: TStringGrid;
    lbl_m: TLabel;
    lbl_leting: TLabel;
    procedure btn_cargarClick(Sender: TObject);
    procedure btn_elecolClick(Sender: TObject);
    procedure btn_elefilaClick(Sender: TObject);
    procedure btn_letracamClick(Sender: TObject);
    procedure btn_letracontarClick(Sender: TObject);
    procedure btn_letramayClick(Sender: TObject);
    procedure btn_letrarepeatClick(Sender: TObject);
    procedure btn_letrawhileClick(Sender: TObject);
    procedure btn_mClick(Sender: TObject);
    procedure btn_mostrarClick(Sender: TObject);
  private

  public

  end;

const
     fil_max=5;
     col_max=5;
var
  Form1: TForm1;
  letras:array [0..fil_max, 0..col_max] of char;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btn_cargarClick(Sender: TObject);
var
   f,c:integer;
   letra:char;
begin
     randomize;
     for f:=0 to fil_max do
     begin
          for c:=0 to col_max do
          begin
               letra:= chr(random(26)+97);
               letras[c,f]:=letra;
          end;
     end;
end;

procedure TForm1.btn_elecolClick(Sender: TObject);
var
   c, col_elegida: integer;
   palabra_resultante: string;
begin
     col_elegida := strtoint(edt_col.text[1]);

     if (col_elegida >= 0) and (col_elegida <= col_max) then
     begin
          palabra_resultante := '';

          for c:= 0 to col_max do
          begin
               palabra_resultante := palabra_resultante + letras[col_elegida,c];
          end;

          showmessage('Las letras de la fila ' + inttostr(col_elegida) + ' forman: ' + palabra_resultante);
     end
     else
     begin
          showmessage('Error: Ingresá una columna válida entre 0 y 5.');
     end;
end;


procedure TForm1.btn_elefilaClick(Sender: TObject);
var
   f, fila_elegida: integer;
   palabra_resultante: string;
begin
     fila_elegida := strtoint(inputbox('Concatenar Fila', 'Ingresá el número de fila (0 a 5):', ''));

     if (fila_elegida >= 0) and (fila_elegida <= fil_max) then
     begin
          palabra_resultante := '';

          for f := 0 to fil_max do
          begin
               palabra_resultante := palabra_resultante + letras[f, fila_elegida];
          end;

          showmessage('Las letras de la fila ' + inttostr(fila_elegida) + ' forman: ' + palabra_resultante);
     end
     else
     begin
          showmessage('Error: Ingresá una fila válida entre 0 y 5.');
     end;
end;

procedure TForm1.btn_letracamClick(Sender: TObject);
var
   fila_user, col_user: integer;
begin
     fila_user := strtoint(inputbox('Modificar Celda', 'Ingresá Fila (0 a 5):', '0'));
     col_user := strtoint(inputbox('Modificar Celda', 'Ingresá Columna (0 a 5):', '0'));

     if (fila_user >= 0) and (fila_user <= fil_max) and (col_user >= 0) and (col_user <= col_max) then
     begin
          letras[col_user, fila_user] := UpCase(letras[col_user, fila_user]);

          grid_letras.cells[col_user, fila_user] := letras[col_user, fila_user];
     end;
end;

procedure TForm1.btn_letracontarClick(Sender: TObject);
var
   f,c,cant_letra:integer;
   letra_ing:string;
   encontrado: boolean=false;
begin
     letra_ing:=inputbox('Contar letra', 'Ingrese letra a contar', '');
     cant_letra:=0;

     for f:=0 to fil_max do
     begin
          for c:=0 to col_max do
          begin
               if letras[f,c]=letra_ing[1] then
               begin
                  cant_letra:=cant_letra+1;
                  lbl_leting.caption:=lbl_leting.caption+ '['+inttostr(f)+';'+inttostr(c)+']';
                  encontrado := true;
               end;
          end;
     end;
     if encontrado=true then
          lbl_leting.caption := lbl_leting.caption + ' de la letra ' + letra_ing[1] + ' y las veces que aparece son ' +
          inttostr(cant_letra);
end;

procedure TForm1.btn_letramayClick(Sender: TObject);
var
   f,c:integer;
   letra_mayor,letra_comp:integer;
   letra_enc:char;
   pos_fc:string;
begin
     letra_mayor:=0;
     letra_comp:=0;

     for f:=0 to fil_max do
     begin
          for c:=0 to col_max do
          begin
               letra_comp:=ord(letras[f,c]);

               if letra_comp > letra_mayor then
               begin
                  letra_mayor:= letra_comp;
                  pos_fc:='[' + inttostr(c) + '; ' + inttostr(f) + ']';
               end
               else if (letra_comp = letra_mayor) and (letra_mayor <> 0) then
               begin
                    pos_fc := pos_fc + '[' + inttostr(c) + '; ' + inttostr(c) + '] ';
               end;
          end;
     end;

     letra_enc:=chr(letra_mayor);

     showmessage('La mayor letra del abecedario es la ' + letra_enc
                 + ' y sus posiciones son ' + pos_fc);
end;

procedure TForm1.btn_letrarepeatClick(Sender: TObject);
var
   f,c:integer;
   letra_buscar_edt,pos_fc:string;
begin
     letra_buscar_edt:=edt_letrarepeat.text;

     f:=0;
     pos_fc := '';

     repeat
          c:=0;

          repeat
               if letras[c,f]=letra_buscar_edt[1] then
               begin
                    pos_fc:= pos_fc + '[' + inttostr(f) + '; ' + inttostr(c) + ']';
               end;

               c := c + 1;

          until c>col_max ;

          f := f + 1;
     until f>fil_max;

     showmessage('La posicion de ' + letra_buscar_edt[1] +
                  ' es '+pos_fc);
end;

procedure TForm1.btn_letrawhileClick(Sender: TObject);
var
   f,c:integer;
   letra_buscar,pos_fc:string;
begin
     letra_buscar:=inputbox('Buscar letra', 'Ingrese letra minuscula', '');

     f:=0;
     pos_fc :='';

     while f<=fil_max do
     begin
          c:=0;

          while c<=col_max do
          begin
               if letras[c,f]=letra_buscar[1] then
               begin
                    pos_fc:= pos_fc + '[' + inttostr(f) + '; ' + inttostr(c) + ']';
               end;

               c := c + 1;

          end;

          f := f + 1;
     end;
     showmessage('La posicion de ' + letra_buscar[1] +
                  ' es '+pos_fc);
end;

procedure TForm1.btn_mClick(Sender: TObject);
var
   f,c:integer;
begin
     for f:=0 to fil_max do
     begin
          for c:=0 to col_max do
          begin
               if letras[c,f]='m' then
                  lbl_m.caption:= lbl_m.caption+ '['+inttostr(f)+';'+inttostr(c)+']';
          end;
     end;
end;

procedure TForm1.btn_mostrarClick(Sender: TObject);
var
   f,c:integer;
begin
     for f:=0 to fil_max do
     begin
          for c:=0 to col_max do
          begin
              grid_letras.cells[c, f] := letras[c,f];
          end;
     end;
end;

end.

