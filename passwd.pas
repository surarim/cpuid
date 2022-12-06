// Ввод строки в скрытом режиме
program passwd;
{$mode objfpc}{$H+}
uses keyboard;
var key: TKeyEvent;
    res: string;
begin
InitKeyBoard;
res:='';
Repeat
  key:=GetKeyEvent;
  key:=TranslateKeyEvent(key);
  if GetKeyEventCode(key)<>7181 then res:= res + KeyEventToString(key);
Until (GetKeyEventCode(key)=7181);
DoneKeyboard;
write(res);
end.
