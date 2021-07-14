program piskvorky;
uses crt;                                  {pouziti crt kvuli mazani obrazu}
const max=16;                              {rozmer ctv. papiru}
type pole=array[1..max,1..max] of byte;    {pole ctv. papiru}
     pole2=array[1..max] of byte;          {pole cislic znacicich souradnice}
var a:pole;                                {deklarace nutnych promennych; promenna typu pole}
    b:pole2;                                 {promenna typu pole2}
    i,j:integer;                             {promenne potrebne k udani souradnic}
    t:byte;                                {k=ukoncovaci promenna,t=promenna k souctu tahu pocitace}
procedure erase(var a:pole);               {procedura vyplne papiru nulami}
var c,d:integer;
begin
for c:=1 to max do begin
 for d:=1 to max do
 a[c,d]:=0;
 end;
 end;

procedure fill (var a:pole2);             {procedura zapisu souradnic}
var c,e:integer;
begin
e:=1;
for c:=1 to max do begin
a[c]:=e;
e:=e+1;
end;
write('  ');
for c:=1 to max do begin
if a[c] mod 2=0 then textcolor(9) else textcolor(10);
if a[c] <10 then write('0',a[c]) else
write(a[c]:2);end;
end;

procedure prn(var a:pole;b:pole2);{rozsahla procedura:tiskne obsah obrazovky}
var c,d:integer;                  {ctvereckovany papir, souradnice, vyzva}
begin
 fill(b);textcolor(7);writeln('  souradnice A');
 for c:=1 to max do begin
 if b[c] mod 2=0 then textcolor(9) else textcolor(10);
 if b[c]<10 then write('0',b[c]) else
 write(b[c]);
 for d:=1 to max do begin
 textcolor(7);
 if a[c,d]=0 then write(' #');
 if a[c,d]=1 then begin textcolor(4); write(' O'); textcolor(7); end;
 if a[c,d]=2 then begin textcolor(14); write(' X'); textcolor(7); end;
   end;
  writeln;
 end;
 writeln('souradnice B');
 writeln; textcolor(15);
 write('zadejte vas tah udanim pozice na souradnici A mezera B:');textcolor(7);
 end;

function getpoint (a,b:integer;var c:pole):boolean; {funkce vyplnujici ctverecek zadany uzivatelem}
begin                                               {s ochranou proti zapisu na jiz vyplnene misto}
if c[a,b]=0 then begin c[a,b]:=1; getpoint:=true;end{z tahu tazenych uzivatelem}
else getpoint:=false;
end;

procedure computer(var t:byte;var a:pole); {procedura s obrannou vlastnosti taktiky pocitace}
var c,d,k:integer;
begin
k:=t;
for c:=1 to max do begin
 for d:=1 to max do begin
       {OBRANNA CAST}
   if (a[c,d]=1) and (a[c,d+1]=1) and (a[c,d+2]=1) and (a[c,d+3]=0) and (t=k) then begin a[c,d+3]:=2; t:=t+1; end
      else begin if (a[c,d]=1) and (a[c,d+1]=1) and (a[c,d+2]=1) and (a[c,d+3]<>0) and (a[c,d-1]=0) and (t=k) then
           begin a[c,d-1]:=2; t:=t+1; end; end;
        {obrana zleva doprava, nasledne zprava doleva}

   if (a[c,d]=1) and (a[c+1,d+1]=1) and (a[c+2,d+2]=1) and (a[c+3,d+3]=0) and (t=k) then begin a[c+3,d+3]:=2; t:=t+1;end
      else begin if (a[c,d]=1) and (a[c+1,d+1]=1) and (a[c+2,d+2]=1) and (a[c+3,d+3]<>0) and (a[c-1,d-1]=0) and (t=k) then
           begin a[c-1,d-1]:=2; t:=t+1; end;
        end; {obrana diagonalne dolu doprava, nasledne nahoru doleva}

    if (a[c,d]=1) and (a[c+1,d-1]=1) and (a[c+2,d-2]=1) and (a[c+3,d-3]=0) and (t=k) then begin a[c+3,d-3]:=2; t:=t+1;end
      else begin if (a[c,d]=1) and (a[c+1,d-1]=1) and (a[c+2,d-2]=1) and (a[c+3,d-3]<>0) and (a[c-1,d+1]=0) and (t=k) then
           begin a[c-1,d+1]:=2; t:=t+1; end;
        end; {obrana diagonalne dolu doleva, nasledne nahoru doprava}

    if (a[c,d]=1) and (a[c+1,d]=1) and (a[c+2,d]=1) and (a[c+3,d]=0) and (t=k) then begin a[c+3,d]:=2; t:=t+1; end
      else begin if (a[c,d]=1) and (a[c+1,d]=1) and (a[c+2,d]=1) and (a[c+3,d]<>0) and (a[c-1,d]=0) and (t=k) then
           begin a[c-1,d]:=2; t:=t+1; end;
        end; {obrana zhora dolu, nasledne zdola nahoru}
        end;end;
        {UTOCNA CAST}
