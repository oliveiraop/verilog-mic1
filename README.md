Atividades
1. Utilizando verilog, implementar o modelo de mem´oria
da IJVM na FPGA disponibilizada.
2. Fazer valida¸c~ao funcional das ´areas de mem´oria individuais no Modelsim.
3. Implementar as principais instru¸c~oes da IJVM e realizar
simula¸c~ao funcional no Modelsim.
4. Partindo de c´odigos de teste em alto-n´ıvel, compilados
manualmente para a IJVM, validar a integra¸c~ao entre
os n´ıveis de macroarquitetura e microarquitetura projetado no Problema #1.
5. Propor e implementar uma IHM para avalia¸c~ao real dos
m´odulos projetados na placa DE2-115 remota.


Os módulos verilog para implementação da iJvM foram divididos: em Datapath, control path, Memória de Microinstrução como principais módulos, mas foram utilizados também, a ram e rom do próprio quartus e o módulo LCD para validar o caminho dos dados passando pelos registradores, que pode ser visto no código verilog anexado junto ao relatório. 
O módulo Data path: foram subdivididos em ULA, Shifter e os registradores do módulo conforme código em anexo:
verilog-mic1/MIC1.v at main · oliveiraop/verilog-mic1 (github.com)
verilog-mic1/ULA.v at main · oliveiraop/verilog-mic1 (github.com)
verilog-mic1/shifter.v at main · oliveiraop/verilog-mic1 (github.com)
O módulo Control Path: foram subdivididos em MIR, MPC, Decodificador que não houve necessidade de criar módulos, e foi implementado via  linhas de códigos no próprio control path.
verilog-mic1/controlpath.v at main · oliveiraop/verilog-mic1 (github.com)
	No módulo Rom foi inserido nas microinstruções responsáveis por armazenar os endereços consecutivos da memória de controle.
verilog-mic1/rom.v at main · oliveiraop/verilog-mic1 (github.com)
