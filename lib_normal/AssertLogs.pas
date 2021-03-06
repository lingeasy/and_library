unit AssertLogs;

interface 
 
implementation 
uses 
  Windows, 
  SysUtils;
 
var 
  runErrMsg : String; 
  oldAssertErrorProc : TAssertErrorProc; 
 
procedure LogAssert(const Message, Filename: string; LineNumber: Integer; ErrorAddr: Pointer); 
begin 
  runErrMsg := format('Error: %s, Addr: %p, in file(%d): %s ', 
                      [Message, ErrorAddr, LineNumber, FileName]); 
  if IsConsole then
    Writeln(runErrMsg)
  else
    OutputDebugString(PChar(runErrMsg));
end;
 
initialization 
  oldAssertErrorProc := AssertErrorProc; 
  AssertErrorProc := @LogAssert;
 
finalization 
  AssertErrorProc := oldAssertErrorProc; 
end. 