for c:=1 to max do begin
  for d:=1 to max do begin
     if k=t then begin if (a[c,d]=2) and (a[c,d+1]=2) and (a[c,d+2]=2) and (a[c,d+3]=0) and (t=k) then begin a[c,d+3]:=2;
                          t:=t+1; end
                  else begin if (a[c,d]=2) and (a[c,d+1]=2) and (a[c,d+2]=2) and (a[c,d+3]<>0) and (a[c,d-1]=0) and (t=k) then
                   begin a[c,d-1]:=2; t:=t+1; end; end;

                  if (a[c,d]=2) and (a[c+1,d+1]=2) and (a[c+2,d+2]=2) and (a[c+3,d+3]=2) and (t=k) then
                          begin a[c+3,d+3]:=2; t:=t+1;end
                    else begin if (a[c,d]=2) and (a[c+1,d+1]=2) and (a[c+2,d+2]=2) and (a[c+3,d+3]<>0) and (a[c-1,d-1]=0) and
                               (t=k) then
                         begin a[c-1,d-1]:=2; t:=t+1; end; end;

                  if (a[c,d]=2) and (a[c+1,d-1]=2) and (a[c+2,d-2]=2) and (a[c+3,d-3]=2) and (t=k) then
                          begin a[c+3,d-3]:=2; t:=t+1;end
                    else begin if (a[c,d]=2) and (a[c+1,d-1]=2) and (a[c+2,d-2]=2) and (a[c+3,d-3]<>0) and (a[c-1,d-1]=0) and
                               (t=k) then
                         begin a[c-1,d+1]:=2; t:=t+1; end; end;

                  if (a[c,d]=2) and (a[c+1,d]=2) and (a[c+2,d]=2) and (a[c+3,d]=0) and (t=k) then begin a[c+3,d]:=2;
                          t:=t+1; end
                    else begin if (a[c,d]=2) and (a[c+1,d]=2) and (a[c+2,d]=2) and (a[c+3,d]<>0) and (a[c-1,d]=0) and
                         (t=k) then
                         begin a[c-1,d]:=2; t:=t+1; end;end;end;

                 if (a[c,d]=1) and (a[c+1,d]=0) and (t=k) then begin a[c+1,d]:=2; t:=t+1; end; end;



end;
end;

function end1 (var a:pole):byte; {funkce zajistujici ukonceni programu po vitezstvi 1 ze stran}
 var c,d,k:byte;
begin
c:=1;
k:=0;
repeat
d:=1;
repeat
if                              {vyhra hrace, ukonceni hry}
((a[c,d]=1) and (a[c,d+1]=1) and (a[c,d+2]=1) and (a[c,d+3]=1) and (a[c,d+4]=1))or
((a[c,d]=1) and (a[c+1,d+1]=1) and (a[c+2,d+2]=1) and (a[c+3,d+3]=1) and (a[c+4,d+4]=1))or
((a[c,d]=1) and (a[c+1,d]=1) and (a[c+2,d]=1) and (a[c+3,d]=1) and (a[c+4,d]=1))or
((a[c,d]=1) and (a[c+1,d-1]=1) and (a[c+2,d-2]=1) and (a[c+3,d-3]=1) and (a[c+4,d-4]=1))
then k:=1;
d:=d+1;
until (k=1) or (d=max);
c:=c+1;
until (k=1) or (c=max);

if k=0 then

begin
c:=1;
k:=0;
repeat
d:=1;
repeat
if                                            {vyhra pocitace, ukonceni hry}
((a[c,d]=2) and (a[c,d+1]=2) and (a[c,d+2]=2) and (a[c,d+3]=2) and (a[c,d+4]=2))or
((a[c,d]=2) and (a[c+1,d+1]=2) and (a[c+2,d+2]=2) and (a[c+3,d+3]=2) and (a[c+4,d+4]=2))or
((a[c,d]=2) and (a[c+1,d]=2) and (a[c+2,d]=2) and (a[c+3,d]=2) and (a[c+4,d]=2))or
((a[c,d]=2) and (a[c+1,d-1]=2) and (a[c+2,d-2]=2) and (a[c+3,d-3]=2) and (a[c+4,d-4]=2))
then k:=2;
d:=d+1;
until (k=2) or (d=max);
c:=c+1;
until (k=2) or (c=max);
end;
end1:=k;
end;

begin                                    {zacatek vlastniho programu}
clrscr;
t:=0;
textcolor(15);
writeln('piskvorky verze 0.01');
textcolor(7);
writeln;
writeln;
erase(a);
prn(a,b);
repeat                      {opakujici se cast pri spravnem udani pozice}
readln(j,i);
if getpoint(i,j,a)=true then begin
computer(t,a);
clrscr;
textcolor(15);
writeln('piskvorky verze 0.01');
textcolor(7);
writeln;
writeln;
prn(a,b);
end
else begin                                   {a pri spatnem}
clrscr;
writeln;writeln; textcolor(12); writeln('nelze hrat na jiz obsazene pole');
textcolor(7);writeln;
writeln('pokracujte stisknutim ENTERu');
readln;clrscr;
textcolor(15);
writeln('piskvorky verze 0.01');
textcolor(7);
writeln;
writeln;
prn(a,b);end;
until end1(a)>0;               {ukonceni}
writeln;
writeln;
if end1(a)=1 then begin writeln; textcolor(15);write('blahopreji, jste vitez!!!');textcolor(7);
writeln(' pocitac tahnul ',t,'krat'); end;
if end1(a)=2 then begin writeln; write('bohuzel jste prohral, zkuste to znovu!');writeln(' pocitac tahnul ',t,'krat');end;
writeln;
writeln('dekujeme za hrani piskvorek, nashledanou');
writeln;writeln('vyrobeno v turbo pascalu verze 7.0');

readln;
end.