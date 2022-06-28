program Lab3_1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
   TMySet = set of Char;
var
   checkSet: TMySet;

function Confirm(): Char;
var
   ansCheck: Char;
   isCorrect: Boolean;
begin
   Writeln('Y(yes) / N(no)');
   repeat
      Readln(ansCheck);
      ansCheck := UpCase(ansCheck);
      if ((ansCheck = 'Y') or (ansCheck = 'N')) then
         isCorrect := True
      else
      begin
         Writeln('Error. Enter Y(yes) or N(no)');
         isCorrect := False;
      end;
   until isCorrect;
   Confirm := ansCheck;
end;

procedure OutputToFile(occurrence: Integer);
var
   outFileName: String;
   isCheck: Boolean;
   outFile: TextFile;
begin
   repeat
      Writeln('Enter a name for the output file in the format: name.txt');
      Readln(outFileName);
      isCheck := True;
      if FileExists(outFileName) then
      begin
         Writeln('Do you want to rewrite the file ', outFileName,' ?');
         if Confirm = 'Y' then
            isCheck := True
         else
            isCheck := False;
      end;
   until isCheck;
   AssignFile(outFile, outFileName);
   try
      Rewrite(outFile);
   except
      Writeln('Unable to open file for writing.');
   end;
   Writeln(outFile, 'Number of occurrence is ', occurrence);
   CloseFile(outFile);
end;

function ReadFromFile(): String;
var
   fileName: String;
   isCorrect: Boolean;
   sentence: String;
   inputFile: TextFile;
begin
   repeat
      Writeln('Enter the file name in the format: name.txt');
      Readln(fileName);
      isCorrect := True;
      if not FileExists(fileName) then
      begin
         Writeln('File does not exist. Try again.');
         isCorrect := False;
      end
      else
      begin
         AssignFile(inputFile, fileName);
         Reset(inputFile);
         if SeekEof(inputFile) then
         begin
            Writeln('Error. File is empty.');
            isCorrect := False;
         end
         else
            Readln(inputFile, sentence);
      end;
   until isCorrect;
   CloseFile(inputFile);
   ReadFromFile := sentence;
end;

function GetLastWord(sentence: String; checkSet: TMySet): String;
var
   lastWord: String;
   i: Integer;
begin
   lastWord := '';
   i := Length(sentence);
   while not CharInSet(sentence[i], checkSet) do
   begin
      Delete(sentence, i, 1);
      i := Length(sentence);
   end;
   while not(sentence[i] = ' ') and CharInSet(sentence[i], checkSet) do
   begin
      lastWord := sentence[i] + lastWord;
      Dec(i);
   end;
   GetLastWord := lastWord;
end;

function GetOccurrence(sentence, lastWord: String): Integer;
var
   occurrence: Integer;
begin
   occurrence := 0;
   while Pos(lastWord, sentence) > 0 do
   begin
      Inc(occurrence);
      Delete(sentence, Pos(lastWord, sentence), Length(lastWord));
   end;
   GetOccurrence := occurrence;
end;

function CheckData(sentence: String; checkSet: TMySet): Boolean;
var
   i, count: Integer;
begin
   count := 0;
   for i := 1 to Length(sentence) do
      if CharInSet(sentence[i], checkSet) then
         Inc(count);
   CheckData := count = 0;
end;

procedure Main();
var
   sentence, lastWord: String;
   occurrence: Integer;
   isCorrect: Boolean;
begin
   checkSet := ['A'..'Z', 'a'..'z'];
   Writeln('This program checks how many times the last word occurs in a given sentence.');
   Writeln('Open the data file?');
   if Confirm() = 'Y' then
   begin
      repeat
         sentence := ReadFromFile();
         Writeln('Sentence: ', sentence);
         isCorrect := True;
         if CheckData(sentence, checkSet) then
         begin
            Writeln('Input does not contain necessary data.');
            isCorrect := False;
         end;
      until isCorrect;
   end
   else
   begin
      repeat
         Writeln('Enter the sentence.');
         Readln(sentence);
         isCorrect := True;
         if CheckData(sentence, checkSet) then
         begin
            Writeln('Input does not contain necessary data.');
            isCorrect := False;
         end;
      until isCorrect;
   end;
   lastWord := GetLastWord(sentence, checkSet);
   Writeln('Last word: ', lastWord);
   occurrence := GetOccurrence(sentence, lastWord);
   Writeln('Number of occurrence is ', occurrence);
   OutputToFile(occurrence);
   Readln;
end;

begin
   Main();
end.
