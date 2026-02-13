Function main()

clear
set date to british
set century on
set color to w+/b+

@ 1,0 say "---------------------------------------------------------------------"
@ 2,0 say "|hans_compliance.exe versao 1.0 - 12/02/2026                        |"
@ 3,0 say "|https://github.com/Regional-Entorno-Sul/Hans_compliance            |"
@ 4,0 say "|Regional de saude Entorno Sul                                      |"
@ 5,0 say "|Procura por inconsistencias nas notificacoes de Hanseniase         |"
@ 6,0 say "|para fins de conformidade.                                         |"
@ 7,0 say "|Sintaxe do executavel: hans_compliance.exe [--modo]                |"
@ 8,0 say "|Argumentos aceitos: [--name] [--menor15]                           |"
@ 9,0 say "---------------------------------------------------------------------"

cArg := HB_ArgV ( 1 )
if empty( cArg ) = .T.
set color to r+/
? "Erro! Executavel necessita de argumentos no prompt de comando."
? "Fim do programa."
wait
quit
endif

set exact on
if cArg <> "--name" .and. cArg <> "--menor15"
set color to r+/
? "Erro! " + alltrim( cArg ) + " nao e considerado um argumento valido." 
? "Fim do programa."
wait
quit
endif
set exact off

@ 10,0 say "Excluindo arquivos remanescentes de processamentos anteriores..."
delete file "c:\hans_comp\run\hansnet.dbf"
if file("c:\hans_comp\run\hansnet.dbf") = .F.
set color to w+/
@ 10,64 say "OK"
endif

delete file "c:\hans_comp\out\hans_name.dbf"

set color to w+/b+
@ 11,0 say "Verificando presenca do arquivo de dados..."
if file("c:\hans_comp\dbf\hansnet.dbf") = .F.
set color to r+/
? "Erro! Arquivo dbf com os dados de hanseniase (hansnet.dbf) nao existe."
? "Fim do programa."
wait
quit
else
set color to w+/
@ 11,43 say "OK"
endif

set color to w+/b+
@ 12,0 say "Transferindo arquivo para o diretorio de trabalho..."
cArq1 := "c:\hans_comp\dbf\hansnet.dbf"
cArq2 := "c:\hans_comp\run\hansnet.dbf"
copy file ( cArq1 ) to ( cArq2 )
if file("c:\hans_comp\run\hansnet.dbf") = .F.
set color to r+/
? "Erro! Falha na transferecia do arquivo de dados."
? "Fim do programa."
wait
quit
else
set color to w+/
@ 12,52 say "OK"
endif

set color to w+/b+
@ 13,0 say "Delimitando os registros inconsistentes..."

if cArg = "--name"
name()
endif

if cArg = "--menor15"
menor15()
endif

function name()
set color to w+/b+
@ 14,0 say "Procurando por nomes abreviados..."

use "c:\hans_comp\run\hansnet.dbf"
do while .not. eof()

tokeninit(alltrim(nm_pacient), " ", 1)
do while .not. tokenend()
cToken := tokennext(alltrim(nm_pacient))

if len( cToken ) = 2 .and. cToken <> "DE" .and. cToken <> "DA" .and. cToken <> "DO" .and. cToken <> "RN" .and. cToken <> "SA" .and. cToken <> "JO"
replace tp_not with "x"
endif

if len( cToken ) = 2 .and. hb_at( ".", cToken ) <> 0
replace tp_not with "x"
endif

if len( cToken ) = 1 .and. cToken <> "E"
replace tp_not with "x"
endif

enddo
tokenend()

skip
enddo
close

use "c:\hans_comp\run\hansnet.dbf"
count to nName for tp_not = "x"
@ 15,0 say "Numero de registros com inconsistencia no nome do paciente:"
set color to w+/
@ 15,59 say alltrim( str( nName ) )
close

copy file "c:\hans_comp\model\hans_name.dbf" to "c:\hans_comp\out\hans_name.dbf"
use "c:\hans_comp\out\hans_name.dbf"
append from "c:\hans_comp\run\hansnet.dbf" for tp_not = "x"
close

set color to g+/
use "c:\hans_comp\out\hans_name.dbf"
if reccount() >= 1
? "Arquivo de saida disponivel na subpasta 'out'. Arquivo hans_name.dbf."
else
? "Nao foi encontrado registros para o criterio --name."
endif

return

function menor15()
set color to w+/b+
@ 14,0 say "Procurando por pacientes menores de 15 anos."
use "c:\hans_comp\run\hansnet.dbf"

do while .not. eof()
replace tp_not with "x" for nu_idade_n < 4015
enddo

return

return