// Определение характеристик процессора через CPUID
program cpuid;
{$mode objfpc}{$H+}
{$asmmode intel}
const
    CPUID_STANDART_INFO = 1;
    CPUID_EXTENDED_INFO = $80000001;
    x86_64 = 29;
    PAE = 6;
    NX = 20;
    SSE2 = 26;
    SSE4_1 = 19;
    CMPXCHG16B = 13;
    LAHF_SAHF = 0;
    PREFETCHW = 8;
type
	TCPUIDResult = record
	EAX,EBX,ECX,EDX: Cardinal;
end;

// Выполение CPUID
function GetCPUID(mode: Cardinal): TCPUIDResult;
	var tmpEAX, tmpEBX, tmpECX, tmpEDX : Cardinal;
begin
asm
    mov eax, mode
    cpuid
    mov tmpEAX, eax
    mov tmpEBX, ebx
    mov tmpECX, ecx
    mov tmpEDX, edx
end;
result.eax := tmpEAX;
result.ebx := tmpEBX;
result.ecx := tmpECX;
result.edx := tmpEDX;
end;

// Получение значений отдельных битов после CPIUD
function GetBit(value: Cardinal; index: Byte): Boolean;
begin
  result := ((value shr index) and 1) = 1;
end;

begin  
write('CPU');
if GetBit(GetCPUID(CPUID_EXTENDED_INFO).EDX,x86_64) then write(' x86_64');
if GetBit(GetCPUID(CPUID_STANDART_INFO).EDX,PAE) then write(' PAE');
if GetBit(GetCPUID(CPUID_EXTENDED_INFO).EDX,NX) then write(' NX');
if GetBit(GetCPUID(CPUID_STANDART_INFO).EDX,SSE2) then write(' SSE2');
if GetBit(GetCPUID(CPUID_STANDART_INFO).ECX,SSE4_1) then write(' SSE4.1');
if GetBit(GetCPUID(CPUID_STANDART_INFO).ECX,CMPXCHG16B) then write(' CMPXCHG16B');
if GetBit(GetCPUID(CPUID_EXTENDED_INFO).ECX,LAHF_SAHF) then write(' LAHF/SAHF');
if GetBit(GetCPUID(CPUID_EXTENDED_INFO).ECX,PREFETCHW) then write(' PREFETCHW');
end.
