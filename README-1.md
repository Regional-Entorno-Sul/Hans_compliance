# Hans_compliance  
Hans_compliance é um utilitário que roda no prompt de comando e é usado para identificar registros de Hanseníase no SINAN NET que não estão em conformidade com as normas de notificação desse tipo de agravo.  
## Sintaxe do executável  

~~~
hans_complianece.exe [--modo]  
--name: Identifica inconsistência no mome dos pacientes;  
--menor15: Identifica os casos cujos pacientes são menores de 15 anos;  
--lesoes: Identifica registros com inconsistência no número de lesões;
--forma: Identifica os casos com inconsistência na forma clínica;
~~~

## Como usar?  
Primeiramente o usuário deve gerar no programa SINAN NET um arquivo de exportação no formato DBF dos dados de Hanseníase. Lembrando que ao gerar esse arquivo, deve-se marcar a opção "Exportar dados de identificação do paciente" no modulo de Exportação.  

![x](/pictures/hans_comp_sinan.jpg)  

Fazer o download do utilitário na seção "Releases" do GitHub.  
Usar sempre a última versão disponível.  

![x](/pictures/hans_comp_release1.jpg)  

![x](/pictures/hans_comp_release2.jpg)  

Descompactar o arquivo "baixado" usando seu descompactador preferido. Ao final do processo de descompactação haverá uma pasta com o nome "Hans_comp". Essa pasta é que deverá ser colada no disco local C.  
A figura abaixo mostra a pasta "Hans_comp" no disco local C e suas seis subpastas.  
  
![x](/pictures/hans_comp_pic1.jpg)  
  
Colar na subpasta "dbf" o arquivo que foi gerado no SINAN NET, o "HANSNET.DBF".  
Acessar o prompt de comando do Windows (CMD). Em seguida, acessar o diretório "Hans_comp" e depois a subpasta "exe".  
Digitar o nome do executável (Hans_compliance.exe), um espaço e logo em seguida o modo escolhido para gerar os dados, conforme mostrado na tela abaixo.  

![x](/pictures/hans_comp_pic2.jpg)  

Depois, pressionar a tecla ENTER e rodar a aplicação;  

![x](/pictures/hans_comp_pic3.jpg)  

Se o programa identificar alguma inconsistência, um arquivo com os registros com problema será gerado e estará a disposição do usuário na subpsta "out". 

## Outros detalhes técnicos  

Com relação às opcões disponíveis para a geração dos arquivos, usando o parâmetro opção, temos as seguintes possibilidades:  
**--name**: nas notificações de Hanseníase, o nome dos pacientes não podem ser abreviados. O algoritmo dessa opção identifica possíveis abreviações no nome dos pacientes, no entanto, o algoritmo não é 100% preciso, dessa forma, cabe ao usuário verificar no arquivo que foi gerado, se os nomes dos pacientes estão mesmo abreviados.  
**--menor15**: gera uma planilha com os pacientes menores de 15 anos, a investigação de Hanseníase em menores de 15 anos é obrigatória e exige o preenchimento do Protocolo Complementar de Investigação Diagnóstica de Casos de Hanseníase em Menores de 15 anos (PCID < 15).
**--lesoes**: identifica registros na base de dados com inconsistência entre o número de lesões e a classificação operacional. Dessa forma, são marcados como inconsistentes os registros que:  
O número de lesões for maior que cinco e a classificação operacional for PB;  
O numero de lesões for menor ou igual a cinco e a classificação operacional for MB;  
O campo de número de lesões estiver em branco e a classificação operacional for PB ou MB;  
**--forma**: identifica inconsistência entre a forma clínica e a classificação operacional, marcando como inconsistentes os registros que:  
A forma clínica for 1 ou 2 e a classificação operacional for diferente de PB;  
A forma clínica for 3, 4 ou 5 e a classificação operacional for diferente de MB;  
  