#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('MotherlyRCT2026_DATA_2026-10-27_1151.csv')
#Setting Labels

label(data$record_id) = "Record ID"
label(data$redcap_event_name) = "Event Name"
label(data$redcap_survey_identifier) = "Survey Identifier"
label(data$recrutamento_t0_timestamp) = "Survey Timestamp"
label(data$t0_start_recrutamento) = "Start Time"
label(data$t0_data) = "Data de preenchimento"
label(data$t0_ref) = "Como você ficou sabendo do estudo?"
label(data$t0_android) = "Qual é o modelo do seu celular?"
label(data$t0_modelo_cel) = "Qual o modelo do seu celular?"
label(data$t0_data_nasc_mae) = "Qual a sua data de nascimento?"
label(data$t0_idade) = "Idade (em anos)"
label(data$t0_data_nasc_bebe) = "Qual a data de nascimento do seu bebê? Filho(a) mais novo(a). "
label(data$t0_idade_bebe) = "Idade bebê (em meses)"
label(data$t0_estado) = "Qual Estado você mora atualmente? "
label(data$t0_cidade) = "Qual cidade você mora atualmente?"
label(data$t0_disponivel1) = "Você tem disponibilidade para ser avaliada por meio de uma entrevista à distância de aproximadamente 2 horas em dois momentos durante 2 meses?"
label(data$t0_diag1) = "Você já recebeu algum diagnóstico psiquiátrico ou psicológico na vida (por exemplo, depressão, ansiedade ou algum outro problema de saúde mental)?"
label(data$t0_diag1a) = "Qual foi esse diagnóstico?  "
label(data$t0_diag1b) = "Qual foi esse diagnóstico? "
label(data$t0_diag2) = "Durante a sua gestação mais recente e o momento atual, você recebeu algum desses diagnósticos psiquiátricos ou psicológicos:  Transtorno Bipolar Esquizofrenia ou Psicose Transtorno Alimentar (como anorexia ou bulimia) Abuso ou dependência de álcool Abuso ou dependência de substância ou droga Autismo ou transtorno do espectro do autismo Transtorno obsessivo-compulsivo ou TOC "
label(data$t0_tto1) = "Atualmente, você está em tratamento para algum diagnóstico psiquiátrico ou psicológico (por exemplo, depressão, ansiedade ou algum outro problema de saúde mental)?"
label(data$t0_tto1a) = "Que tratamento você está fazendo?"
label(data$t0_tto1b) = "Descreva o tratamento."
label(data$t0_tto1c) = " Esse tratamento que você está fazendo é para depressão?"
label(data$t0_saude) = "Como você avalia a sua saúde atualmente?"
label(data$t0_qidssr16_1) = "Pegar no Sono:"
label(data$t0_qidssr16_2) = "Sono durante a noite:"
label(data$t0_qidssr16_3) = "Acordar cedo demais:"
label(data$t0_qidssr16_4) = "Dormir demais:"
label(data$t0_qidssr16_5) = "Sentir-se triste:"
label(data$t0_qidssr16_txt2) = "- Com relação ao seu apetite:"
label(data$t0_qidssr16_6) = "Apetite Diminuído "
label(data$t0_qidssr16_7) = "Apetite Aumentado"
label(data$t0_qidssr16_txt3) = "- Com relação ao seu peso (nas últimas 2 semanas):"
label(data$t0_qidssr16_8) = "Perda de peso (nas duas últimas semanas) "
label(data$t0_qidssr16_9) = "Aumento de peso (nas duas últimas semanas) "
label(data$t0_qidssr16_10) = "Concentração / Tomar decisões:"
label(data$t0_qidssr16_11) = "Visão de Mim Mesmo:"
label(data$t0_qidssr16_12) = "Ideias de Morte e Suicídio:"
label(data$t0_qidssr16_13) = "Interesse geral:"
label(data$t0_qidssr16_14) = "Nível de energia:"
label(data$t0_qidssr16_15) = "Sentir lentidão:"
label(data$t0_qidssr16_16) = "Sentir-se agitado: "
label(data$t0_qidssr16_total) = "Somatória dos itens"
label(data$t0_criterio_i_1) = "Critério de inclusão 1: Idade 18-40 anos de idade"
label(data$t0_criterio_i_2) = "Critério de inclusão 2: Até 12 meses após o parto. "
label(data$t0_criterio_i_3) = "Critério de inclusão 3: Pontuação igual ou maior que 13 na QIDS-SR16 "
label(data$t0_criterio_i_6) = "Critério de inclusão 6: Possuir um smartphone funcional com Android para uso pessoal."
label(data$t0_criterio_i_7) = "Critério de inclusão 7: Não estar em tratamento farmacológico e/ou psicoterápico nas últimas quatro semanas"
label(data$t0_criterio_e_2) = " Critério de exclusão 2: Diagnóstico de transtorno mental grave e/ou crônico (ex. esquizofrenia, transtorno bipolar)."
label(data$t0_criterio_e_3) = "Critério de exclusão 3: Ideação suicida ou tentativa de suicídio prévia."
label(data$t0_criterio_i_tot1) = "Critérios de inclusão avaliados no formulário de recrutamento. "
label(data$t0_criterio_e_tot1) = "Critérios de exclusão avaliados no formulário de recrutamento."
label(data$t0_criterios_tot1) = "Diferença entre critérios de inclusão e exclusão. "
label(data$t0_elegibilidade1) = "Diferença entre critérios de inclusão e exclusão. "
label(data$recrutamento_t0_complete) = "Complete?"
label(data$recrutamento_1_t0_timestamp) = "Survey Timestamp"
label(data$t0_start_recrutamento1) = "Start Time"
label(data$t0_recrutamento_dur_sec) = "Time for t0_recrutamento (in seconds)"
label(data$t0_nome) = "Qual seu nome completo?"
label(data$t0_email) = "Qual o seu email?"
label(data$t0_celular) = "Qual o número do seu celular? Indicar DDD."
label(data$t0_celular_2) = "Tem algum número de celular de algum conhecido caso não seja possível entrar em contato com você?"
label(data$t0_celular_2a_nome) = "Qual é o nome dessa pessoa?"
label(data$t0_celular_2a_relacao) = "Qual é a sua relação com essa pessoa?"
label(data$t0_celular_2a) = "Qual o número de celular dessa pessoa?"
label(data$t0_celular_3) = "Tem mais algum número de celular de algum conhecido caso não seja possível entrar em contato com você?"
label(data$t0_celular_3a_nome) = "Qual é o nome dessa pessoa?"
label(data$t0_celular_3a_relacao) = "Qual é a sua relação com essa pessoa?"
label(data$t0_celular_3a) = "Qual o número de celular dessa pessoa?"
label(data$t0_disponib___1) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Segunda-feira - manhã (8h às 12h))"
label(data$t0_disponib___2) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Segunda-feira - tarde (13h às 18h))"
label(data$t0_disponib___3) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Segunda-feira - noite (19h às 21h))"
label(data$t0_disponib___4) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Terça-feira - manhã (8h às 12h))"
label(data$t0_disponib___5) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Terça-feira - tarde (13h às 18h))"
label(data$t0_disponib___6) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Terça-feira - noite (19h às 21h))"
label(data$t0_disponib___7) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quarta-feira - manhã (8h às 12h))"
label(data$t0_disponib___8) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quarta-feira - tarde (13h às 18h))"
label(data$t0_disponib___9) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quarta-feira - noite (19h às 21h))"
label(data$t0_disponib___10) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quinta-feira - manhã (8h às 12h))"
label(data$t0_disponib___11) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quinta-feira - tarde (13h às 18h))"
label(data$t0_disponib___12) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Quinta-feira - noite (19h às 21h))"
label(data$t0_disponib___13) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sexta-feira - manhã (8h às 12h))"
label(data$t0_disponib___14) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sexta-feira - tarde (13h às 18h))"
label(data$t0_disponib___15) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sexta-feira - noite (19h às 21h))"
label(data$t0_disponib___16) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sábado - manhã (8h às 12h))"
label(data$t0_disponib___17) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sábado - tarde (13h às 18h))"
label(data$t0_disponib___18) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Sábado - noite (19h às 21h))"
label(data$t0_disponib___19) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Domingo - manhã (8h às 12h))"
label(data$t0_disponib___20) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Domingo - tarde (13h às 18h))"
label(data$t0_disponib___21) = "Indique os dias da semana e horários ideais para agendar com você a primeira avaliação:  Marque o máximo de opções possíveis, por favor. (choice=Domingo- noite (19h às 21h))"
label(data$recrutamento_1_t0_complete) = "Complete?"
label(data$mini_timestamp) = "Survey Timestamp"
label(data$t0_recrutamento1_dur_sec) = "Time for t0_recrutamento1 (in seconds)"
label(data$t0_start_mini) = "Start time"
label(data$t0_mini_a1) = " A1. Nas duas últimas semanas, sentiu-se triste, desanimado(a), deprimido(a), durante a maior parte do dia, quase todos os dias? "
label(data$t0_mini_a2) = "A2. Nas duas últimas semanas, quase todo tempo, teve o sentimento de não ter mais gosto por nada, de ter perdido o interesse e o prazer pelas coisas que lhe agradam habitualmente?"
label(data$t0_mini_a12_total) = "Módulo A1 e A2"
label(data$t0_mini_a) = "A1 OU A2 são cotadas Sim?"
label(data$t0_mini_a3a) = "a. O seu apetite mudou de forma significativa, ou o seu peso aumentou ou diminuiu sem que o tenha desejado? (variação de ± 5% ao longo do mês, isto é, ± 3,5 Kg, para uma pessoa de 65 Kg). "
label(data$t0_mini_a3b) = "b. Teve problemas de sono quase todas as noites (dificuldade de pegar no sono, acordar no meio da noite ou muito cedo, dormir demais)?"
label(data$t0_mini_a3c) = "c. Falou ou movimentou-se mais lentamente do que de costume ou, pelo contrário, sentiu-se agitado(a) e incapaz de ficar sentado quieto(a), quase todos os dias?"
label(data$t0_mini_a3d) = "d. Sentiu-se a maior parte do tempo cansado(a), sem energia, quase todos os dias?"
label(data$t0_mini_a3e) = "e. Sentiu-se sem valor ou culpado(a), quase todos os dias?"
label(data$t0_mini_a3f) = "f. Teve dificuldade de concentrar-se ou de tomar decisões, quase todos os dias?"
label(data$t0_mini_a3g) = "g. Teve, por várias vezes, pensamentos ruins como, por exemplo, pensar que seria melhor estar morto(a) ou pensar em fazer mal a si mesmo(a)?"
label(data$t0_mini_a3_total) = "A3 total"
label(data$t0_mini_a4_1) = "Há pelo menos 3 respostas SIM em A3? (Ou 4 respostas se A1 ou A2 foram NÃO)"
label(data$t0_mini_a4) = "Episódio depressivo maior atual? (1 = SIM; 0 = NÃO)"
label(data$t0_mini_a5a) = " A5a. Ao longo da sua vida, teve outros períodos de 2 semanas ou mais, em que se sentiu deprimido(a) ou sem interesse pela maioria das coisas e durante os quais teve os problemas dos quais falamos (sintomas de A3a a A3g)?"
label(data$t0_mini_a5b) = "A5b. Entre esses períodos de depressão que apresentou ao longo de sua vida, alguma vez teve um intervalo de pelo menos 2 meses em que não apresentou nenhum problema de depressão ou de perda de interesse?"
label(data$t0_mini_a5) = "Episódio depressivo maior recorrente? (1 = SIM; 0 = NÃO)"
label(data$t0_mini_a5_b) = "A5b é cotada Sim?"
label(data$t0_mini_c1) = "C1. Pensou que seria melhor estar morto(a) ou desejou estar morto(a)? "
label(data$t0_mini_c2) = "C2. Quis fazer mal a si mesmo(a)?"
label(data$t0_mini_c3) = "C3. Pensou em suicídio?"
label(data$t0_mini_c4) = " C4. Pensou numa maneira de se suicidar?"
label(data$t0_mini_c5) = "C5. Tentou o suicídio?"
label(data$t0_mini_c6) = "C6. Ao longo da sua vida, já fez alguma tentativa de suicídio?"
label(data$t0_mini_c_soma) = "Soma C"
label(data$t0_mini_c_class) = "Classificação de risco de suicídio (1-5=baixo, 6-9=moderado, >10=alto)."
label(data$t0_criterio_e_3b) = "Critério de exclusão 3: Ideação suicida ou tentativa de suicídio prévia (verificando pela segunda vez)."
label(data$t0_criterio_i_4) = "Critério de inclusão 4: Preenche critérios para transtorno depressivo maior segundo DSM-5-TR."
label(data$t0_criterio_i_5) = "Critério de inclusão 5: Atesto que a participante é alfabetizada."
label(data$t0_criterio_e_1) = "Critério de exclusão 1: Participante aparenta possuir deficiência intelectual, visual ou auditiva, ou doenças crônicas, que impossibilite uso de celular ou compreensão das intervenções."
label(data$t0_criterio_e_4) = "Critério de exclusão 4: Mulheres que tiveram perda gestacional (abortamento espontâneo) na gestação mais recente ou morte neonatal precoce"
label(data$t0_criterio_e_5) = "Critério de exclusão 5: Depressão refratária (não respondeu previamente a pelo menos 2 tratamentos baseados em evidências)"
label(data$t0_criterio_i_tot2) = "Critérios de inclusão avaliados na entrevista."
label(data$t0_criterio_e_tot2) = "Critérios de exclusão avaliados na entrevista."
label(data$t0_criterios_tot2) = "Diferença entre critérios de inclusão e exclusão."
label(data$t0_elegibilidade2) = "Situação de elegibilidade dos critérios verificados na entrevista."
label(data$mini_complete) = "Complete?"
label(data$rand_number) = "Randomizacao"
label(data$randomizacao_complete) = "Complete?"
label(data$tcle_timestamp) = "Survey Timestamp"
label(data$t0_start_tcle) = "Start time"
label(data$tcle_data) = "Data de preenchimento"
label(data$tcle_concordo) = "Declaro que li e aceito os termos de Consentimento "
label(data$tcle_nome) = "Qual seu nome completo?"
label(data$tcle_complete) = "Complete?"
label(data$formulrio_pravaliao_timestamp) = "Survey Timestamp"
label(data$t1_preavl_data) = "Data da avaliação"
label(data$t1_preavl_nome) = "Avaliador"
label(data$t1_preavl_print) = "Insira aqui o arquivo com o print da avaliação"
label(data$formulrio_pravaliao_complete) = "Complete?"
label(data$linha_base_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_demo) = "Start time"
label(data$t1_tcle) = "Compreendo e aceito o Termo de Consentimento Livre e Esclarecido:"
label(data$t1_data) = "Data da entrevista"
label(data$t1_horario_inicio) = "Horário do inicio da entrevista"
label(data$t1_avaliadora) = "Nome da avaliadora"
label(data$t1_altura) = "Qual a sua altura?"
label(data$t1_peso_mae) = "Qual o seu peso atual (em quilogramas)?"
label(data$t1_cor) = "A sua cor/raça é?"
label(data$t1_escola) = "Qual o seu nível de escolaridade?"
label(data$t1_renda) = "Qual a renda mensal média da sua família?  (Somando a renda de todas as pessoas que moram na sua casa ou apartamento). "
label(data$t1_familia1) = "Quantas pessoas, incluindo você, residem em sua casa? (Considerar apenas as pessoas que dormiram no local na maior parte dos dias nas últimas duas semanas)"
label(data$t1_comodos1) = "Quantos quartos tem a casa ou apartamento onde você mora neste momento?"
label(data$t1_comodos2) = "Quantos banheiros tem a casa ou apartamento onde você mora neste momento?"
label(data$t1_trabalho) = "Qual sua situação de trabalho atual?"
label(data$t1_estudando) = "Você está estudando no momento?"
label(data$t1_ecivil) = "Qual seu estado civil?"
label(data$t1_pai_r) = "Qual sua relação com o pai de seu filho(a)?"
label(data$t1_pai_relac) = "Quando você descobriu estar grávida, quanto tempo de relacionamento você tinha com o pai de seu(ua) filho(a) (em meses)?"
label(data$t1_pai_temp) = "O pai da criança se envolveu na gestação?"
label(data$linha_base_t1_complete) = "Complete?"
label(data$prnatal_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_prenatal) = "Start"
label(data$t1_prenatal1) = "Agora gostaria de saber como foi o seu pré-natal. Quantas consultas de pré-natal você fez no total? (Consulta com o médico ginecologista/obstetra)."
label(data$t1_prenatal2) = "As consultas aconteceram no sistema público ou privado?"
label(data$t1_prenatal3) = "Você tem plano de saúde neste momento?"
label(data$t1_prenatal5) = "Você fez ultrassonografia?"
label(data$t1_prenatal6) = "Você fez exame de sangue no pré-natal?"
label(data$t1_prenatal7) = "Você fez exame físico (peso e altura) no pré-natal?"
label(data$t1_prenatal8) = "Você teve diabetes gestacional?"
label(data$t1_prenatal9) = "Você teve pré-eclâmpsia?"
label(data$t1_prenatal10) = "Seu médico(a) mencionou ou diagnosticou que sua gestação foi de alto risco?"
label(data$t1_prenatal10a) = "Por qual(ais) razão(ões)?"
label(data$t1_prenatal11) = "Você tem alguma doença crônica que necessita de visitas regulares ao médico ou de tratamento continuado (como asma/bronquite, diabetes, problemas renais, convulsões, entre outros)?"
label(data$t1_prenatal11a) = "Qual(ais) doença(s) crônica(s)?"
label(data$prnatal_t1_complete) = "Complete?"
label(data$dados_de_nascimento_e_antropometricos_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_dna) = "start"
label(data$t1_crianca) = "Nome do bebê"
label(data$t1_sexo) = "Sexo do bebê"
label(data$t1_data_nasc) = "Data do nascimento"
label(data$t1_idade_bebe) = "Idade do bebê"
label(data$t1_idd_gestac) = "Idade gestacional no dia do nascimento. (Em semanas)"
label(data$t1_peso) = "Peso ao nascer. (Em gramas. Ex 2500, 3000, etc. Não usar vírgula ou ponto)."
label(data$t1_comprim) = "Comprimento ao nascer. (Em centímetros)."
label(data$t1_local) = "Local onde foi realizado o parto"
label(data$t1_local1) = "Outro"
label(data$t1_parto) = "Tipo de parto"
label(data$t1_cesarea) = "Motivo da realização de cesárea"
label(data$t1_cesarea1) = "Outro"
label(data$t1_forceps) = "Foi utilizado fórceps?"
label(data$t1_episiotomia) = "Foi realizado episiotomia?"
label(data$t1_analgesia) = "Foi feita analgesia no parto?"
label(data$t1_filhos) = "Número de filhos nascidos no parto"
label(data$t1_alta) = "O bebê teve alta junto com você (mãe)? "
label(data$t1_motivo_alta) = "Qual o motivo?"
label(data$t1_intercorrencia) = "Houve alguma intercorrência?"
label(data$t1_tipo_interc) = "Qual foi a intercorrência?"
label(data$t1_cpap) = "Precisou de oxigenação artificial ao nascer (CPAP)?"
label(data$t1_incubadora) = "Precisou de incubadora ao nascer?"
label(data$t1_apgar1) = "Qual o APGAR de 1º minuto?"
label(data$t1_apgar5) = "Qual o APGAR de 5º minuto?"
label(data$t1_previa) = "Quantos filhos(as) você já teve antes dele(a)? Indique zero (0) se ele(a) é o(a) seu(sua) primeiro(a) filho(a)."
label(data$dados_de_nascimento_e_antropometricos_t1_complete) = "Complete?"
label(data$primeiro_ano_de_vida_do_bebe_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_primeiro) = "start"
label(data$t1_posnatal) = "Quantas consultas com o pediatra o bebê teve até o momento? "
label(data$t1_vacinas) = "Já recebeu alguma vacina?"
label(data$t1_amament1) = "O(A) [t1_crianca] mama no peito? "
label(data$t1_amament1a) = "Há quanto tempo [t1_crianca] mama exclusivamente no peito? Isto é, recebeu APENAS leite materno e nenhum outro alimento, como fórmulas, sucos, chás etc."
label(data$t1_doenca_bebe1) = "O(A) [t1_crianca] foi diagnosticado com alguma doença por um médico? (Exemplo: dermatite atopica, bronquite, rinite, asma, etc)"
label(data$t1_doenca_bebe1a) = "Qual foi a doença diagnosticada?"
label(data$t1_hospitalizacao1) = "O(A) [t1_crianca] teve algum problema que precisou que ele fosse hospitalizado? (Ele precisou ficar algum tempo sobre observação, isto é, diferente de uma consulta médica típica)."
label(data$t1_hospitalizacao1a) = "Qual foi o motivo que o levou a ser hospitalizado?"
label(data$primeiro_ano_de_vida_do_bebe_t1_complete) = "Complete?"
label(data$tratamento_saude_mental_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_ttmental) = "Start"
label(data$t1_sm1) = "Você já fez tratamento psicológico (psicoterapia)?"
label(data$t1_sm1a) = "Quantos anos você tinha quando realizou tratamento psicológico pela primeira vez?"
label(data$t1_sm1b) = "Por qual(ais) razão(ões) você realizou tratamento psicológico?"
label(data$t1_sm2) = "Quando foi o seu último tratamento psicológico?"
label(data$t1_sm5) = "Por qual(ais) razão(ões) você realizou esse último tratamento psicológico?"
label(data$t1_sm3) = "Você já fez tratamento psiquiátrico?"
label(data$t1_sm3a) = "Quantos anos você tinha quando realizou tratamento psiquiátrico pela primeira vez?"
label(data$t1_sm3b) = "Por qual(ais) razão(ões) você realizou tratamento psiquiátrico?"
label(data$t1_sm3c) = "Tomou medicações psiquiátricas em algum momento?"
label(data$t1_sm3d) = "Quais medicações psiquiátricas você tomou?"
label(data$t1_sm4) = "Quando foi o seu último tratamento psiquiátrico?"
label(data$t1_sm6) = "Por qual(ais) razão(ões) você realizou esse último tratamento psiquiátrico?"
label(data$t1_sm7) = "Tomou medicações psiquiátricas nesse último tratamento?"
label(data$t1_sm8) = "Quais medicações psiquiátricas você tomou?"
label(data$tratamento_saude_mental_t1_complete) = "Complete?"
label(data$uso_de_smartphones_e_apps_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_smart) = "start"
label(data$t1_app1_a) = "App 1"
label(data$t1_app1_b) = "App 2"
label(data$t1_app1_c) = "App 3"
label(data$t1_app1_d) = "App 4"
label(data$t1_app1_e) = "App 5"
label(data$t1_app2) = "Você usa algum app para smartphone específico para mães?"
label(data$t1_app2a) = "Quais apps são esses?"
label(data$t1_app3) = "Você usa algum app para smartphone específico para saúde física ou saúde mental?"
label(data$t1_app3a) = "Quais apps são esses?"
label(data$t1_app4) = "Pensando nos últimos 7 dias, da hora que você acorda até dormir, quanto tempo em média você gasta por dia usando seu smartphone? Considere todas as atividades e usos (mensagens, redes sociais, qualquer tipo de app).  (OBS: colocar em HH:MM - ex. pessoa ficou 7 horas no celular, colocar 07:00) "
label(data$uso_de_smartphones_e_apps_t1_complete) = "Complete?"
label(data$tratamento_saude_mental_t3_timestamp) = "Survey Timestamp"
label(data$t3_start_ttmental) = "start"
label(data$t3_data) = "Data da avaliação"
label(data$t3_avaliador) = "Nome do avaliadora"
label(data$t3_sm1) = "Desde que nos falamos pela última vez, você iniciou tratamento psicológico (psicoterapia)?"
label(data$t3_sm1b) = "Por qual(ais) razão(ões) você iniciou esse tratamento psicológico?"
label(data$t3_sm2) = "Desde que nos falamos, você continua fazendo tratamento psicológico (psicoterapia)?"
label(data$t3_sm3) = "Desde que nos falamos pela última vez, você iniciou tratamento psiquiátrico?"
label(data$t3_sm3b) = "Por qual(ais) razão(ões) você realizou tratamento psiquiátrico?"
label(data$t3_sm3x) = "Desde que nos falamos pela última vez, você continua fazendo algum tratamento psiquiátrico?"
label(data$t3_sm3c) = "Está tomando alguma medicação psiquiátrica no momento?"
label(data$t3_sm3d) = "Quais medicações psiquiátricas você está tomando?"
label(data$tratamento_saude_mental_t3_complete) = "Complete?"
label(data$tratamento_saude_mental_t4_timestamp) = "Survey Timestamp"
label(data$t4_start_ttmental) = "start"
label(data$t4_data) = "Data da avaliação"
label(data$t4_avaliador) = "Nome do avaliadora"
label(data$t4_sm1) = "Desde que nos falamos pela última vez, você iniciou tratamento psicológico (psicoterapia)?"
label(data$t4_sm1b) = "Por qual(ais) razão(ões) você iniciou esse tratamento psicológico?"
label(data$t4_sm2) = "Desde que nos falamos, você continua fazendo tratamento psicológico (psicoterapia)?"
label(data$t4_sm3) = "Desde que nos falamos pela última vez, você iniciou tratamento psiquiátrico?"
label(data$t4_sm3b) = "Por qual(ais) razão(ões) você realizou tratamento psiquiátrico?"
label(data$t4_sm3x) = "Desde que nos falamos pela última vez, você continua fazendo algum tratamento psiquiátrico?"
label(data$t4_sm3c) = "Está tomando alguma medicação psiquiátrica no momento?"
label(data$t4_sm3d) = "Quais medicações psiquiátricas você está tomando?"
label(data$tratamento_saude_mental_t4_complete) = "Complete?"
label(data$qidssr16_timestamp) = "Survey Timestamp"
label(data$t1_start_qidssr) = "start"
label(data$t1_qidssr16_1) = "Pegar no Sono:"
label(data$t1_qidssr16_2) = "Sono durante a noite:"
label(data$t1_qidssr16_3) = "Acordar cedo demais: "
label(data$t1_qidssr16_4) = "Dormir demais:"
label(data$t1_qidssr16_5) = "Sentir-se triste:"
label(data$t1_qidssr16_txt2) = "- Com relação ao seu apetite:"
label(data$t1_qidssr16_6) = "Apetite Diminuído"
label(data$t1_qidssr16_7) = "Apetite Aumentado"
label(data$t1_qidssr16_txt3) = "- Com relação ao seu peso (nas últimas 2 semanas):"
label(data$t1_qidssr16_8) = "Perda de peso (nas duas últimas semanas)"
label(data$t1_qidssr16_9) = "Aumento de Peso (nas duas últimas semanas) "
label(data$t1_qidssr16_10) = "Concentração / Tomar decisões: "
label(data$t1_qidssr16_11) = "Visão de Mim Mesmo: "
label(data$t1_qidssr16_12) = "Ideias de Morte e Suicídio: "
label(data$t1_qidssr16_13) = "Interesse geral: "
label(data$t1_qidssr16_14) = "Nível de energia:"
label(data$t1_qidssr16_15) = "Sentir lentidão:"
label(data$t1_qidssr16_16) = "Sentir-se agitado:"
label(data$t1_qidssr16_total) = "Somatória dos itens"
label(data$t1_qidssr16_total_2) = "Somatória dos itens"
label(data$qidssr16_complete) = "Complete?"
label(data$t1_start_qidsc) = "start"
label(data$t1_qidsc16_1) = "Insônia Inicial"
label(data$t1_qidsc16_2) = "Insônia Intermediária (Meio da noite)"
label(data$t1_qidsc16_3) = "Insônia Terminal (Acordar cedo demais)"
label(data$t1_qidsc16_4) = "Hipersonia"
label(data$t1_qidsc16_5) = "Humor (Triste)"
label(data$t1_qidsc16_txt2) = "- Com relação ao apetite:"
label(data$t1_qidsc16_6) = "Apetite (Diminuído)"
label(data$t1_qidsc16_7) = "Apetite (Aumentado)"
label(data$t1_qidsc16_txt3) = "- Com relação ao peso:"
label(data$t1_qidsc16_8) = "Peso (Diminuição) nas últimas duas semanas"
label(data$t1_qidsc16_9) = "Peso (Aumento) nas últimas duas semanas"
label(data$t1_qidsc16_10) = "Concentração / Tomada de Decisão"
label(data$t1_qidsc16_11) = "Visão de si mesmo"
label(data$t1_qidsc16_12) = "Ideação Suicida"
label(data$t1_qidsc16_13) = "Envolvimento"
label(data$t1_qidsc16_14) = "Nível de energia / Fadiga"
label(data$t1_qidsc16_15) = "Lentificação psicomotora"
label(data$t1_qidsc16_16) = "Agitação psicomotora"
label(data$t1_qidsc16_total) = "Pontuação final"
label(data$qidsc16_complete) = "Complete?"
label(data$escala_de_depresso_de_edimburgo_epds_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_epds) = "start"
label(data$t1_epds1) = "Eu tenho sido capaz de rir e achar graça das coisas."
label(data$t1_epds2) = "Eu tenho pensado no futuro com alegria."
label(data$t1_epds3) = "Eu tenho me culpado sem razão quando as coisas dão errado."
label(data$t1_epds4) = "Eu tenho ficado ansiosa ou preocupada sem uma boa razão.  "
label(data$t1_epds5) = "Eu tenho me sentido assustada ou em pânico sem um bom motivo. "
label(data$t1_epds6) = "Eu tenho me sentido sobrecarregada pelas tarefas e acontecimentos do meu dia-a-dia.   "
label(data$t1_epds7) = "Eu tenho me sentido tão infeliz que eu tenho tido dificuldade de dormir.  "
label(data$t1_epds8) = "Eu tenho me sentido triste ou muito mal."
label(data$t1_epds9) = "Eu tenho me sentido tão triste que tenho chorado.	"
label(data$t1_epds10) = "Eu tenho pensado em fazer alguma coisa contra mim mesma."
label(data$t1_total_epds) = "Somatória EPDS"
label(data$escala_de_depresso_de_edimburgo_epds_t1_complete) = "Complete?"
label(data$escala_de_ansiedade_generalizada_gad7_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_gad) = "start"
label(data$t1_gad1) = "Sentiu-se nervosa, ansiosa, inquieta."
label(data$t1_gad2) = "Não conseguiu parar de se preocupar ou controlar suas preocupações."
label(data$t1_gad3) = "Se preocupou demais com diferentes coisas."
label(data$t1_gad4) = "Sentiu dificuldade em relaxar."
label(data$t1_gad5) = "Ficou tão agitada que foi difícil ficar parada."
label(data$t1_gad6) = "Ficou facilmente aborrecida, irritada."
label(data$t1_gad7) = "Sentiu-se com medo, como se algo ruim pudesse acontecer."
label(data$t1_total_gad) = "Somatória GAD-7"
label(data$escala_de_ansiedade_generalizada_gad7_t1_complete) = "Complete?"
label(data$escala_de_incapacidade_de_sheehan_sds_timestamp) = "Survey Timestamp"
label(data$t1_start_sds) = "start"
label(data$t1_sds1) = "Vida Familiar / Responsabilidades do Lar  Os sintomas têm interrompido sua vida familiar/responsabilidades do lar?"
label(data$t1_sds2) = "Trabalho/Escola  Os sintomas têm interrompido suas atividades no trabalho/escola? "
label(data$t1_sds3) = "Vida Social  Os sintomas têm interrompido sua vida social?  "
label(data$escala_de_incapacidade_de_sheehan_sds_complete) = "Complete?"
label(data$pittsburgh_sleep_quality_index_psqi_timestamp) = "Survey Timestamp"
label(data$t1_start_psqi) = "start"
label(data$t1_psqi_1) = "Durante o último mês, quando você geralmente foi para a cama à noite?   Hora usual de deitar:"
label(data$t1_psqi_2) = "Durante o último mês, quanto tempo (em minutos) você geralmente levou para dormir à noite? "
label(data$t1_psqi_3) = "Durante o último mês, quando você geralmente levantou de manhã?   Hora usual de levantar: "
label(data$t1_psqi_4) = "Durante o último mês, quantas horas de sono você teve por noite? (Este pode ser diferente do número de horas que você ficou na cama).  "
label(data$t1_psqi_5a) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Não conseguiu adormecer em até 30 minutos  "
label(data$t1_psqi_5b) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Acordou no meio da noite ou de manhã cedo "
label(data$t1_psqi_5c) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Precisou levantar para ir ao banheiro "
label(data$t1_psqi_5d) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Não conseguiu respirar confortavelmente "
label(data$t1_psqi_5e) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Tossiu ou roncou forte  "
label(data$t1_psqi_5f) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Sentiu muito frio  "
label(data$t1_psqi_5g) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Sentiu muito calor"
label(data$t1_psqi_5h) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Teve sonhos ruins  "
label(data$t1_psqi_5i) = "Durante o último mês, com que frequência você teve dificuldade de dormir porque você... Teve dor "
label(data$t1_psqi_5j1) = "Durante o último mês, existe outra razão que causou em você dificuldade de dormir? Por favor, descreva. "
label(data$t1_psqi_5j2) = "Com que frequência, durante o último mês, você teve dificuldade para dormir devido a essa razão? "
label(data$t1_psqi_6) = "Durante o último mês, como você classificaria a qualidade do seu sono de uma maneira geral? "
label(data$t1_psqi_7) = "Durante o último mês, com que frequência você tomou medicamento (prescrito ou por conta própria) para lhe ajudar a dormir? "
label(data$t1_psqi_8) = "No último mês, com que frequência você teve dificuldade de ficar acordado enquanto dirigia, comia ou participava de uma atividade social (festa, reunião de amigos, trabalho, estudo)? "
label(data$t1_psqi_9) = "Durante o último mês, quão problemático foi para você manter o entusiasmo (ânimo) para fazer as coisas (suas atividades habituais)? "
label(data$pittsburgh_sleep_quality_index_psqi_complete) = "Complete?"
label(data$psi_short_form_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_psi) = "start"
label(data$t1_psi56) = "Eu frequentemente sinto que eu não consigo lidar com as coisas muito bem."
label(data$t1_psi69) = "Eu percebo que eu desisto de mais coisas da minha vida para satisfazer as necessidades dos meus filhos do que eu pensava que eu teria de desistir."
label(data$t1_psi70) = "Eu me sinto presa às minhas responsabilidades como mãe."
label(data$t1_psi72) = "Desde que tive esse filho, eu não tenho conseguido fazer coisas novas e diferentes."
label(data$t1_psi73) = "Desde que tive filho, eu sinto que quase nunca consigo fazer as coisas de que gosto."
label(data$t1_psi76) = "Eu não estou satisfeita com a última compra de roupa que eu fiz."
label(data$t1_psi80) = "Tem um bom número de coisas que me incomodam na minha vida."
label(data$t1_psi85) = "Ter um filho tem me causado mais problemas em meu relacionamento com meu marido/companheiro(a) do que eu esperava."
label(data$t1_psi91) = "Eu me sinto sozinha e sem amigos."
label(data$t1_psi92) = "Quando eu vou a uma festa eu geralmente imagino que eu não vou me divertir."
label(data$t1_psi93) = "Eu não me interesso mais pelas pessoas como eu costumava me interessar."
label(data$t1_psi100) = "Eu não aprecio as coisas como eu costumava apreciar."
label(data$t1_psi10) = "O(A) [t1_arm_1][t1_crianca] raramente faz coisas para mim que fazem eu me sentir bem."
label(data$t1_psi12) = "Quando eu faço coisas para o(a) [t1_arm_1][t1_crianca], eu tenho a sensação que meus esforços não são muito apreciados."
label(data$t1_psi13) = "O(A) [t1_arm_1][t1_crianca] sorri para mim muito menos do que eu esperava."
label(data$t1_psi14) = "Às vezes eu sinto que o(a) [t1_arm_1][t1_crianca] não gosta de mim e não me quer por perto."
label(data$t1_psi18) = "O(A) [t1_arm_1][t1_crianca] é muito emotivo e fica chateado facilmente."
label(data$t1_psi23) = "O(A) [t1_arm_1][t1_crianca] parece que não aprende tão rápido quanto as outras crianças."
label(data$t1_psi24) = "O(A) [t1_arm_1][t1_crianca] parece que não sorri tanto quanto a maioria das crianças."
label(data$t1_psi26) = "O(A) [t1_arm_1][t1_crianca] não é capaz de fazer tantas coisas quanto eu esperava."
label(data$t1_psi38) = "Demora um longo tempo e é muito difícil para o(a) [t1_arm_1][t1_crianca] se acostumar com coisas novas."
label(data$t1_psi58) = "Eu sinto que eu sou: (Escolha uma resposta em relação às escolhas abaixo)."
label(data$t1_psi63) = "Eu esperava ter sentimentos mais positivos de afeição e íntimos pelo(a) [t1_arm_1][t1_crianca] do que eu tenho e isso me incomoda."
label(data$t1_psi64) = "Às vezes, o(a) [t1_arm_1][t1_crianca] faz coisas que me incomodam só para ser mau."
label(data$t1_psi17) = "O(A) [t1_arm_1][t1_crianca] parece que chora e fica agitado, reclama com mais frequência do que as outras crianças."
label(data$t1_psi19) = "O(A) [t1_arm_1][t1_crianca] geralmente acorda de mau humor"
label(data$t1_psi20) = "Eu sinto que o(a) [t1_arm_1][t1_crianca] é temperamental e fica chateado facilmente. "
label(data$t1_psi31) = "O(A) [t1_arm_1][t1_crianca] está sempre se pendurando em mim."
label(data$t1_psi32) = "O(A) [t1_arm_1][t1_crianca] reage muito fortemente quando algo que ele não gosta acontece."
label(data$t1_psi34) = "Quando está brincando, o(a) [t1_arm_1][t1_crianca] frequentemente não dá risada."
label(data$t1_psi36) = "Colocar os horários de comer e de dormir para o(a) [t1_arm_1][t1_crianca] foi muito mais difícil do que eu imaginava."
label(data$t1_psi41) = "Eu descobri que conseguir que o(a) [t1_arm_1][t1_crianca] faça alguma coisa ou pare de fazer algo que ele já está fazendo é: (Escolha uma resposta em relação às escolhas abaixo). "
label(data$t1_psi42) = "Pense com cuidado e conte o número de coisas que o(a) [t1_arm_1][t1_crianca] faz que incomodam você. Por exemplo, se recusa a escutar, fica agitado, chora, interrompe, briga, choraminga etc. (Escolha uma resposta em relação às escolhas abaixo)."
label(data$t1_psi44) = "Tem algumas coisas que o(a) [t1_arm_1][t1_crianca] faz que me incomodam muito."
label(data$t1_psi47) = "O comportamento do(a) [t1_arm_1][t1_crianca] é mais problemático do que eu esperava."
label(data$t1_psi50) = "O(A) [t1_arm_1][t1_crianca] tem mais demandas ou exige mais de mim do que a maioria das crianças."
label(data$psi_short_form_t1_complete) = "Complete?"
label(data$alcool_e_drogas_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_ad) = "start"
label(data$t1_droga1) = "Você tomou bebidas alcoólicas durante a gravidez?"
label(data$t1_droga1a) = "Atualmente, você toma bebidas alcoólicas? "
label(data$t1_droga1b) = "Com qual idade você começou a tomar bebidas alcoólicas?"
label(data$t1_droga2) = "Durante a gestação, você fumou cigarro (tabaco)?"
label(data$t1_droga2a) = "Atualmente, você fuma cigarro (tabaco)?"
label(data$t1_droga2b) = "Com qual idade você começou a fumar cigarro (tabaco)?"
label(data$t1_droga3) = "Durante a gestação, você usou maconha?"
label(data$t1_droga3a) = "Atualmente, você usa maconha? "
label(data$t1_droga3b) = "Com qual idade você começou a usar maconha?"
label(data$t1_droga4) = "Durante a gestação, você usou cocaína ou crack?"
label(data$t1_droga4a) = "Atualmente, você usa cocaína ou crack? "
label(data$t1_droga4b) = "Com qual idade você começou a usar cocaína ou crack?"
label(data$t1_droga5) = "Durante a gestação, você usou anfetaminas ou êxtase?"
label(data$t1_droga5a) = "Atualmente, você usa anfetaminas ou êxtase? "
label(data$t1_droga5b) = "Com qual idade você começou a usar anfetaminas ou êxtase?"
label(data$t1_droga6) = "Durante a gestação, você usou inalantes?"
label(data$t1_droga6a) = "Atualmente, você usa inalantes? "
label(data$t1_droga6b) = "Com qual idade você começou a usar inalantes?"
label(data$t1_droga7) = "Durante a gestação, você usou hipnóticos/sedativos?"
label(data$t1_droga7a) = "Atualmente, você usa hipnóticos/sedativos? "
label(data$t1_droga7b) = "Com qual idade você começou a usar hipnóticos/sedativos?"
label(data$t1_droga8) = "Durante a gestação, você usou alucinógenos?"
label(data$t1_droga8a) = "Atualmente, você usa alucinógenos? "
label(data$t1_droga8b) = "Com qual idade você começou a usar alucinógenos?"
label(data$t1_droga9) = "Durante a gestação, você usou opióides?"
label(data$t1_droga9a) = "Atualmente, você usa opióides? "
label(data$t1_droga9b) = "Com qual idade você começou a usar opióides?"
label(data$t1_droga10) = "Durante a gestação, você usou alguma outra droga?"
label(data$t1_droga10a) = "Atualmente, você usa alguma outra droga? "
label(data$t1_droga10b) = "Com qual idade você começou a usar essa outra droga?"
label(data$t1_droga10c) = "Qual droga é essa?"
label(data$alcool_e_drogas_t1_complete) = "Complete?"
label(data$avaliacao_suporte_social_timestamp) = "Survey Timestamp"
label(data$t1_start_social) = "start"
label(data$t1_mspss2) = "Tem uma pessoa que eu posso compartilhar minhas alegrias e tristezas."
label(data$t1_mspss4) = "Eu tenho ajuda emocional e suporte que eu preciso da minha família."
label(data$t1_mspss7) = "Eu posso contar com meus amigos quando as coisas dão errado."
label(data$t1_simss) = "Quantas pessoas você tem perto de você com quem pode contar para ajuda em momentos de dificuldade, como cuidar de crianças ou animais de estimação, dar caronas ao hospital ou loja, ou ajudar quando estiver doente?"
label(data$avaliacao_suporte_social_complete) = "Complete?"
label(data$escala_de_depressao_para_ac_formulario_breve_bads_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_bads) = "start"
label(data$t1_badssf1) = "Há certas coisas que eu tinha que fazer e não consegui"
label(data$t1_badssf2) = "Eu estou contente com a quantidade e tipos de coisas que eu fiz."
label(data$t1_badssf3) = "Eu estive engajado(a) em um amplo e variado conjunto de atividades."
label(data$t1_badssf4) = "Eu tomei boas decisões sobre as atividades e/ou situações em que me engajei."
label(data$t1_badssf5) = "Eu sou uma pessoa ativa e consegui atingir as metas que havia estabelecido."
label(data$t1_badssf6) = "O que eu mais fiz foi fugir ou esquivar de alguma coisa desagradável."
label(data$t1_badssf7) = "Eu perdi muito tempo pensando repetidamente sobre meus problemas."
label(data$t1_badssf8) = "Eu me engajei em atividades que me distraíram de me sentir mal."
label(data$t1_badssf9) = "Eu fiz coisas que eram agradáveis."
label(data$t1_badssf_total) = "Somatória BADS-SF"
label(data$escala_de_depressao_para_ac_formulario_breve_bads_t1_complete) = "Complete?"
label(data$indice_de_probabilidade_de_recompensa_rpi_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_rpi) = "start"
label(data$t1_rpi1) = "Eu tenho muitos interesses que me dão prazer."
label(data$t1_rpi2) = "Eu aproveito a maioria das oportunidades que estão disponíveis para mim."
label(data$t1_rpi3) = "Meus comportamentos frequentemente têm consequências negativas."
label(data$t1_rpi4) = "Eu faço amigos facilmente."
label(data$t1_rpi5) = "Existem muitas atividades que eu acho satisfatórias. "
label(data$t1_rpi6) = "Eu me considero uma pessoa com muitas habilidades."
label(data$t1_rpi7) = "Coisas acontecem que fazem me sentir desesperançoso(a) ou inadequado(a)."
label(data$t1_rpi8) = "Eu sinto um forte senso de realização."
label(data$t1_rpi9) = "Mudanças aconteceram na minha vida e tornaram difícil para mim encontrar diversão."
label(data$t1_rpi10) = "É fácil encontrar boas maneiras de passar o meu tempo."
label(data$t1_rpi11) = "Eu tenho as habilidades para obter prazer na vida."
label(data$t1_rpi12) = "Eu tenho poucos recursos financeiros, o que limita as coisas que eu posso fazer."
label(data$t1_rpi13) = "Eu tenho tido muitas experiências desagradáveis."
label(data$t1_rpi14) = "Parece que as coisas ruins sempre acontecem comigo."
label(data$t1_rpi15) = "Eu tenho boas habilidades sociais."
label(data$t1_rpi16) = "Eu frequentemente me machuco com os outros."
label(data$t1_rpi17) = "Pessoas são maldosas e agressivas comigo."
label(data$t1_rpi18) = "Eu fui muito capaz nos trabalhos que já tive."
label(data$t1_rpi19) = "Eu gostaria de encontrar um lugar para viver que traria mais satisfação para minha vida."
label(data$t1_rpi20) = "Eu tenho muitas oportunidades de socializar com as pessoas."
label(data$t1_total_rpi) = "Somatória RPI"
label(data$indice_de_probabilidade_de_recompensa_rpi_t1_complete) = "Complete?"
label(data$feedback_de_entrevista_timestamp) = "Survey Timestamp"
label(data$feedback_1) = "Dê uma nota para a avaliação:"
label(data$feedback_2) = "Você gostaria de fazer algum comentário sobre a avaliação que você acabou de realizar? Apenas a coordenação terá acesso à estas informações. "
label(data$feedback_de_entrevista_complete) = "Complete?"
label(data$clinical_global_impression_severity_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_cgi) = "start"
label(data$t1_cgi_s) = "Considerando os dados levantados durante a avaliação e considerando a sua experiência clínica prévia com pacientes com sintomas depressivos, como você classifica a gravidade dos sintomas dessa paciente neste momento?"
label(data$clinical_global_impression_severity_t1_complete) = "Complete?"
label(data$qualidade_da_entrevista_t1_timestamp) = "Survey Timestamp"
label(data$t1_start_qualisess) = "start"
label(data$t1_quali1) = "A avaliação ocorreu por qual meio?"
label(data$t1_quali2) = "...cooperativa. "
label(data$t1_quali3) = "...que ela estava sendo sincera ou verdadeira"
label(data$t1_quali4) = "...que ela estava muito à vontade."
label(data$t1_quali5) = "Na maioria das vezes você achou que ela entendeu as perguntas? "
label(data$t1_quali6) = "Escolha a opção que melhor descreve a qualidade da conexão ou da ligação telefônica:"
label(data$t1_quali7) = "Você acha que em algum momento a presença de alguma pessoa no ambiente da participante influenciou as respostas?"
label(data$t1_quali8) = "A participante estava fazendo atividades ou tarefas de casa enquanto respondia as perguntas?"
label(data$t1_quali9) = "Adicione aqui qualquer comentário que ache pertinente (ex. problemas, impressões gerais etc) a respeito da entrevista ou da participante:"
label(data$t1_horario_fim) = "Horário do fim da entrevista"
label(data$qualidade_da_entrevista_t1_complete) = "Complete?"
label(data$formulario_pre_sessao_timestamp) = "Survey Timestamp"
label(data$t1_start_pre) = "start"
label(data$t1_pre_sessao1) = "Descreva como é um dia típico seu, da manhã até a noite. O que você costuma fazer?"
label(data$t1_pre_sessao2) = "O que você gosta ou costumava gostar de fazer em momentos de lazer para se divertir, relaxar ou se sentir bem consigo mesma?"
label(data$t1_pre_sessao3) = "O que você costuma fazer ou sente que deveria estar fazendo de obrigações do dia a dia, trabalho, cuidados com a casa ou consigo mesma?"
label(data$t1_pre_sessao4) = "Há atividades que você fazia antes (por prazer, por obrigação ou por hábito) que deixou de fazer ou está fazendo menos desde que os sintomas começaram (ou desde que virou mãe)?"
label(data$t1_pre_sessao5) = "Que pessoas (familiares, amigos, etc.) você gosta de estar ou a quem pode pedir ajuda quando precisa? "
label(data$formulario_pre_sessao_complete) = "Complete?"
label(data$formulrio_para_pronturio_timestamp) = "Survey Timestamp"
label(data$pron_data) = "Data da sessão."
label(data$pron_duracao) = "Duração da sessão (em minutos)."
label(data$pron_terapeuta) = "Nome da psicoterapeuta."
label(data$pron_queixas) = "Descreva as principais queixas trazidas pela participante na sessão (Inclua contexto social, relacional ou prático que tenha emergido, além das queixas emocionais. Ex.: Participante relata isolamento social significativo desde o nascimento do bebê, sem rede de apoio próxima; apresenta também queixas relativas à amamentação, que está sendo muito difícil.) "
label(data$pron_etapas_intro___1) = "Quais etapas da fase de introdução foram efetivamente realizadas durante a sessão (choice=Apresentação da terapeuta)"
label(data$pron_etapas_intro___2) = "Quais etapas da fase de introdução foram efetivamente realizadas durante a sessão (choice=Psicoeducação sobre PSU)"
label(data$pron_etapas_intro___3) = "Quais etapas da fase de introdução foram efetivamente realizadas durante a sessão (choice=Acolhimento da queixa)"
label(data$pron_etapas_intro___4) = "Quais etapas da fase de introdução foram efetivamente realizadas durante a sessão (choice=Resumo da queixa)"
label(data$pron_etapas_aval___1) = "Quais aspectos foram efetivamente avaliados na fase de avaliação (choice=Rotina atual)"
label(data$pron_etapas_aval___2) = "Quais aspectos foram efetivamente avaliados na fase de avaliação (choice=Fonte de reforçamento)"
label(data$pron_etapas_aval___3) = "Quais aspectos foram efetivamente avaliados na fase de avaliação (choice=Rede de apoio)"
label(data$pron_etapas_aval___4) = "Quais aspectos foram efetivamente avaliados na fase de avaliação (choice=Experiências prévias)"
label(data$pron_ba___1) = "Quais intervenções de ativação comportamental foram efetivamente realizadas na sessão?  (choice=Explicação da racional)"
label(data$pron_ba___2) = "Quais intervenções de ativação comportamental foram efetivamente realizadas na sessão?  (choice=Brainstorm de atividades)"
label(data$pron_ba___3) = "Quais intervenções de ativação comportamental foram efetivamente realizadas na sessão?  (choice=Classificação de atividades por nível de dificuldade ou esforço)"
label(data$pron_ba___4) = "Quais intervenções de ativação comportamental foram efetivamente realizadas na sessão?  (choice=Definição de metas específicas e alcançáveis)"
label(data$pron_ba___5) = "Quais intervenções de ativação comportamental foram efetivamente realizadas na sessão?  (choice=Identificação de rede de apoio para suporte na execução da atividade)"
label(data$pron_ba_sim) = " Descreva as atividades agendadas e os obstáculos percebidos durante a sessão (inclua a área de cada atividade (lazer, produtividade, relacionamentos) e eventuais dificuldades observadas. Ex.: Agendadas duas atividades: caminhada leve 3 vezes por semana (lazer) e contato semanal com a irmã por videochamada (relacionamentos). Participante demonstrou interesse mas minimizou a própria capacidade de realizar, possível esquiva.) "
label(data$pron_ba_nao) = "Caso a ativação comportamental não tenha sido realizada, descreva (Ex.: BA não realizada pois participante apresentou ideação suicida. Sessão foi redirecionada para elaboração de plano de segurança). Caso contrário, escreva não se aplica. "
label(data$pron_tcc___1) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Questionamento socrático)"
label(data$pron_tcc___2) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Resolução de problemas)"
label(data$pron_tcc___3) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Psicoeducação adicional (além da introdução padrão da sessão))"
label(data$pron_tcc___4) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Reestruturação cognitiva)"
label(data$pron_tcc___5) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Higiene do sono)"
label(data$pron_tcc___6) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Manejo de estresse)"
label(data$pron_tcc___7) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Plano de segurança)"
label(data$pron_tcc___8) = "Outras técnicas de TCC utilizadas. (Selecione todas que se aplicam.) (choice=Outro)"
label(data$pron_tcc_outro) = "Especifique a outra técnica utilizada. "
label(data$pron_app_modulos___1) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Ativação Comportamental)"
label(data$pron_app_modulos___2) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Regulação Emocional)"
label(data$pron_app_modulos___3) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Manejo de Estresse)"
label(data$pron_app_modulos___4) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Reestruturação Cognitiva)"
label(data$pron_app_modulos___5) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Higiene do Sono)"
label(data$pron_app_modulos___6) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Mindfulness)"
label(data$pron_app_modulos___7) = "Módulos do aplicativo Motherly utilizados na sessão. (Selecione todos que se aplicam.) (choice=Aplicativo não acessado na sessão)"
label(data$pron_grav_sessao) = "A sessão de psicoterapia foi gravada? "
label(data$pron_ideacao) = "Ideação suicida foi identificada na sessão."
label(data$pron_ideacao_plano) = "Plano de segurança foi elaborado."
label(data$pron_ideacao_supervisao) = " Supervisão foi notificada"
label(data$pron_vd) = "Violência doméstica foi identificada na sessão."
label(data$pron_vd_rede) = "Rede de atendimento à mulher foi apresentada."
label(data$pron_app_instalado) = "O aplicativo estava instalado no início da sessão?"
label(data$pron_app_tecnico) = "Houve problemas técnicos com o aplicativo durante a sessão."
label(data$pron_app_resistencia) = "A participante demonstrou resistência ao uso do aplicativo."
label(data$pron_app_dificuldades) = "Descreva as dificuldades encontradas e como foram manejadas (Ex.: Participante não tinha o aplicativo instalado. Instalação realizada durante a sessão, consumindo cerca de 10 minutos. Participante teve dificuldade com o cadastro por não lembrar a senha do email, resolvido com criação de novo cadastro.)"
label(data$pron_obs) = "Use este campo para registrar qualquer informação clinicamente relevante não capturada nos campos anteriores: impressões sobre o vínculo, temas que emergiram mas não foram aprofundados, situações atípicas na sessão. Ex.: Participante ficou muito emocionada ao falar sobre a relação com a mãe, que faleceu durante a gestação. Tema não aprofundado por limitação de tempo. Aliança percebida como boa, com engajamento ao longo de toda a sessão.) "
label(data$formulrio_para_pronturio_complete) = "Complete?"
label(data$qualidade_da_sessao_timestamp) = "Survey Timestamp"
label(data$t1_start_quali) = "start"
label(data$t1_quali_terapeuta) = "Terapeuta"
label(data$t1_quali_sessao_data) = "Data da sessão"
label(data$t1_quali_sessao_inicio) = "Horário de início da sessão"
label(data$t1_quali_sessao_fim) = "Horário do fim da sessão"
label(data$t1_quali_sessao_meio) = "A sessão de psicoterapia ocorreu por qual meio?"
label(data$t1_quali_sessao1) = "...cooperativa. "
label(data$t1_quali_sessao2) = "...que ela estava sendo sincera ou verdadeira"
label(data$t1_quali_sessao3) = "...que ela estava muito à vontade."
label(data$t1_quali_sessao4) = "Na maioria das vezes você achou que ela entendeu as perguntas? "
label(data$t1_quali_sessao5) = "Escolha a opção que melhor descreve a qualidade da conexão da Videochamada:"
label(data$t2_quali_sessao6) = "Você acha que em algum momento a presença de alguma pessoa no ambiente da participante influenciou o que ela disse em sessão?"
label(data$t1_quali_sessao7) = "A participante estava fazendo atividades ou tarefas de casa enquanto fazia a sessão?"
label(data$t1_quali_sessao8) = "Como foi a finalização da sessão?"
label(data$t1_quali_sessao8a) = "Motivo da intercorrência:"
label(data$t1_quali_sessao9) = "Adicione aqui qualquer comentário que ache pertinente a respeito da psicoterapia ou da participante:"
label(data$qualidade_da_sessao_complete) = "Complete?"
label(data$waisr_timestamp) = "Survey Timestamp"
label(data$t2_start_waiclient) = "start"
label(data$t2_waisrc_1) = "1. Como resultado desta sessão, eu tenho mais clareza sobre como poderei mudar."
label(data$t2_waisrc_2) = "2. O que estou fazendo na terapia me fornece novas maneiras ver o meu problema."
label(data$t2_waisrc_3) = "3. Eu acho que [t1_arm_1][t1_quali_terapeuta] gosta de mim."
label(data$t2_waisrc_4) = "4. [t1_arm_1][t1_quali_terapeuta] e eu colaboramos para definir os objetivos da minha terapia."
label(data$t2_waisrc_5) = "5. [t1_arm_1][t1_quali_terapeuta] e eu respeitamo-nos mutuamente."
label(data$t2_waisrc_6) = "6. [t1_arm_1][t1_quali_terapeuta] e eu estamos trabalhando para alcançar objetivos que foram mutuamente acordados."
label(data$t2_waisrc_7) = "7. Eu sinto que [t1_arm_1][t1_quali_terapeuta] gosta de mim."
label(data$t2_waisrc_8) = "8. [t1_arm_1][t1_quali_terapeuta] e eu concordamos sobre aquilo que é importante eu trabalhar."
label(data$t2_waisrc_9) = "9. Eu sinto que [t1_arm_1][t1_quali_terapeuta] se importa comigo mesmo quando faço coisas que ele(a) não aprova."
label(data$t2_waisrc_10) = "10. Sinto que aquilo que eu faço em terapia irá me ajudar a atingir as mudanças que eu quero."
label(data$t2_waisrc_11) = "11. [t1_arm_1][t1_quali_terapeuta] e eu estabelecemos um bom entendimento sobre quais mudanças seriam boas para mim."
label(data$t2_waisrc_12) = "12. Acredito que o modo como estamos trabalhando com o meu problema é correto. "
label(data$t2_waisrc_goals) = "Goals"
label(data$t2_waisrc_tasks) = "Tasks"
label(data$t2_waisrc_bond) = "Bond"
label(data$waisr_complete) = "Complete?"
label(data$system_usability_of_scale_sus_t3_timestamp) = "Survey Timestamp"
label(data$t3_start_sus) = "start"
label(data$t3_sus1) = "Acho que gostaria de utilizar este produto com frequência."
label(data$t3_sus2) = "Considerei o produto mais complexo do que o necessário."
label(data$t3_sus3) = "Achei o produto fácil de utilizar."
label(data$t3_sus4) = "Acho que necessitaria de ajuda de um técnico para conseguir utilizar este produto."
label(data$t3_sus5) = "Considerei que as várias funcionalidades deste produto estavam bem integradas."
label(data$t3_sus6) = "Achei que este produto tinha muitas inconsistências."
label(data$t3_sus7) = "Suponho que a maioria das pessoas aprenderia a utilizar rapidamente este produto."
label(data$t3_sus8) = "Considerei o produto muito complicado de utilizar."
label(data$t3_sus9) = "Senti-me muito confiante ao utilizar este produto."
label(data$t3_sus10) = "Tive que aprender muito antes de conseguir lidar com este produto."
label(data$t3_total_sus) = "Somatória SUS"
label(data$system_usability_of_scale_sus_t3_complete) = "Complete?"
label(data$mobile_application_rating_scale_user_version_umars_timestamp) = "Survey Timestamp"
label(data$t3_start_umars) = "start"
label(data$t3_umars17) = "Você recomendaria este aplicativo para pessoas que poderiam se beneficiar de seu uso?"
label(data$t3_umars18) = "Quantas vezes você acha que usaria este aplicativo nos próximos 12 meses se fosse relevante para você? "
label(data$t3_umars19) = "Você pagaria por este aplicativo?"
label(data$t3_umars20) = "Qual é a sua avaliação geral do aplicativo? "
label(data$t3_umars21) = "Conscientização: Este aplicativo me deixou mais consciente sobre a importância de lidar com a saúde mental."
label(data$t3_umars22) = "Conhecimento: Este aplicativo expandiu meu conhecimento sobre saúde mental."
label(data$t3_umars23) = "Atitudes - Este aplicativo mudou minhas atitudes melhorando minha saúde mental. "
label(data$t3_umars24) = "Intenção de mudar - Este aplicativo expandiu minhas intenções/motivações para lidar com a saúde mental. "
label(data$t3_umars25) = "Procurar ajuda - Este aplicativo me motivaria a procurar ajuda para lidar com problemas de saúde mental (como Depressão ou Ansiedade). "
label(data$t3_umars26) = "Mudança de comportamento - O uso deste aplicativo vai aumentar as coisas que faço para melhorar minha saúde mental. "
label(data$final_app2a) = "O que você achou do Motherly? (Lembre-se: você está livre para falar o que desejar). "
label(data$final_app3a) = "Você tem alguma sugestão de melhoria? (Lembre-se: você está livre para falar o que desejar). "
label(data$mobile_application_rating_scale_user_version_umars_complete) = "Complete?"
label(data$clinical_global_impression_improvement_t3_timestamp) = "Survey Timestamp"
label(data$t3_start_cgi) = "start"
label(data$t3_cgi_i) = "Comparado à condição da paciente no início do estudo, qual o grau de alteração que ocorreu?"
label(data$clinical_global_impression_improvement_t3_complete) = "Complete?"
label(data$qualidade_da_entrevista_t3_timestamp) = "Survey Timestamp"
label(data$t3_start_qualient) = "start"
label(data$t3_quali1) = "A avaliação ocorreu por qual meio?"
label(data$t3_quali2) = "...cooperativa. "
label(data$t3_quali3) = "...que ela estava sendo sincera ou verdadeira"
label(data$t3_quali4) = "...que ela estava muito à vontade."
label(data$t3_quali5) = "Na maioria das vezes você achou que ela entendeu as perguntas? "
label(data$t3_quali6) = "Escolha a opção que melhor descreve a qualidade da conexão ou da ligação telefônica:"
label(data$t3_quali7) = "Adicione aqui qualquer comentário que ache pertinente (ex. problemas, impressões gerais etc) a respeito da entrevista ou da gestante:"
label(data$t3_quali8) = "Você acha que a participante necessita de encaminhamento para atendimento ou serviço de saúde?"
label(data$t3_horario_fim) = "Horário do fim da entrevista"
label(data$t3_cegamento_1) = "A qual grupo você acredita que a participante foi alocada?"
label(data$t3_cegamento_2) = "Qual o seu grau de confiança nessa resposta?  "
label(data$t3_cegamento_3) = "Durante a entrevista, a participante revelou a qual grupo foi alocada?  "
label(data$qualidade_da_entrevista_t3_complete) = "Complete?"
label(data$wai_terapeuta_timestamp) = "Survey Timestamp"
label(data$t2_start_wait) = "start"
label(data$t2_waisrt_1) = "A [t0_arm_1][t0_nome] e eu estamos de acordo acerca das coisas que é necessário fazer em terapia para ajudar a melhorar a sua situação. "
label(data$t2_waisrt_2) = "Estou genuinamente preocupado com o bem-estar da [t0_arm_1][t0_nome] ."
label(data$t2_waisrt_3) = "A [t0_arm_1][t0_nome] e eu trabalhamos para objetivos que foram mutuamente acordados."
label(data$t2_waisrt_4) = "A [t0_arm_1][t0_nome] e eu temos confiança na utilidade das nossas atividades em terapia."
label(data$t2_waisrt_5) = "Aprecio a [t0_arm_1][t0_nome] como pessoa."
label(data$t2_waisrt_6) = "Estabelecemos um bom entendimento quanto às mudanças que seriam boas para a [t0_arm_1][t0_nome]."
label(data$t2_waisrt_7) = "A [t0_arm_1][t0_nome] e eu respeitamo-nos mutuamente."
label(data$t2_waisrt_8) = "A [t0_arm_1][t0_nome] e eu temos uma percepção comum acerca dos seus objetivos."
label(data$t2_waisrt_9) = "Eu respeito a [t0_arm_1][t0_nome] mesmo quando faz coisas que eu não aprovo."
label(data$t2_waisrt_10) = "Estamos de acordo acerca daquilo em que é importante a [t0_arm_1][t0_nome] trabalhar."
label(data$t2_waisrt_tasks) = "Tasks"
label(data$t2_waisrt_goals) = "Goals "
label(data$t2_waisrt_bond) = "Bond"
label(data$wai_terapeuta_complete) = "Complete?"
label(data$enc_data) = "Data:"
label(data$enc_nome) = "Nome:"
label(data$enc_1___1) = "Motivo do encaminhamento: (choice=Agravamento da depressão)"
label(data$enc_1___2) = "Motivo do encaminhamento: (choice=Ideação suicida)"
label(data$enc_1___3) = "Motivo do encaminhamento: (choice=Planejamento ou tentativa de suicídio)"
label(data$enc_1___4) = "Motivo do encaminhamento: (choice=Violência doméstica)"
label(data$enc_1___5) = "Motivo do encaminhamento: (choice=Outros)"
label(data$enc_1a) = "Outros:"
label(data$enc_2) = "Descreva aqui o motivo do encaminhamento:"
label(data$enc_3) = "Encaminhamento foi oferecido?"
label(data$enc_4) = "A paciente aceitou o encaminhamento?"
label(data$enc_6) = "Nome do(a) psiquiatra: "
label(data$enc_7) = "Data da realização do atendimento psiquiátrico: "
label(data$enc_5) = "Observações do(a) psiquiatra: "
label(data$formulrio_de_encaminhamento_complete) = "Complete?"
label(data$formulario_dropout_timestamp) = "Survey Timestamp"
label(data$start_drop) = "start"
label(data$data_dropout) = "Data da desistência de participação"
label(data$dropout1) = "A participante mencionou não ter mais interesse em continuar esperando a intervenção? (Foi randomizada para lista de espera)."
label(data$dropout2) = "A participante mencionou não ter mais interesse na intervenção? (Foi randomizada para intervenção)"
label(data$dropout3) = "A participante desistiu de avaliações? "
label(data$dropout4) = "Quem ela comunicou essa decisão?"
label(data$dropout5) = "Por qual meio a participante comunicou a desistência/saída do estudo? "
label(data$dropout6) = "Qual o motivo da desistência/saída do estudo que a participante reportou?"
label(data$dropout7) = "A desistência teve alguma relação com efeitos adversos? "
label(data$dropout7a) = "Quais foram os efeitos adversos?"
label(data$dropout8) = "Na sua opinião, refletindo em retrospecto, o que poderíamos ter feito para evitar esse dropout?"
label(data$formulario_dropout_complete) = "Complete?"
label(data$form_falta_data) = "Data"
label(data$form_falta_nome) = "Nome:"
label(data$form_falta_razao) = "Descreva aqui as motivações/circunstâncias da falta:"
label(data$formulrio_de_falta_complete) = "Complete?"
label(data$ae_qidsc_a_t3) = "Pontuação QIDS-C em T1: [t1_arm_1][t1_qidsc16_total] Pontuação QIDS-C em T3: [t3_arm_1][t1_qidsc16_total] Percentual de diferença:  "
label(data$ae_qidsc_b_t3) = "Houve piora maior ou igual a 30% em relação à T1?  1 = sim 0 = não"
label(data$ae_qidsc_c_t3) = "Houve surgimento de ideação suicida ou tentativa na QIDS-C em T3 em relação à T1? 1 = sim 0 = não "
label(data$ae_comments_t3) = "Escreva neste espaço quaisquer observações que julgar relevante em relação à possíveis eventos adversos: "
label(data$formulrio_de_eventos_adversos_t3_complete) = "Complete?"
label(data$ae_qidssr_a_t4) = "Pontuação QIDS-SR em T1: [t1_arm_1][t1_qidssr16_total] Pontuação QIDS-SR em T4: [t4_arm_1][t1_qidssr16_total] Percentual de diferença:  "
label(data$ae_qidssr_b_t4) = "Houve piora maior ou igual a 30% em relação à T1? 1 = sim 0 = não "
label(data$ae_qidssr_c_t4) = "Houve surgimento de ideação suicida ou tentativa na QIDS-SR em T4 em relação à T1? 1 = sim 0 = não "
label(data$ae_comments_t4) = "Escreva neste espaço quaisquer observações que julgar relevante em relação à possíveis eventos adversos: "
label(data$formulrio_de_eventos_adversos_t4_complete) = "Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
mapping_redcap_event_name = c(
	"t0_arm_1" = "T0",
	"t1_arm_1" = "T1",
	"t2_arm_1" = "T2",
	"t3_arm_1" = "T3",
	"t4_arm_1" = "T4"
)
data$redcap_event_name.factor = factor(data$redcap_event_name, levels = names(mapping_redcap_event_name), labels = mapping_redcap_event_name)

mapping_t0_ref = c(
	"1" = "Grupos de Whatsapp",
	"2" = "Grupos de Facebook",
	"3" = "Post ou story no Instagram",
	"4" = "Profissional me indicou",
	"5" = "Reportagem ou matéria na internet",
	"6" = "Email",
	"7" = "Amiga ou colega me indicou",
	"8" = "Outros"
)
data$t0_ref.factor = factor(data$t0_ref, levels = names(mapping_t0_ref), labels = mapping_t0_ref)

mapping_t0_android = c(
	"0" = "Apple (iPhone)",
	"1" = "Samsung",
	"2" = "Motorola",
	"3" = "Apple",
	"4" = "Xiaomi",
	"5" = "LG",
	"6" = "Sony",
	"7" = "Realme",
	"8" = "Oppo",
	"9" = "Asus",
	"10" = "Huawei",
	"11" = "Infinix",
	"12" = "Positivo",
	"13" = "Multilaser",
	"14" = "Outro"
)
data$t0_android.factor = factor(data$t0_android, levels = names(mapping_t0_android), labels = mapping_t0_android)

mapping_t0_estado = c(
	"1" = "Acre",
	"2" = "Alagoas",
	"3" = "Amapá",
	"4" = "Amazonas",
	"5" = "Bahia",
	"6" = "Ceará",
	"7" = "Distrito Federal (Brasília)",
	"8" = "Espírito Santo",
	"9" = "Goiás",
	"10" = "Maranhão",
	"11" = "Mato Grosso",
	"12" = "Mato Grosso do Sul",
	"13" = "Minas Gerais",
	"14" = "Pará",
	"15" = "Paraíba",
	"16" = "Paraná",
	"17" = "Pernambuco",
	"18" = "Piauí",
	"19" = "Rio de Janeiro",
	"20" = "Rio Grande do Norte",
	"21" = "Rio Grande do Sul",
	"22" = "Rondônia",
	"23" = "Roraima",
	"24" = "Santa Catarina",
	"25" = "São Paulo",
	"26" = "Sergipe",
	"27" = "Tocantins"
)
data$t0_estado.factor = factor(data$t0_estado, levels = names(mapping_t0_estado), labels = mapping_t0_estado)

mapping_t0_disponivel1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_disponivel1.factor = factor(data$t0_disponivel1, levels = names(mapping_t0_disponivel1), labels = mapping_t0_disponivel1)

mapping_t0_diag1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_diag1.factor = factor(data$t0_diag1, levels = names(mapping_t0_diag1), labels = mapping_t0_diag1)

mapping_t0_diag1a = c(
	"1" = "Depressão",
	"2" = "Transtorno Bipolar",
	"3" = "Esquizofrenia ou Psicose",
	"4" = "Transtorno Alimentar (como anorexia ou bulimia)",
	"5" = "Abuso ou dependência de álcool",
	"6" = "Abuso ou dependência de substância ou droga",
	"7" = "Autismo ou transtorno do espectro do autismo",
	"8" = "Transtorno obsessivo-compulsivo ou TOC",
	"9" = "Outro"
)
data$t0_diag1a.factor = factor(data$t0_diag1a, levels = names(mapping_t0_diag1a), labels = mapping_t0_diag1a)

mapping_t0_diag2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_diag2.factor = factor(data$t0_diag2, levels = names(mapping_t0_diag2), labels = mapping_t0_diag2)

mapping_t0_tto1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_tto1.factor = factor(data$t0_tto1, levels = names(mapping_t0_tto1), labels = mapping_t0_tto1)

mapping_t0_tto1a = c(
	"0" = "Medicamentoso",
	"1" = "Psicoterapia",
	"2" = "Outro"
)
data$t0_tto1a.factor = factor(data$t0_tto1a, levels = names(mapping_t0_tto1a), labels = mapping_t0_tto1a)

mapping_t0_tto1c = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_tto1c.factor = factor(data$t0_tto1c, levels = names(mapping_t0_tto1c), labels = mapping_t0_tto1c)

mapping_t0_saude = c(
	"0" = "Muito ruim",
	"1" = "Ruim",
	"2" = "Razoável",
	"3" = "Boa",
	"4" = "Muito boa"
)
data$t0_saude.factor = factor(data$t0_saude, levels = names(mapping_t0_saude), labels = mapping_t0_saude)

mapping_t0_qidssr16_1 = c(
	"0" = "Nunca levo mais do que 30 minutos para pegar no sono.",
	"1" = "Levo pelo menos 30 minutos para pegar no sono, menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Levo pelo menos 30 minutos para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Levo mais de uma hora para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t0_qidssr16_1.factor = factor(data$t0_qidssr16_1, levels = names(mapping_t0_qidssr16_1), labels = mapping_t0_qidssr16_1)

mapping_t0_qidssr16_2 = c(
	"0" = "Não acordo durante a noite.",
	"1" = "Tenho um sono leve e agitado, acordando por períodos curtos em cada noite.",
	"2" = "Acordo pelo menos uma vez por noite, mas volto a dormir com facilidade.",
	"3" = "Acordo mais do que uma vez por noite e fico acordado(a) por 20 minutos ou mais, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t0_qidssr16_2.factor = factor(data$t0_qidssr16_2, levels = names(mapping_t0_qidssr16_2), labels = mapping_t0_qidssr16_2)

mapping_t0_qidssr16_3 = c(
	"0" = "Na maioria das vezes, acordo até 30 minutos antes do que preciso para levantar.",
	"1" = "Mais da metade das vezes (4 dias ou mais nos últimos 7 dias), acordo mais de 30 minutos antes do que preciso para levantar.",
	"2" = "Quase sempre acordo pelo menos em torno de uma hora antes da hora que eu preciso, mas acabo voltando a dormir.",
	"3" = "Acordo pelo menos uma hora antes do que preciso e não consigo voltar a dormir."
)
data$t0_qidssr16_3.factor = factor(data$t0_qidssr16_3, levels = names(mapping_t0_qidssr16_3), labels = mapping_t0_qidssr16_3)

mapping_t0_qidssr16_4 = c(
	"0" = "Durmo até 7-8 horas por noite, sem cochilos durante o dia.",
	"1" = "Durmo até 10 horas num período de 24 horas, incluindo cochilos.",
	"2" = "Durmo até 12 horas num período de 24 horas, incluindo cochilos.",
	"3" = "Durmo mais do que 12 horas num período de 24 horas, incluindo cochilos."
)
data$t0_qidssr16_4.factor = factor(data$t0_qidssr16_4, levels = names(mapping_t0_qidssr16_4), labels = mapping_t0_qidssr16_4)

mapping_t0_qidssr16_5 = c(
	"0" = "Não me sinto triste.",
	"1" = "Sinto-me triste menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Sinto-me triste mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Sinto-me triste quase o tempo todo."
)
data$t0_qidssr16_5.factor = factor(data$t0_qidssr16_5, levels = names(mapping_t0_qidssr16_5), labels = mapping_t0_qidssr16_5)

mapping_t0_qidssr16_txt2 = c(
	"0" = "Meu apetite habitual não mudou.",
	"1" = "Meu apetite diminuiu.",
	"2" = "Meu apetite aumentou."
)
data$t0_qidssr16_txt2.factor = factor(data$t0_qidssr16_txt2, levels = names(mapping_t0_qidssr16_txt2), labels = mapping_t0_qidssr16_txt2)

mapping_t0_qidssr16_6 = c(
	"1" = "Como com menor frequência ou menores quantidades de comida que o habitual.",
	"2" = "Como muito menos que o habitual e só com um esforço pessoal.",
	"3" = "Como raramente num período de 24 horas e só com um esforço pessoal extremo ou quando outros me convencem a comer."
)
data$t0_qidssr16_6.factor = factor(data$t0_qidssr16_6, levels = names(mapping_t0_qidssr16_6), labels = mapping_t0_qidssr16_6)

mapping_t0_qidssr16_7 = c(
	"1" = "Sinto necessidade de comer mais frequentemente do que o habitual.",
	"2" = "Regularmente, como com mais frequência e/ou em maiores quantidades do que o habitual.",
	"3" = "Sinto-me compelido a comer demais tanto nas refeições como entre elas."
)
data$t0_qidssr16_7.factor = factor(data$t0_qidssr16_7, levels = names(mapping_t0_qidssr16_7), labels = mapping_t0_qidssr16_7)

mapping_t0_qidssr16_txt3 = c(
	"0" = "Não tive qualquer mudança no meu peso.",
	"1" = "Perdi peso.",
	"2" = "Ganhei peso."
)
data$t0_qidssr16_txt3.factor = factor(data$t0_qidssr16_txt3, levels = names(mapping_t0_qidssr16_txt3), labels = mapping_t0_qidssr16_txt3)

mapping_t0_qidssr16_8 = c(
	"1" = "Sinto-me como se tivesse tido uma pequena perda de peso.",
	"2" = "Perdi 1 quilo ou mais.",
	"3" = "Perdi 2,5 quilos ou mais."
)
data$t0_qidssr16_8.factor = factor(data$t0_qidssr16_8, levels = names(mapping_t0_qidssr16_8), labels = mapping_t0_qidssr16_8)

mapping_t0_qidssr16_9 = c(
	"1" = "Sinto-me como se tivesse tido um pequeno aumento de peso.",
	"2" = "Engordei 1 quilo ou mais.",
	"3" = "Engordei 2,5 quilos ou mais"
)
data$t0_qidssr16_9.factor = factor(data$t0_qidssr16_9, levels = names(mapping_t0_qidssr16_9), labels = mapping_t0_qidssr16_9)

mapping_t0_qidssr16_10 = c(
	"0" = "Não houve mudança na minha capacidade habitual de me concentrar ou de tomar decisões.",
	"1" = "Ocasionalmente, me sinto indeciso(a) ou acho que minha atenção flutua.",
	"2" = "Na maior parte do tempo, me esforço para prestar atenção ou para tomar decisões.",
	"3" = "Não consigo me concentrar o suficiente para ler ou não consigo tomar nem mesmo decisões pequenas."
)
data$t0_qidssr16_10.factor = factor(data$t0_qidssr16_10, levels = names(mapping_t0_qidssr16_10), labels = mapping_t0_qidssr16_10)

mapping_t0_qidssr16_11 = c(
	"0" = "Considero-me tão valioso(a) e merecedor(a) como os outros.",
	"1" = "Recrimino-me mais do que o habitual.",
	"2" = "Acredito muito que causo problemas para os outros.",
	"3" = "Penso quase constantemente sobre pequenos e grandes defeitos em mim mesmo(a)."
)
data$t0_qidssr16_11.factor = factor(data$t0_qidssr16_11, levels = names(mapping_t0_qidssr16_11), labels = mapping_t0_qidssr16_11)

mapping_t0_qidssr16_12 = c(
	"0" = "Não penso em suicídio ou morte.",
	"1" = "Sinto que a vida é vazia e me pergunto se vale a pena viver.",
	"2" = "Penso em suicídio ou morte várias vezes por semana durante vários minutos.",
	"3" = "Penso em suicídio ou morte várias vezes por dia com algum detalhe, ou fiz planos específicos de suicídio, ou realmente tentei me matar."
)
data$t0_qidssr16_12.factor = factor(data$t0_qidssr16_12, levels = names(mapping_t0_qidssr16_12), labels = mapping_t0_qidssr16_12)

mapping_t0_qidssr16_13 = c(
	"0" = "Não houve mudanças do habitual quanto ao interesse que tenho em outras pessoas e atividades.",
	"1" = "Noto que estou menos interessado(a) em pessoas ou em atividades.",
	"2" = "Acho que tenho interesse em apenas uma ou duas das atividades a que me dedicava anteriormente.",
	"3" = "Não tenho praticamente interesse nenhum nas atividades a que me dedicava anteriormente."
)
data$t0_qidssr16_13.factor = factor(data$t0_qidssr16_13, levels = names(mapping_t0_qidssr16_13), labels = mapping_t0_qidssr16_13)

mapping_t0_qidssr16_14 = c(
	"0" = "Não há mudanças no meu nível habitual de energia.",
	"1" = "Fico cansado(a) mais facilmente do que o habitual.",
	"2" = "Tenho que fazer um grande esforço para começar ou acabar minhas atividades diárias habituais (por exemplo, fazer compras, lição de casa, cozinhar ou trabalhar).",
	"3" = "Eu não consigo realmente desempenhar a maioria das minhas atividades diárias, porque simplesmente não tenho energia."
)
data$t0_qidssr16_14.factor = factor(data$t0_qidssr16_14, levels = names(mapping_t0_qidssr16_14), labels = mapping_t0_qidssr16_14)

mapping_t0_qidssr16_15 = c(
	"0" = "Penso, falo e me movimento na minha velocidade habitual.",
	"1" = "Acho que o meu pensamento está mais lento ou a minha voz parece sem brilho ou monótona.",
	"2" = "Levo vários segundos para responder à maioria das perguntas e tenho certeza que o meu pensamento está lento.",
	"3" = "Sinto-me frequentemente incapaz de responder a perguntas sem um esforço extremo."
)
data$t0_qidssr16_15.factor = factor(data$t0_qidssr16_15, levels = names(mapping_t0_qidssr16_15), labels = mapping_t0_qidssr16_15)

mapping_t0_qidssr16_16 = c(
	"0" = "Não me sinto agitado(a).",
	"1" = "Fico frequentemente irrequieto(a), torcendo as mãos ou precisando trocar a posição em que estou sentado(a).",
	"2" = "Tenho impulsos de me movimentar e estou bastante agitado(a).",
	"3" = "Há ocasiões em que fico incapaz de permanecer sentado(a) e preciso andar de um lado para o outro."
)
data$t0_qidssr16_16.factor = factor(data$t0_qidssr16_16, levels = names(mapping_t0_qidssr16_16), labels = mapping_t0_qidssr16_16)

mapping_recrutamento_t0_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$recrutamento_t0_complete.factor = factor(data$recrutamento_t0_complete, levels = names(mapping_recrutamento_t0_complete), labels = mapping_recrutamento_t0_complete)

mapping_t0_celular_2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_celular_2.factor = factor(data$t0_celular_2, levels = names(mapping_t0_celular_2), labels = mapping_t0_celular_2)

mapping_t0_celular_3 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_celular_3.factor = factor(data$t0_celular_3, levels = names(mapping_t0_celular_3), labels = mapping_t0_celular_3)

mapping_t0_disponib___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___1.factor = factor(data$t0_disponib___1, levels = names(mapping_t0_disponib___1), labels = mapping_t0_disponib___1)

mapping_t0_disponib___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___2.factor = factor(data$t0_disponib___2, levels = names(mapping_t0_disponib___2), labels = mapping_t0_disponib___2)

mapping_t0_disponib___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___3.factor = factor(data$t0_disponib___3, levels = names(mapping_t0_disponib___3), labels = mapping_t0_disponib___3)

mapping_t0_disponib___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___4.factor = factor(data$t0_disponib___4, levels = names(mapping_t0_disponib___4), labels = mapping_t0_disponib___4)

mapping_t0_disponib___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___5.factor = factor(data$t0_disponib___5, levels = names(mapping_t0_disponib___5), labels = mapping_t0_disponib___5)

mapping_t0_disponib___6 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___6.factor = factor(data$t0_disponib___6, levels = names(mapping_t0_disponib___6), labels = mapping_t0_disponib___6)

mapping_t0_disponib___7 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___7.factor = factor(data$t0_disponib___7, levels = names(mapping_t0_disponib___7), labels = mapping_t0_disponib___7)

mapping_t0_disponib___8 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___8.factor = factor(data$t0_disponib___8, levels = names(mapping_t0_disponib___8), labels = mapping_t0_disponib___8)

mapping_t0_disponib___9 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___9.factor = factor(data$t0_disponib___9, levels = names(mapping_t0_disponib___9), labels = mapping_t0_disponib___9)

mapping_t0_disponib___10 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___10.factor = factor(data$t0_disponib___10, levels = names(mapping_t0_disponib___10), labels = mapping_t0_disponib___10)

mapping_t0_disponib___11 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___11.factor = factor(data$t0_disponib___11, levels = names(mapping_t0_disponib___11), labels = mapping_t0_disponib___11)

mapping_t0_disponib___12 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___12.factor = factor(data$t0_disponib___12, levels = names(mapping_t0_disponib___12), labels = mapping_t0_disponib___12)

mapping_t0_disponib___13 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___13.factor = factor(data$t0_disponib___13, levels = names(mapping_t0_disponib___13), labels = mapping_t0_disponib___13)

mapping_t0_disponib___14 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___14.factor = factor(data$t0_disponib___14, levels = names(mapping_t0_disponib___14), labels = mapping_t0_disponib___14)

mapping_t0_disponib___15 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___15.factor = factor(data$t0_disponib___15, levels = names(mapping_t0_disponib___15), labels = mapping_t0_disponib___15)

mapping_t0_disponib___16 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___16.factor = factor(data$t0_disponib___16, levels = names(mapping_t0_disponib___16), labels = mapping_t0_disponib___16)

mapping_t0_disponib___17 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___17.factor = factor(data$t0_disponib___17, levels = names(mapping_t0_disponib___17), labels = mapping_t0_disponib___17)

mapping_t0_disponib___18 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___18.factor = factor(data$t0_disponib___18, levels = names(mapping_t0_disponib___18), labels = mapping_t0_disponib___18)

mapping_t0_disponib___19 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___19.factor = factor(data$t0_disponib___19, levels = names(mapping_t0_disponib___19), labels = mapping_t0_disponib___19)

mapping_t0_disponib___20 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___20.factor = factor(data$t0_disponib___20, levels = names(mapping_t0_disponib___20), labels = mapping_t0_disponib___20)

mapping_t0_disponib___21 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$t0_disponib___21.factor = factor(data$t0_disponib___21, levels = names(mapping_t0_disponib___21), labels = mapping_t0_disponib___21)

mapping_recrutamento_1_t0_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$recrutamento_1_t0_complete.factor = factor(data$recrutamento_1_t0_complete, levels = names(mapping_recrutamento_1_t0_complete), labels = mapping_recrutamento_1_t0_complete)

mapping_t0_mini_a1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a1.factor = factor(data$t0_mini_a1, levels = names(mapping_t0_mini_a1), labels = mapping_t0_mini_a1)

mapping_t0_mini_a2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a2.factor = factor(data$t0_mini_a2, levels = names(mapping_t0_mini_a2), labels = mapping_t0_mini_a2)

mapping_t0_mini_a = c(
	"0" = "Não (Encerrar Módulo)",
	"1" = "Sim (Continuar para A3)"
)
data$t0_mini_a.factor = factor(data$t0_mini_a, levels = names(mapping_t0_mini_a), labels = mapping_t0_mini_a)

mapping_t0_mini_a3a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3a.factor = factor(data$t0_mini_a3a, levels = names(mapping_t0_mini_a3a), labels = mapping_t0_mini_a3a)

mapping_t0_mini_a3b = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3b.factor = factor(data$t0_mini_a3b, levels = names(mapping_t0_mini_a3b), labels = mapping_t0_mini_a3b)

mapping_t0_mini_a3c = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3c.factor = factor(data$t0_mini_a3c, levels = names(mapping_t0_mini_a3c), labels = mapping_t0_mini_a3c)

mapping_t0_mini_a3d = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3d.factor = factor(data$t0_mini_a3d, levels = names(mapping_t0_mini_a3d), labels = mapping_t0_mini_a3d)

mapping_t0_mini_a3e = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3e.factor = factor(data$t0_mini_a3e, levels = names(mapping_t0_mini_a3e), labels = mapping_t0_mini_a3e)

mapping_t0_mini_a3f = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3f.factor = factor(data$t0_mini_a3f, levels = names(mapping_t0_mini_a3f), labels = mapping_t0_mini_a3f)

mapping_t0_mini_a3g = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a3g.factor = factor(data$t0_mini_a3g, levels = names(mapping_t0_mini_a3g), labels = mapping_t0_mini_a3g)

mapping_t0_mini_a4_1 = c(
	"0" = "Não",
	"1" = "Sim (Episódio depressivo maior atual)"
)
data$t0_mini_a4_1.factor = factor(data$t0_mini_a4_1, levels = names(mapping_t0_mini_a4_1), labels = mapping_t0_mini_a4_1)

mapping_t0_mini_a5a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a5a.factor = factor(data$t0_mini_a5a, levels = names(mapping_t0_mini_a5a), labels = mapping_t0_mini_a5a)

mapping_t0_mini_a5b = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_a5b.factor = factor(data$t0_mini_a5b, levels = names(mapping_t0_mini_a5b), labels = mapping_t0_mini_a5b)

mapping_t0_mini_a5_b = c(
	"0" = "Não",
	"1" = "Sim (Episódio depressivo maior recorrente)"
)
data$t0_mini_a5_b.factor = factor(data$t0_mini_a5_b, levels = names(mapping_t0_mini_a5_b), labels = mapping_t0_mini_a5_b)

mapping_t0_mini_c1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_mini_c1.factor = factor(data$t0_mini_c1, levels = names(mapping_t0_mini_c1), labels = mapping_t0_mini_c1)

mapping_t0_mini_c2 = c(
	"0" = "Não",
	"2" = "Sim"
)
data$t0_mini_c2.factor = factor(data$t0_mini_c2, levels = names(mapping_t0_mini_c2), labels = mapping_t0_mini_c2)

mapping_t0_mini_c3 = c(
	"0" = "Não",
	"6" = "Sim"
)
data$t0_mini_c3.factor = factor(data$t0_mini_c3, levels = names(mapping_t0_mini_c3), labels = mapping_t0_mini_c3)

mapping_t0_mini_c4 = c(
	"0" = "Não",
	"10" = "Sim"
)
data$t0_mini_c4.factor = factor(data$t0_mini_c4, levels = names(mapping_t0_mini_c4), labels = mapping_t0_mini_c4)

mapping_t0_mini_c5 = c(
	"0" = "Não",
	"10" = "Sim"
)
data$t0_mini_c5.factor = factor(data$t0_mini_c5, levels = names(mapping_t0_mini_c5), labels = mapping_t0_mini_c5)

mapping_t0_mini_c6 = c(
	"0" = "Não",
	"4" = "Sim"
)
data$t0_mini_c6.factor = factor(data$t0_mini_c6, levels = names(mapping_t0_mini_c6), labels = mapping_t0_mini_c6)

mapping_t0_criterio_i_5 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_criterio_i_5.factor = factor(data$t0_criterio_i_5, levels = names(mapping_t0_criterio_i_5), labels = mapping_t0_criterio_i_5)

mapping_t0_criterio_e_1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_criterio_e_1.factor = factor(data$t0_criterio_e_1, levels = names(mapping_t0_criterio_e_1), labels = mapping_t0_criterio_e_1)

mapping_t0_criterio_e_4 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t0_criterio_e_4.factor = factor(data$t0_criterio_e_4, levels = names(mapping_t0_criterio_e_4), labels = mapping_t0_criterio_e_4)

mapping_t0_criterio_e_5 = c(
	"0" = "Não",
	"1" = "Sim, já tentou previamente duas alternativas de tratamento médico ou psicológico, por pelo menos 1 mês ou mais, e não surtiu efeito)"
)
data$t0_criterio_e_5.factor = factor(data$t0_criterio_e_5, levels = names(mapping_t0_criterio_e_5), labels = mapping_t0_criterio_e_5)

mapping_mini_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$mini_complete.factor = factor(data$mini_complete, levels = names(mapping_mini_complete), labels = mapping_mini_complete)

mapping_randomizacao_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$randomizacao_complete.factor = factor(data$randomizacao_complete, levels = names(mapping_randomizacao_complete), labels = mapping_randomizacao_complete)

mapping_tcle_concordo = c(
	"0" = "Recusar",
	"1" = "Aceitar"
)
data$tcle_concordo.factor = factor(data$tcle_concordo, levels = names(mapping_tcle_concordo), labels = mapping_tcle_concordo)

mapping_tcle_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$tcle_complete.factor = factor(data$tcle_complete, levels = names(mapping_tcle_complete), labels = mapping_tcle_complete)

mapping_t1_preavl_nome = c(
	"1" = "Carla Chagas",
	"2" = "Daniela Prado",
	"3" = "Daniele Nahomi",
	"4" = "Débora Neves",
	"5" = "Gabriela Costa",
	"6" = "Gabriela Souza",
	"7" = "Júlia Catanoce",
	"8" = "Julia Nicolella",
	"9" = "Magdala Casini",
	"10" = "Sylvia Nascimento",
	"11" = "Tatiane Brito",
	"12" = "Vivian Rank",
	"13" = "Vera Videira"
)
data$t1_preavl_nome.factor = factor(data$t1_preavl_nome, levels = names(mapping_t1_preavl_nome), labels = mapping_t1_preavl_nome)

mapping_formulrio_pravaliao_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_pravaliao_complete.factor = factor(data$formulrio_pravaliao_complete, levels = names(mapping_formulrio_pravaliao_complete), labels = mapping_formulrio_pravaliao_complete)

mapping_t1_tcle = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_tcle.factor = factor(data$t1_tcle, levels = names(mapping_t1_tcle), labels = mapping_t1_tcle)

mapping_t1_avaliadora = c(
	"1" = "Carla Chagas",
	"2" = "Daniela Prado",
	"3" = "Daniele Nahomi",
	"4" = "Débora Neves",
	"5" = "Gabriela Costa",
	"6" = "Gabriela Souza",
	"7" = "Júlia Catanoce",
	"8" = "Julia Nicolella",
	"9" = "Magdala Casini",
	"10" = "Sylvia Nascimento",
	"11" = "Tatiane Brito",
	"12" = "Vivian Rank",
	"13" = "Vera Videira"
)
data$t1_avaliadora.factor = factor(data$t1_avaliadora, levels = names(mapping_t1_avaliadora), labels = mapping_t1_avaliadora)

mapping_t1_cor = c(
	"1" = "Branca",
	"2" = "Preta",
	"3" = "Parda",
	"4" = "Amarela",
	"5" = "Indígena"
)
data$t1_cor.factor = factor(data$t1_cor, levels = names(mapping_t1_cor), labels = mapping_t1_cor)

mapping_t1_escola = c(
	"0" = "Fundamental I incompleto",
	"1" = "Fundamental I completo/Fundamental II incompleto",
	"2" = "Fundamental II completo/Médio incompleto",
	"3" = "Médio completo",
	"4" = "Superior incompleto ou cursando",
	"5" = "Superior Completo",
	"6" = "Cursando pós-graduação (mestrado/doutorado)",
	"7" = "Pós-graduada"
)
data$t1_escola.factor = factor(data$t1_escola, levels = names(mapping_t1_escola), labels = mapping_t1_escola)

mapping_t1_trabalho = c(
	"1" = "Emprego fixo, com carteira de trabalho assinada",
	"2" = "Emprego fixo, sem carteira assinada",
	"3" = "Emprego temporário, com carteira de trabalho assinada",
	"4" = "Emprego sem contrato, sem carteira assinada",
	"5" = "Desempregada",
	"6" = "Autônoma",
	"7" = "Trabalhador doméstico ou familiar",
	"8" = "Não trabalha",
	"9" = "Aposentada"
)
data$t1_trabalho.factor = factor(data$t1_trabalho, levels = names(mapping_t1_trabalho), labels = mapping_t1_trabalho)

mapping_t1_estudando = c(
	"0" = "Não",
	"1" = "Sim, ensino fundamental",
	"2" = "Sim, ensino médio ou supletivo",
	"3" = "Sim, curso profissionalizante",
	"4" = "Sim, ensino superior (graduação)",
	"5" = "Sim, ensino superior (pós-graduação)"
)
data$t1_estudando.factor = factor(data$t1_estudando, levels = names(mapping_t1_estudando), labels = mapping_t1_estudando)

mapping_t1_ecivil = c(
	"1" = "Casada ou vive com companheiro",
	"2" = "Viúva",
	"3" = "Divorciada ou Separada",
	"4" = "Solteira",
	"5" = "Solteira com parceiro fixo (namorando)"
)
data$t1_ecivil.factor = factor(data$t1_ecivil, levels = names(mapping_t1_ecivil), labels = mapping_t1_ecivil)

mapping_t1_pai_r = c(
	"1" = "Relacionamento estável (ele é marido ou companheiro e moram juntos)",
	"2" = "Relacionamento estável (ele é namorado ou companheiro, mas não moram juntos)",
	"3" = "Não tem relacionamento estável com o pai do filho(a)",
	"4" = "Não sabe quem é o pai do filho(a)"
)
data$t1_pai_r.factor = factor(data$t1_pai_r, levels = names(mapping_t1_pai_r), labels = mapping_t1_pai_r)

mapping_t1_pai_temp = c(
	"0" = "Não se envolveu",
	"1" = "Envolveu-se um pouco",
	"2" = "Envolveu-se muito"
)
data$t1_pai_temp.factor = factor(data$t1_pai_temp, levels = names(mapping_t1_pai_temp), labels = mapping_t1_pai_temp)

mapping_linha_base_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$linha_base_t1_complete.factor = factor(data$linha_base_t1_complete, levels = names(mapping_linha_base_t1_complete), labels = mapping_linha_base_t1_complete)

mapping_t1_prenatal2 = c(
	"0" = "Público",
	"1" = "Privado",
	"2" = "Ambos"
)
data$t1_prenatal2.factor = factor(data$t1_prenatal2, levels = names(mapping_t1_prenatal2), labels = mapping_t1_prenatal2)

mapping_t1_prenatal3 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal3.factor = factor(data$t1_prenatal3, levels = names(mapping_t1_prenatal3), labels = mapping_t1_prenatal3)

mapping_t1_prenatal5 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal5.factor = factor(data$t1_prenatal5, levels = names(mapping_t1_prenatal5), labels = mapping_t1_prenatal5)

mapping_t1_prenatal6 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal6.factor = factor(data$t1_prenatal6, levels = names(mapping_t1_prenatal6), labels = mapping_t1_prenatal6)

mapping_t1_prenatal7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal7.factor = factor(data$t1_prenatal7, levels = names(mapping_t1_prenatal7), labels = mapping_t1_prenatal7)

mapping_t1_prenatal8 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal8.factor = factor(data$t1_prenatal8, levels = names(mapping_t1_prenatal8), labels = mapping_t1_prenatal8)

mapping_t1_prenatal9 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal9.factor = factor(data$t1_prenatal9, levels = names(mapping_t1_prenatal9), labels = mapping_t1_prenatal9)

mapping_t1_prenatal10 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal10.factor = factor(data$t1_prenatal10, levels = names(mapping_t1_prenatal10), labels = mapping_t1_prenatal10)

mapping_t1_prenatal11 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_prenatal11.factor = factor(data$t1_prenatal11, levels = names(mapping_t1_prenatal11), labels = mapping_t1_prenatal11)

mapping_prnatal_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$prnatal_t1_complete.factor = factor(data$prnatal_t1_complete, levels = names(mapping_prnatal_t1_complete), labels = mapping_prnatal_t1_complete)

mapping_t1_sexo = c(
	"1" = "Masculino",
	"2" = "Feminino"
)
data$t1_sexo.factor = factor(data$t1_sexo, levels = names(mapping_t1_sexo), labels = mapping_t1_sexo)

mapping_t1_local = c(
	"1" = "Hospital/clínica",
	"2" = "Domicilio",
	"3" = "Casa de parto",
	"4" = "Outro"
)
data$t1_local.factor = factor(data$t1_local, levels = names(mapping_t1_local), labels = mapping_t1_local)

mapping_t1_parto = c(
	"1" = "Normal",
	"2" = "Cesárea"
)
data$t1_parto.factor = factor(data$t1_parto, levels = names(mapping_t1_parto), labels = mapping_t1_parto)

mapping_t1_cesarea = c(
	"1" = "Sofrimento fetal",
	"2" = "Desproporção feto-pélvica",
	"3" = "Distocia de apresentação",
	"4" = "Hemorragia materna",
	"5" = "Parada de progressão",
	"6" = "Eclâmpsia, pré-eclâmpsia",
	"7" = "Pós-maturidade",
	"8" = "Morte fetal",
	"9" = "Diabetes materna",
	"10" = "Parto(s) prévio(s) foi/foram cesárea",
	"11" = "Mãe pediu",
	"12" = "Médico quis",
	"13" = "Cesárea programada",
	"14" = "Outro"
)
data$t1_cesarea.factor = factor(data$t1_cesarea, levels = names(mapping_t1_cesarea), labels = mapping_t1_cesarea)

mapping_t1_forceps = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_forceps.factor = factor(data$t1_forceps, levels = names(mapping_t1_forceps), labels = mapping_t1_forceps)

mapping_t1_episiotomia = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_episiotomia.factor = factor(data$t1_episiotomia, levels = names(mapping_t1_episiotomia), labels = mapping_t1_episiotomia)

mapping_t1_analgesia = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_analgesia.factor = factor(data$t1_analgesia, levels = names(mapping_t1_analgesia), labels = mapping_t1_analgesia)

mapping_t1_filhos = c(
	"1" = "1",
	"2" = "2",
	"3" = "3 ou mais"
)
data$t1_filhos.factor = factor(data$t1_filhos, levels = names(mapping_t1_filhos), labels = mapping_t1_filhos)

mapping_t1_alta = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_alta.factor = factor(data$t1_alta, levels = names(mapping_t1_alta), labels = mapping_t1_alta)

mapping_t1_intercorrencia = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_intercorrencia.factor = factor(data$t1_intercorrencia, levels = names(mapping_t1_intercorrencia), labels = mapping_t1_intercorrencia)

mapping_t1_cpap = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_cpap.factor = factor(data$t1_cpap, levels = names(mapping_t1_cpap), labels = mapping_t1_cpap)

mapping_t1_incubadora = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_incubadora.factor = factor(data$t1_incubadora, levels = names(mapping_t1_incubadora), labels = mapping_t1_incubadora)

mapping_dados_de_nascimento_e_antropometricos_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$dados_de_nascimento_e_antropometricos_t1_complete.factor = factor(data$dados_de_nascimento_e_antropometricos_t1_complete, levels = names(mapping_dados_de_nascimento_e_antropometricos_t1_complete), labels = mapping_dados_de_nascimento_e_antropometricos_t1_complete)

mapping_t1_vacinas = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_vacinas.factor = factor(data$t1_vacinas, levels = names(mapping_t1_vacinas), labels = mapping_t1_vacinas)

mapping_t1_amament1 = c(
	"0" = "Nunca mamou",
	"1" = "Não atualmente, mas mamava",
	"2" = "Sim"
)
data$t1_amament1.factor = factor(data$t1_amament1, levels = names(mapping_t1_amament1), labels = mapping_t1_amament1)

mapping_t1_amament1a = c(
	"0" = "Menos de 1 mês",
	"1" = "1",
	"2" = "2",
	"3" = "3",
	"4" = "4",
	"5" = "5",
	"6" = "6 ou mais",
	"99" = "Nunca mamou exclusivamente"
)
data$t1_amament1a.factor = factor(data$t1_amament1a, levels = names(mapping_t1_amament1a), labels = mapping_t1_amament1a)

mapping_t1_doenca_bebe1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_doenca_bebe1.factor = factor(data$t1_doenca_bebe1, levels = names(mapping_t1_doenca_bebe1), labels = mapping_t1_doenca_bebe1)

mapping_t1_hospitalizacao1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_hospitalizacao1.factor = factor(data$t1_hospitalizacao1, levels = names(mapping_t1_hospitalizacao1), labels = mapping_t1_hospitalizacao1)

mapping_primeiro_ano_de_vida_do_bebe_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$primeiro_ano_de_vida_do_bebe_t1_complete.factor = factor(data$primeiro_ano_de_vida_do_bebe_t1_complete, levels = names(mapping_primeiro_ano_de_vida_do_bebe_t1_complete), labels = mapping_primeiro_ano_de_vida_do_bebe_t1_complete)

mapping_t1_sm1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_sm1.factor = factor(data$t1_sm1, levels = names(mapping_t1_sm1), labels = mapping_t1_sm1)

mapping_t1_sm3 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_sm3.factor = factor(data$t1_sm3, levels = names(mapping_t1_sm3), labels = mapping_t1_sm3)

mapping_t1_sm3c = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_sm3c.factor = factor(data$t1_sm3c, levels = names(mapping_t1_sm3c), labels = mapping_t1_sm3c)

mapping_t1_sm7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_sm7.factor = factor(data$t1_sm7, levels = names(mapping_t1_sm7), labels = mapping_t1_sm7)

mapping_tratamento_saude_mental_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$tratamento_saude_mental_t1_complete.factor = factor(data$tratamento_saude_mental_t1_complete, levels = names(mapping_tratamento_saude_mental_t1_complete), labels = mapping_tratamento_saude_mental_t1_complete)

mapping_t1_app2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_app2.factor = factor(data$t1_app2, levels = names(mapping_t1_app2), labels = mapping_t1_app2)

mapping_t1_app3 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_app3.factor = factor(data$t1_app3, levels = names(mapping_t1_app3), labels = mapping_t1_app3)

mapping_uso_de_smartphones_e_apps_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$uso_de_smartphones_e_apps_t1_complete.factor = factor(data$uso_de_smartphones_e_apps_t1_complete, levels = names(mapping_uso_de_smartphones_e_apps_t1_complete), labels = mapping_uso_de_smartphones_e_apps_t1_complete)

mapping_t3_avaliador = c(
	"1" = "Carla Chagas",
	"2" = "Daniela Prado",
	"3" = "Daniele Nahomi",
	"4" = "Débora Neves",
	"5" = "Gabriela Costa",
	"6" = "Gabriela Souza",
	"7" = "Júlia Catanoce",
	"8" = "Julia Nicolella",
	"9" = "Magdala Casini",
	"10" = "Sylvia Nascimento",
	"11" = "Tatiane Brito",
	"12" = "Vivian Rank",
	"13" = "Vera Videira"
)
data$t3_avaliador.factor = factor(data$t3_avaliador, levels = names(mapping_t3_avaliador), labels = mapping_t3_avaliador)

mapping_t3_sm1 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t3_sm1.factor = factor(data$t3_sm1, levels = names(mapping_t3_sm1), labels = mapping_t3_sm1)

mapping_t3_sm2 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t3_sm2.factor = factor(data$t3_sm2, levels = names(mapping_t3_sm2), labels = mapping_t3_sm2)

mapping_t3_sm3 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t3_sm3.factor = factor(data$t3_sm3, levels = names(mapping_t3_sm3), labels = mapping_t3_sm3)

mapping_t3_sm3x = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t3_sm3x.factor = factor(data$t3_sm3x, levels = names(mapping_t3_sm3x), labels = mapping_t3_sm3x)

mapping_t3_sm3c = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t3_sm3c.factor = factor(data$t3_sm3c, levels = names(mapping_t3_sm3c), labels = mapping_t3_sm3c)

mapping_tratamento_saude_mental_t3_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$tratamento_saude_mental_t3_complete.factor = factor(data$tratamento_saude_mental_t3_complete, levels = names(mapping_tratamento_saude_mental_t3_complete), labels = mapping_tratamento_saude_mental_t3_complete)

mapping_t4_avaliador = c(
	"1" = "Ana Polimeno",
	"2" = "Bruna Anjos",
	"3" = "Camila Deak",
	"4" = "Caroline Andrade",
	"5" = "Giovanna Mazzuli",
	"6" = "Julia Nicolella",
	"7" = "Leticia Benicio",
	"8" = "Maysa Dias",
	"9" = "Monica Fonseca",
	"10" = "Nadia Slwczuk",
	"11" = "Amanda Dutra",
	"12" = "Karen Duran Moreira",
	"13" = "Ana Carolina Peres Simas",
	"14" = "Stephanie Marão Perassollo"
)
data$t4_avaliador.factor = factor(data$t4_avaliador, levels = names(mapping_t4_avaliador), labels = mapping_t4_avaliador)

mapping_t4_sm1 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t4_sm1.factor = factor(data$t4_sm1, levels = names(mapping_t4_sm1), labels = mapping_t4_sm1)

mapping_t4_sm2 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t4_sm2.factor = factor(data$t4_sm2, levels = names(mapping_t4_sm2), labels = mapping_t4_sm2)

mapping_t4_sm3 = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t4_sm3.factor = factor(data$t4_sm3, levels = names(mapping_t4_sm3), labels = mapping_t4_sm3)

mapping_t4_sm3x = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t4_sm3x.factor = factor(data$t4_sm3x, levels = names(mapping_t4_sm3x), labels = mapping_t4_sm3x)

mapping_t4_sm3c = c(
	"0" = "Nao",
	"1" = "Sim"
)
data$t4_sm3c.factor = factor(data$t4_sm3c, levels = names(mapping_t4_sm3c), labels = mapping_t4_sm3c)

mapping_tratamento_saude_mental_t4_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$tratamento_saude_mental_t4_complete.factor = factor(data$tratamento_saude_mental_t4_complete, levels = names(mapping_tratamento_saude_mental_t4_complete), labels = mapping_tratamento_saude_mental_t4_complete)

mapping_t1_qidssr16_1 = c(
	"0" = "Nunca levo mais do que 30 minutos para pegar no sono.",
	"1" = "Levo pelo menos 30 minutos para pegar no sono, menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Levo pelo menos 30 minutos para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Levo mais de uma hora para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t1_qidssr16_1.factor = factor(data$t1_qidssr16_1, levels = names(mapping_t1_qidssr16_1), labels = mapping_t1_qidssr16_1)

mapping_t1_qidssr16_2 = c(
	"0" = "Não acordo durante a noite.",
	"1" = "Tenho um sono leve e agitado, acordando por períodos curtos em cada noite.",
	"2" = "Acordo pelo menos uma vez por noite, mas volto a dormir com facilidade.",
	"3" = "Acordo mais do que uma vez por noite e fico acordado(a) por 20 minutos ou mais, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t1_qidssr16_2.factor = factor(data$t1_qidssr16_2, levels = names(mapping_t1_qidssr16_2), labels = mapping_t1_qidssr16_2)

mapping_t1_qidssr16_3 = c(
	"0" = "Na maioria das vezes, acordo até 30 minutos antes do que preciso para levantar.",
	"1" = "Mais da metade das vezes (4 dias ou mais nos últimos 7 dias), acordo mais de 30 minutos antes do que preciso para levantar.",
	"2" = "Quase sempre acordo pelo menos em torno de uma hora antes da hora que eu preciso, mas acabo voltando a dormir.",
	"3" = "Acordo pelo menos uma hora antes do que preciso e não consigo voltar a dormir."
)
data$t1_qidssr16_3.factor = factor(data$t1_qidssr16_3, levels = names(mapping_t1_qidssr16_3), labels = mapping_t1_qidssr16_3)

mapping_t1_qidssr16_4 = c(
	"0" = "Durmo até 7-8 horas por noite, sem cochilos durante o dia.",
	"1" = "Durmo até 10 horas num período de 24 horas, incluindo cochilos.",
	"2" = "Durmo até 12 horas num período de 24 horas, incluindo cochilos.",
	"3" = "Durmo mais do que 12 horas num período de 24 horas, incluindo cochilos."
)
data$t1_qidssr16_4.factor = factor(data$t1_qidssr16_4, levels = names(mapping_t1_qidssr16_4), labels = mapping_t1_qidssr16_4)

mapping_t1_qidssr16_5 = c(
	"0" = "Não me sinto triste.",
	"1" = "Sinto-me triste menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Sinto-me triste mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Sinto-me triste quase o tempo todo."
)
data$t1_qidssr16_5.factor = factor(data$t1_qidssr16_5, levels = names(mapping_t1_qidssr16_5), labels = mapping_t1_qidssr16_5)

mapping_t1_qidssr16_txt2 = c(
	"0" = "Meu apetite habitual não mudou.",
	"1" = "Meu apetite diminuiu.",
	"2" = "Meu apetite aumentou."
)
data$t1_qidssr16_txt2.factor = factor(data$t1_qidssr16_txt2, levels = names(mapping_t1_qidssr16_txt2), labels = mapping_t1_qidssr16_txt2)

mapping_t1_qidssr16_6 = c(
	"1" = "Como com menor frequência ou menores quantidades de comida que o habitual.",
	"2" = "Como muito menos que o habitual e só com um esforço pessoal.",
	"3" = "Como raramente num período de 24 horas e só com um esforço pessoal extremo ou quando outros me convencem a comer."
)
data$t1_qidssr16_6.factor = factor(data$t1_qidssr16_6, levels = names(mapping_t1_qidssr16_6), labels = mapping_t1_qidssr16_6)

mapping_t1_qidssr16_7 = c(
	"1" = "Sinto necessidade de comer mais frequentemente do que o habitual.",
	"2" = "Regularmente, como com mais frequência e/ou em maiores quantidades do que o habitual.",
	"3" = "Sinto-me compelido a comer demais tanto nas refeições como entre elas."
)
data$t1_qidssr16_7.factor = factor(data$t1_qidssr16_7, levels = names(mapping_t1_qidssr16_7), labels = mapping_t1_qidssr16_7)

mapping_t1_qidssr16_txt3 = c(
	"0" = "Não tive qualquer mudança no meu peso.",
	"1" = "Perdi peso.",
	"2" = "Ganhei peso."
)
data$t1_qidssr16_txt3.factor = factor(data$t1_qidssr16_txt3, levels = names(mapping_t1_qidssr16_txt3), labels = mapping_t1_qidssr16_txt3)

mapping_t1_qidssr16_8 = c(
	"1" = "Sinto-me como se tivesse tido uma pequena perda de peso.",
	"2" = "Perdi 1 quilo ou mais.",
	"3" = "Perdi 2,5 quilos ou mais."
)
data$t1_qidssr16_8.factor = factor(data$t1_qidssr16_8, levels = names(mapping_t1_qidssr16_8), labels = mapping_t1_qidssr16_8)

mapping_t1_qidssr16_9 = c(
	"1" = "Sinto-me como se tivesse tido um pequeno aumento de peso.",
	"2" = "Engordei 1 quilo ou mais.",
	"3" = "Engordei 2,5 quilos ou mais"
)
data$t1_qidssr16_9.factor = factor(data$t1_qidssr16_9, levels = names(mapping_t1_qidssr16_9), labels = mapping_t1_qidssr16_9)

mapping_t1_qidssr16_10 = c(
	"0" = "Não houve mudança na minha capacidade habitual de me concentrar ou de tomar decisões.",
	"1" = "Ocasionalmente, me sinto indeciso(a) ou acho que minha atenção flutua.",
	"2" = "Na maior parte do tempo, me esforço para prestar atenção ou para tomar decisões.",
	"3" = "Não consigo me concentrar o suficiente para ler ou não consigo tomar nem mesmo decisões pequenas."
)
data$t1_qidssr16_10.factor = factor(data$t1_qidssr16_10, levels = names(mapping_t1_qidssr16_10), labels = mapping_t1_qidssr16_10)

mapping_t1_qidssr16_11 = c(
	"0" = "Considero-me tão valioso(a) e merecedor(a) como os outros.",
	"1" = "Recrimino-me mais do que o habitual.",
	"2" = "Acredito muito que causo problemas para os outros.",
	"3" = "Penso quase constantemente sobre pequenos e grandes defeitos em mim mesmo(a)."
)
data$t1_qidssr16_11.factor = factor(data$t1_qidssr16_11, levels = names(mapping_t1_qidssr16_11), labels = mapping_t1_qidssr16_11)

mapping_t1_qidssr16_12 = c(
	"0" = "Não penso em suicídio ou morte.",
	"1" = "Sinto que a vida é vazia e me pergunto se vale a pena viver.",
	"2" = "Penso em suicídio ou morte várias vezes por semana durante vários minutos.",
	"3" = "Penso em suicídio ou morte várias vezes por dia com algum detalhe, ou fiz planos específicos de suicídio, ou realmente tentei me matar."
)
data$t1_qidssr16_12.factor = factor(data$t1_qidssr16_12, levels = names(mapping_t1_qidssr16_12), labels = mapping_t1_qidssr16_12)

mapping_t1_qidssr16_13 = c(
	"0" = "Não houve mudanças do habitual quanto ao interesse que tenho em outras pessoas e atividades.",
	"1" = "Noto que estou menos interessado(a) em pessoas ou em atividades.",
	"2" = "Acho que tenho interesse em apenas uma ou duas das atividades a que me dedicava anteriormente.",
	"3" = "Não tenho praticamente interesse nenhum nas atividades a que me dedicava anteriormente."
)
data$t1_qidssr16_13.factor = factor(data$t1_qidssr16_13, levels = names(mapping_t1_qidssr16_13), labels = mapping_t1_qidssr16_13)

mapping_t1_qidssr16_14 = c(
	"0" = "Não há mudanças no meu nível habitual de energia.",
	"1" = "Fico cansado(a) mais facilmente do que o habitual.",
	"2" = "Tenho que fazer um grande esforço para começar ou acabar minhas atividades diárias habituais (por exemplo, fazer compras, lição de casa, cozinhar ou trabalhar).",
	"3" = "Eu não consigo realmente desempenhar a maioria das minhas atividades diárias, porque simplesmente não tenho energia."
)
data$t1_qidssr16_14.factor = factor(data$t1_qidssr16_14, levels = names(mapping_t1_qidssr16_14), labels = mapping_t1_qidssr16_14)

mapping_t1_qidssr16_15 = c(
	"0" = "Penso, falo e me movimento na minha velocidade habitual.",
	"1" = "Acho que o meu pensamento está mais lento ou a minha voz parece sem brilho ou monótona.",
	"2" = "Levo vários segundos para responder à maioria das perguntas e tenho certeza que o meu pensamento está lento.",
	"3" = "Sinto-me frequentemente incapaz de responder a perguntas sem um esforço extremo."
)
data$t1_qidssr16_15.factor = factor(data$t1_qidssr16_15, levels = names(mapping_t1_qidssr16_15), labels = mapping_t1_qidssr16_15)

mapping_t1_qidssr16_16 = c(
	"0" = "Não me sinto agitado(a).",
	"1" = "Fico frequentemente irrequieto(a), torcendo as mãos ou precisando trocar a posição em que estou sentado(a).",
	"2" = "Tenho impulsos de me movimentar e estou bastante agitado(a).",
	"3" = "Há ocasiões em que fico incapaz de permanecer sentado(a) e preciso andar de um lado para o outro."
)
data$t1_qidssr16_16.factor = factor(data$t1_qidssr16_16, levels = names(mapping_t1_qidssr16_16), labels = mapping_t1_qidssr16_16)

mapping_qidssr16_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$qidssr16_complete.factor = factor(data$qidssr16_complete, levels = names(mapping_qidssr16_complete), labels = mapping_qidssr16_complete)

mapping_t1_qidsc16_1 = c(
	"0" = "Nunca leva mais do que 30 minutos para pegar no sono.",
	"1" = "Leva pelo menos 30 minutos para pegar no sono, menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Leva pelo menos 30 minutos para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Leva mais de uma hora para pegar no sono, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t1_qidsc16_1.factor = factor(data$t1_qidsc16_1, levels = names(mapping_t1_qidsc16_1), labels = mapping_t1_qidsc16_1)

mapping_t1_qidsc16_2 = c(
	"0" = "Não acorda durante a noite.",
	"1" = "Tem um sono leve e agitado, acordando por períodos curtos em cada noite.",
	"2" = "Acorda pelo menos uma vez por noite, mas volta a dormir com facilidade.",
	"3" = "Acorda mais do que uma vez por noite e fica acordado(a) por 20 minutos ou mais, mais da metade das vezes (4 dias ou mais nos últimos 7 dias)."
)
data$t1_qidsc16_2.factor = factor(data$t1_qidsc16_2, levels = names(mapping_t1_qidsc16_2), labels = mapping_t1_qidsc16_2)

mapping_t1_qidsc16_3 = c(
	"0" = "Na maioria das vezes, acorda até 30 minutos antes do que precisa para levantar.",
	"1" = "Mais da metade das vezes (4 dias ou mais nos últimos 7 dias), acorda mais de 30 minutos antes do que precisa para levantar.",
	"2" = "Quase sempre acorda pelo menos em torno de uma hora antes da hora que precisa, mas acaba voltando a dormir.",
	"3" = "Acorda pelo menos uma hora antes do que precisa e não consegue voltar a dormir."
)
data$t1_qidsc16_3.factor = factor(data$t1_qidsc16_3, levels = names(mapping_t1_qidsc16_3), labels = mapping_t1_qidsc16_3)

mapping_t1_qidsc16_4 = c(
	"0" = "Dorme até 7-8 horas por noite, sem cochilos durante o dia.",
	"1" = "Dorme até 10 horas num período de 24 horas, incluindo cochilos.",
	"2" = "Dorme até 12 horas num período de 24 horas, incluindo cochilos.",
	"3" = "Dorme mais do que 12 horas num período de 24 horas, incluindo cochilos."
)
data$t1_qidsc16_4.factor = factor(data$t1_qidsc16_4, levels = names(mapping_t1_qidsc16_4), labels = mapping_t1_qidsc16_4)

mapping_t1_qidsc16_5 = c(
	"0" = "Não se sente triste.",
	"1" = "Sente-se triste menos da metade das vezes (3 dias ou menos nos últimos 7 dias).",
	"2" = "Sente-se triste mais da metade das vezes (4 dias ou mais nos últimos 7 dias).",
	"3" = "Sente-se triste quase o tempo todo."
)
data$t1_qidsc16_5.factor = factor(data$t1_qidsc16_5, levels = names(mapping_t1_qidsc16_5), labels = mapping_t1_qidsc16_5)

mapping_t1_qidsc16_txt2 = c(
	"0" = "O apetite habitual não mudou.",
	"1" = "O apetite diminuiu.",
	"2" = "O apetite aumentou."
)
data$t1_qidsc16_txt2.factor = factor(data$t1_qidsc16_txt2, levels = names(mapping_t1_qidsc16_txt2), labels = mapping_t1_qidsc16_txt2)

mapping_t1_qidsc16_6 = c(
	"0" = "Apetite habitual não mudou.",
	"1" = "Come com menor frequência ou menores quantidades de comida que o habitual.",
	"2" = "Come muito menos que o habitual e só com um esforço pessoal.",
	"3" = "Come raramente num período de 24 horas e só com um esforço pessoal extremo ou quando outros a convencem a comer."
)
data$t1_qidsc16_6.factor = factor(data$t1_qidsc16_6, levels = names(mapping_t1_qidsc16_6), labels = mapping_t1_qidsc16_6)

mapping_t1_qidsc16_7 = c(
	"0" = "Apetite habitual não mudou.",
	"1" = "Sente necessidade de comer mais frequentemente do que o habitual.",
	"2" = "Regularmente, come com mais frequência e/ou em maiores quantidades do que o habitual.",
	"3" = "Sente-se compelida a comer demais tanto nas refeições como entre elas."
)
data$t1_qidsc16_7.factor = factor(data$t1_qidsc16_7, levels = names(mapping_t1_qidsc16_7), labels = mapping_t1_qidsc16_7)

mapping_t1_qidsc16_txt3 = c(
	"0" = "Não teve qualquer mudança no meu peso.",
	"1" = "Perdeu peso.",
	"2" = "Ganhou peso."
)
data$t1_qidsc16_txt3.factor = factor(data$t1_qidsc16_txt3, levels = names(mapping_t1_qidsc16_txt3), labels = mapping_t1_qidsc16_txt3)

mapping_t1_qidsc16_8 = c(
	"0" = "Não teve qualquer mudança no peso.",
	"1" = "Sente como se tivesse tido uma pequena perda de peso.",
	"2" = "Perdeu 1 quilo ou mais.",
	"3" = "Perdeu 2,5 quilos ou mais."
)
data$t1_qidsc16_8.factor = factor(data$t1_qidsc16_8, levels = names(mapping_t1_qidsc16_8), labels = mapping_t1_qidsc16_8)

mapping_t1_qidsc16_9 = c(
	"0" = "Não teve qualquer mudança no peso.",
	"1" = "Sente como se tivesse tido um pequeno aumento de peso.",
	"2" = "Engordou 1 quilo ou mais.",
	"3" = "Engordou 2,5 quilos ou mais"
)
data$t1_qidsc16_9.factor = factor(data$t1_qidsc16_9, levels = names(mapping_t1_qidsc16_9), labels = mapping_t1_qidsc16_9)

mapping_t1_qidsc16_10 = c(
	"0" = "Não houve mudança na capacidade habitual de se concentrar ou de tomar decisões.",
	"1" = "Ocasionalmente se sente indeciso(a) ou acha que a atenção flutua.",
	"2" = "Na maior parte do tempo, se esforça para prestar atenção ou para tomar decisões.",
	"3" = "Não consegue se concentrar o suficiente para ler ou não consegue tomar nem mesmo decisões pequenas."
)
data$t1_qidsc16_10.factor = factor(data$t1_qidsc16_10, levels = names(mapping_t1_qidsc16_10), labels = mapping_t1_qidsc16_10)

mapping_t1_qidsc16_11 = c(
	"0" = "Considera-se tão valioso(a) e merecedor(a) como os outros.",
	"1" = "Recrimina-se mais do que o habitual.",
	"2" = "Acredita muito que causa problemas para os outros.",
	"3" = "Pensa quase constantemente sobre pequenos e grandes defeitos em si mesmo(a)."
)
data$t1_qidsc16_11.factor = factor(data$t1_qidsc16_11, levels = names(mapping_t1_qidsc16_11), labels = mapping_t1_qidsc16_11)

mapping_t1_qidsc16_12 = c(
	"0" = "Não pensa em suicídio ou morte.",
	"1" = "Sente que a vida é vazia e se pergunta se vale a pena viver.",
	"2" = "Pensa em suicídio ou morte várias vezes por semana durante vários minutos.",
	"3" = "Pensa em suicídio ou morte várias vezes por dia com algum detalhe, ou fez planos específicos de suicídio, ou realmente tentou se matar."
)
data$t1_qidsc16_12.factor = factor(data$t1_qidsc16_12, levels = names(mapping_t1_qidsc16_12), labels = mapping_t1_qidsc16_12)

mapping_t1_qidsc16_13 = c(
	"0" = "Não houve mudanças quanto ao interesse que tem em outras pessoas e atividades.",
	"1" = "Noto que está menos interessado(a) em pessoas ou em atividades.",
	"2" = "Acho que tem interesse em apenas uma ou duas das atividades a que se dedicava anteriormente.",
	"3" = "Não tem praticamente interesse nenhum nas atividades a que se dedicava anteriormente."
)
data$t1_qidsc16_13.factor = factor(data$t1_qidsc16_13, levels = names(mapping_t1_qidsc16_13), labels = mapping_t1_qidsc16_13)

mapping_t1_qidsc16_14 = c(
	"0" = "Não há mudanças no seu nível habitual de energia.",
	"1" = "Fica cansado(a) mais facilmente do que o habitual.",
	"2" = "Tem que fazer um grande esforço para começar ou acabar suas atividades diárias habituais (por exemplo, fazer compras, lição de casa, cozinhar ou trabalhar).",
	"3" = "Não consegue realmente desempenhar a maioria das suas atividades diárias, porque simplesmente não tem energia."
)
data$t1_qidsc16_14.factor = factor(data$t1_qidsc16_14, levels = names(mapping_t1_qidsc16_14), labels = mapping_t1_qidsc16_14)

mapping_t1_qidsc16_15 = c(
	"0" = "Pensa, fala e se movimenta na velocidade habitual.",
	"1" = "Nota que o pensamento está mais lento ou a voz parece sem brilho ou monótona.",
	"2" = "Leva vários segundos para responder à maioria das perguntas e tem certeza que o pensamento está lento.",
	"3" = "Sente-se frequentemente incapaz de responder a perguntas sem um esforço extremo."
)
data$t1_qidsc16_15.factor = factor(data$t1_qidsc16_15, levels = names(mapping_t1_qidsc16_15), labels = mapping_t1_qidsc16_15)

mapping_t1_qidsc16_16 = c(
	"0" = "Não se sente agitado(a).",
	"1" = "Fica frequentemente irrequieto(a), torcendo as mãos ou precisando trocar a posição em que está sentado(a).",
	"2" = "Tem impulsos de se movimentar e fica bastante agitado(a).",
	"3" = "Há ocasiões em que fica incapaz de permanecer sentado(a) e precisa andar de um lado para o outro"
)
data$t1_qidsc16_16.factor = factor(data$t1_qidsc16_16, levels = names(mapping_t1_qidsc16_16), labels = mapping_t1_qidsc16_16)

mapping_qidsc16_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$qidsc16_complete.factor = factor(data$qidsc16_complete, levels = names(mapping_qidsc16_complete), labels = mapping_qidsc16_complete)

mapping_t1_epds1 = c(
	"0" = "Como sempre fiz",
	"1" = "Não tanto quanto antes",
	"2" = "Sem dúvida, menos que antes",
	"3" = "De jeito nenhum"
)
data$t1_epds1.factor = factor(data$t1_epds1, levels = names(mapping_t1_epds1), labels = mapping_t1_epds1)

mapping_t1_epds2 = c(
	"0" = "Sim, como de costume",
	"1" = "Um pouco menos que de costume",
	"2" = "Muito menos que de costume",
	"3" = "Praticamente não"
)
data$t1_epds2.factor = factor(data$t1_epds2, levels = names(mapping_t1_epds2), labels = mapping_t1_epds2)

mapping_t1_epds3 = c(
	"3" = "Sim, muito frequentemente",
	"2" = "Sim, às vezes",
	"1" = "Raramente",
	"0" = "Não, de jeito nenhum"
)
data$t1_epds3.factor = factor(data$t1_epds3, levels = names(mapping_t1_epds3), labels = mapping_t1_epds3)

mapping_t1_epds4 = c(
	"3" = "Sim, bastante",
	"2" = "Sim, às vezes",
	"1" = "De vez em quando",
	"0" = "Não, de jeito nenhum"
)
data$t1_epds4.factor = factor(data$t1_epds4, levels = names(mapping_t1_epds4), labels = mapping_t1_epds4)

mapping_t1_epds5 = c(
	"3" = "Sim, bastante",
	"2" = "Sim, às vezes",
	"1" = "De vez em quando",
	"0" = "Não, de jeito nenhum"
)
data$t1_epds5.factor = factor(data$t1_epds5, levels = names(mapping_t1_epds5), labels = mapping_t1_epds5)

mapping_t1_epds6 = c(
	"3" = "Sim, na maioria das vezes eu não consigo lidar bem com eles",
	"2" = "Sim, algumas vezes não consigo lidar bem como antes",
	"1" = "Não, na maioria das vezes consigo lidar bem com eles",
	"0" = "Não, eu consigo lidar com eles tão bem quanto antes"
)
data$t1_epds6.factor = factor(data$t1_epds6, levels = names(mapping_t1_epds6), labels = mapping_t1_epds6)

mapping_t1_epds7 = c(
	"3" = "Sim, na maioria das vezes",
	"2" = "Sim, algumas vezes",
	"1" = "Raramente",
	"0" = "Não, nenhuma vez"
)
data$t1_epds7.factor = factor(data$t1_epds7, levels = names(mapping_t1_epds7), labels = mapping_t1_epds7)

mapping_t1_epds8 = c(
	"3" = "Sim, na maioria das vezes",
	"2" = "Sim, algumas vezes",
	"1" = "Raramente",
	"0" = "Não, nenhuma vez"
)
data$t1_epds8.factor = factor(data$t1_epds8, levels = names(mapping_t1_epds8), labels = mapping_t1_epds8)

mapping_t1_epds9 = c(
	"3" = "Sim, na maior parte do tempo",
	"2" = "Sim, muitas vezes",
	"1" = "Só de vez em quando",
	"0" = "Não, nunca"
)
data$t1_epds9.factor = factor(data$t1_epds9, levels = names(mapping_t1_epds9), labels = mapping_t1_epds9)

mapping_t1_epds10 = c(
	"3" = "Sim, muitas vezes",
	"2" = "Às vezes",
	"1" = "Raramente",
	"0" = "Nunca"
)
data$t1_epds10.factor = factor(data$t1_epds10, levels = names(mapping_t1_epds10), labels = mapping_t1_epds10)

mapping_escala_de_depresso_de_edimburgo_epds_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$escala_de_depresso_de_edimburgo_epds_t1_complete.factor = factor(data$escala_de_depresso_de_edimburgo_epds_t1_complete, levels = names(mapping_escala_de_depresso_de_edimburgo_epds_t1_complete), labels = mapping_escala_de_depresso_de_edimburgo_epds_t1_complete)

mapping_t1_gad1 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad1.factor = factor(data$t1_gad1, levels = names(mapping_t1_gad1), labels = mapping_t1_gad1)

mapping_t1_gad2 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad2.factor = factor(data$t1_gad2, levels = names(mapping_t1_gad2), labels = mapping_t1_gad2)

mapping_t1_gad3 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad3.factor = factor(data$t1_gad3, levels = names(mapping_t1_gad3), labels = mapping_t1_gad3)

mapping_t1_gad4 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad4.factor = factor(data$t1_gad4, levels = names(mapping_t1_gad4), labels = mapping_t1_gad4)

mapping_t1_gad5 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad5.factor = factor(data$t1_gad5, levels = names(mapping_t1_gad5), labels = mapping_t1_gad5)

mapping_t1_gad6 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad6.factor = factor(data$t1_gad6, levels = names(mapping_t1_gad6), labels = mapping_t1_gad6)

mapping_t1_gad7 = c(
	"0" = "Raramente",
	"1" = "Alguns dias",
	"2" = "Mais da metade dos dias",
	"3" = "Quase todos os dias"
)
data$t1_gad7.factor = factor(data$t1_gad7, levels = names(mapping_t1_gad7), labels = mapping_t1_gad7)

mapping_escala_de_ansiedade_generalizada_gad7_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$escala_de_ansiedade_generalizada_gad7_t1_complete.factor = factor(data$escala_de_ansiedade_generalizada_gad7_t1_complete, levels = names(mapping_escala_de_ansiedade_generalizada_gad7_t1_complete), labels = mapping_escala_de_ansiedade_generalizada_gad7_t1_complete)

mapping_t1_sds1 = c(
	"0" = "0 - De nenhuma forma",
	"1" = "1 - Suavemente",
	"2" = "2 - Suavemente",
	"3" = "3 - Suavemente",
	"4" = "4 - Moderadamente",
	"5" = "5 - Moderadamente",
	"6" = "6 - Moderadamente",
	"7" = "7 - Marcadamente",
	"8" = "8 - Marcadamente",
	"9" = "9 - Marcadamente",
	"10" = "10 - Extremamente"
)
data$t1_sds1.factor = factor(data$t1_sds1, levels = names(mapping_t1_sds1), labels = mapping_t1_sds1)

mapping_t1_sds2 = c(
	"0" = "0 - De nenhuma forma",
	"1" = "1 - Suavemente",
	"2" = "2 - Suavemente",
	"3" = "3 - Suavemente",
	"4" = "4 - Moderadamente",
	"5" = "5 - Moderadamente",
	"6" = "6 - Moderadamente",
	"7" = "7 - Marcadamente",
	"8" = "8 - Marcadamente",
	"9" = "9 - Marcadamente",
	"10" = "10 - Extremamente"
)
data$t1_sds2.factor = factor(data$t1_sds2, levels = names(mapping_t1_sds2), labels = mapping_t1_sds2)

mapping_t1_sds3 = c(
	"0" = "0 - De nenhuma forma",
	"1" = "1 - Suavemente",
	"2" = "2 - Suavemente",
	"3" = "3 - Suavemente",
	"4" = "4 - Moderadamente",
	"5" = "5 - Moderadamente",
	"6" = "6 - Moderadamente",
	"7" = "7 - Marcadamente",
	"8" = "8 - Marcadamente",
	"9" = "9 - Marcadamente",
	"10" = "10 - Extremamente"
)
data$t1_sds3.factor = factor(data$t1_sds3, levels = names(mapping_t1_sds3), labels = mapping_t1_sds3)

mapping_escala_de_incapacidade_de_sheehan_sds_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$escala_de_incapacidade_de_sheehan_sds_complete.factor = factor(data$escala_de_incapacidade_de_sheehan_sds_complete, levels = names(mapping_escala_de_incapacidade_de_sheehan_sds_complete), labels = mapping_escala_de_incapacidade_de_sheehan_sds_complete)

mapping_t1_psqi_2 = c(
	"0" = "< 15 minutos",
	"1" = "16-30 minutos",
	"2" = "31-60 minutos",
	"3" = ">60 minutos"
)
data$t1_psqi_2.factor = factor(data$t1_psqi_2, levels = names(mapping_t1_psqi_2), labels = mapping_t1_psqi_2)

mapping_t1_psqi_4 = c(
	"0" = "> 7 horas",
	"1" = "6-7 horas",
	"2" = "5-6 horas",
	"3" = "< 5 horas"
)
data$t1_psqi_4.factor = factor(data$t1_psqi_4, levels = names(mapping_t1_psqi_4), labels = mapping_t1_psqi_4)

mapping_t1_psqi_5a = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5a.factor = factor(data$t1_psqi_5a, levels = names(mapping_t1_psqi_5a), labels = mapping_t1_psqi_5a)

mapping_t1_psqi_5b = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5b.factor = factor(data$t1_psqi_5b, levels = names(mapping_t1_psqi_5b), labels = mapping_t1_psqi_5b)

mapping_t1_psqi_5c = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5c.factor = factor(data$t1_psqi_5c, levels = names(mapping_t1_psqi_5c), labels = mapping_t1_psqi_5c)

mapping_t1_psqi_5d = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5d.factor = factor(data$t1_psqi_5d, levels = names(mapping_t1_psqi_5d), labels = mapping_t1_psqi_5d)

mapping_t1_psqi_5e = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5e.factor = factor(data$t1_psqi_5e, levels = names(mapping_t1_psqi_5e), labels = mapping_t1_psqi_5e)

mapping_t1_psqi_5f = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5f.factor = factor(data$t1_psqi_5f, levels = names(mapping_t1_psqi_5f), labels = mapping_t1_psqi_5f)

mapping_t1_psqi_5g = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5g.factor = factor(data$t1_psqi_5g, levels = names(mapping_t1_psqi_5g), labels = mapping_t1_psqi_5g)

mapping_t1_psqi_5h = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5h.factor = factor(data$t1_psqi_5h, levels = names(mapping_t1_psqi_5h), labels = mapping_t1_psqi_5h)

mapping_t1_psqi_5i = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5i.factor = factor(data$t1_psqi_5i, levels = names(mapping_t1_psqi_5i), labels = mapping_t1_psqi_5i)

mapping_t1_psqi_5j2 = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_5j2.factor = factor(data$t1_psqi_5j2, levels = names(mapping_t1_psqi_5j2), labels = mapping_t1_psqi_5j2)

mapping_t1_psqi_6 = c(
	"0" = "Muito boa",
	"1" = "Boa",
	"2" = "Ruim",
	"3" = "Muito ruim"
)
data$t1_psqi_6.factor = factor(data$t1_psqi_6, levels = names(mapping_t1_psqi_6), labels = mapping_t1_psqi_6)

mapping_t1_psqi_7 = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_7.factor = factor(data$t1_psqi_7, levels = names(mapping_t1_psqi_7), labels = mapping_t1_psqi_7)

mapping_t1_psqi_8 = c(
	"0" = "Nenhuma no último mês",
	"1" = "Menos de 1 vez/semana",
	"2" = "1 ou 2 vezes/semana",
	"3" = "3 ou mais vezes/semana"
)
data$t1_psqi_8.factor = factor(data$t1_psqi_8, levels = names(mapping_t1_psqi_8), labels = mapping_t1_psqi_8)

mapping_t1_psqi_9 = c(
	"0" = "Nenhuma dificuldade",
	"1" = "Um problema leve",
	"2" = "Um problema razoável",
	"3" = "Um grande problema"
)
data$t1_psqi_9.factor = factor(data$t1_psqi_9, levels = names(mapping_t1_psqi_9), labels = mapping_t1_psqi_9)

mapping_pittsburgh_sleep_quality_index_psqi_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$pittsburgh_sleep_quality_index_psqi_complete.factor = factor(data$pittsburgh_sleep_quality_index_psqi_complete, levels = names(mapping_pittsburgh_sleep_quality_index_psqi_complete), labels = mapping_pittsburgh_sleep_quality_index_psqi_complete)

mapping_t1_psi56 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi56.factor = factor(data$t1_psi56, levels = names(mapping_t1_psi56), labels = mapping_t1_psi56)

mapping_t1_psi69 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi69.factor = factor(data$t1_psi69, levels = names(mapping_t1_psi69), labels = mapping_t1_psi69)

mapping_t1_psi70 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi70.factor = factor(data$t1_psi70, levels = names(mapping_t1_psi70), labels = mapping_t1_psi70)

mapping_t1_psi72 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi72.factor = factor(data$t1_psi72, levels = names(mapping_t1_psi72), labels = mapping_t1_psi72)

mapping_t1_psi73 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi73.factor = factor(data$t1_psi73, levels = names(mapping_t1_psi73), labels = mapping_t1_psi73)

mapping_t1_psi76 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi76.factor = factor(data$t1_psi76, levels = names(mapping_t1_psi76), labels = mapping_t1_psi76)

mapping_t1_psi80 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi80.factor = factor(data$t1_psi80, levels = names(mapping_t1_psi80), labels = mapping_t1_psi80)

mapping_t1_psi85 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi85.factor = factor(data$t1_psi85, levels = names(mapping_t1_psi85), labels = mapping_t1_psi85)

mapping_t1_psi91 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi91.factor = factor(data$t1_psi91, levels = names(mapping_t1_psi91), labels = mapping_t1_psi91)

mapping_t1_psi92 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi92.factor = factor(data$t1_psi92, levels = names(mapping_t1_psi92), labels = mapping_t1_psi92)

mapping_t1_psi93 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi93.factor = factor(data$t1_psi93, levels = names(mapping_t1_psi93), labels = mapping_t1_psi93)

mapping_t1_psi100 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi100.factor = factor(data$t1_psi100, levels = names(mapping_t1_psi100), labels = mapping_t1_psi100)

mapping_t1_psi10 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi10.factor = factor(data$t1_psi10, levels = names(mapping_t1_psi10), labels = mapping_t1_psi10)

mapping_t1_psi12 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi12.factor = factor(data$t1_psi12, levels = names(mapping_t1_psi12), labels = mapping_t1_psi12)

mapping_t1_psi13 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi13.factor = factor(data$t1_psi13, levels = names(mapping_t1_psi13), labels = mapping_t1_psi13)

mapping_t1_psi14 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi14.factor = factor(data$t1_psi14, levels = names(mapping_t1_psi14), labels = mapping_t1_psi14)

mapping_t1_psi18 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi18.factor = factor(data$t1_psi18, levels = names(mapping_t1_psi18), labels = mapping_t1_psi18)

mapping_t1_psi23 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi23.factor = factor(data$t1_psi23, levels = names(mapping_t1_psi23), labels = mapping_t1_psi23)

mapping_t1_psi24 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi24.factor = factor(data$t1_psi24, levels = names(mapping_t1_psi24), labels = mapping_t1_psi24)

mapping_t1_psi26 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi26.factor = factor(data$t1_psi26, levels = names(mapping_t1_psi26), labels = mapping_t1_psi26)

mapping_t1_psi38 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi38.factor = factor(data$t1_psi38, levels = names(mapping_t1_psi38), labels = mapping_t1_psi38)

mapping_t1_psi58 = c(
	"1" = "Uma mãe muito boa",
	"2" = "Uma mãe melhor do que a média",
	"3" = "Uma mãe na média",
	"4" = "Uma pessoa que tem alguns problemas para ser mãe",
	"5" = "Uma mãe não muito boa"
)
data$t1_psi58.factor = factor(data$t1_psi58, levels = names(mapping_t1_psi58), labels = mapping_t1_psi58)

mapping_t1_psi63 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi63.factor = factor(data$t1_psi63, levels = names(mapping_t1_psi63), labels = mapping_t1_psi63)

mapping_t1_psi64 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi64.factor = factor(data$t1_psi64, levels = names(mapping_t1_psi64), labels = mapping_t1_psi64)

mapping_t1_psi17 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi17.factor = factor(data$t1_psi17, levels = names(mapping_t1_psi17), labels = mapping_t1_psi17)

mapping_t1_psi19 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi19.factor = factor(data$t1_psi19, levels = names(mapping_t1_psi19), labels = mapping_t1_psi19)

mapping_t1_psi20 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi20.factor = factor(data$t1_psi20, levels = names(mapping_t1_psi20), labels = mapping_t1_psi20)

mapping_t1_psi31 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi31.factor = factor(data$t1_psi31, levels = names(mapping_t1_psi31), labels = mapping_t1_psi31)

mapping_t1_psi32 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi32.factor = factor(data$t1_psi32, levels = names(mapping_t1_psi32), labels = mapping_t1_psi32)

mapping_t1_psi34 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi34.factor = factor(data$t1_psi34, levels = names(mapping_t1_psi34), labels = mapping_t1_psi34)

mapping_t1_psi36 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi36.factor = factor(data$t1_psi36, levels = names(mapping_t1_psi36), labels = mapping_t1_psi36)

mapping_t1_psi41 = c(
	"1" = "Mais difícil do que eu esperava",
	"2" = "Um pouco mais difícil do que eu esperava",
	"3" = "Tão difícil quanto eu esperava",
	"4" = "Um pouco mais fácil do que eu esperava",
	"5" = "Mais fácil do que eu esperava"
)
data$t1_psi41.factor = factor(data$t1_psi41, levels = names(mapping_t1_psi41), labels = mapping_t1_psi41)

mapping_t1_psi42 = c(
	"1" = "1-3",
	"2" = "4-5",
	"3" = "6-7",
	"4" = "8-9",
	"5" = "10+"
)
data$t1_psi42.factor = factor(data$t1_psi42, levels = names(mapping_t1_psi42), labels = mapping_t1_psi42)

mapping_t1_psi44 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi44.factor = factor(data$t1_psi44, levels = names(mapping_t1_psi44), labels = mapping_t1_psi44)

mapping_t1_psi47 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi47.factor = factor(data$t1_psi47, levels = names(mapping_t1_psi47), labels = mapping_t1_psi47)

mapping_t1_psi50 = c(
	"1" = "Concordo Totalmente",
	"2" = "Concordo",
	"3" = "Nem concordo nem discordo",
	"4" = "Discordo",
	"5" = "Discordo Totalmente"
)
data$t1_psi50.factor = factor(data$t1_psi50, levels = names(mapping_t1_psi50), labels = mapping_t1_psi50)

mapping_psi_short_form_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$psi_short_form_t1_complete.factor = factor(data$psi_short_form_t1_complete, levels = names(mapping_psi_short_form_t1_complete), labels = mapping_psi_short_form_t1_complete)

mapping_t1_droga1 = c(
	"0" = "Nunca",
	"1" = "Ocasionalmente, algumas vezes por mês",
	"2" = "Semanalmente, pelo menos uma vez por semana (ou só final de semana)",
	"3" = "Diariamente ou quase todos os dias"
)
data$t1_droga1.factor = factor(data$t1_droga1, levels = names(mapping_t1_droga1), labels = mapping_t1_droga1)

mapping_t1_droga1a = c(
	"0" = "Nunca",
	"1" = "Ocasionalmente, algumas vezes por mês",
	"2" = "Semanalmente, pelo menos uma vez por semana (ou só final de semana)",
	"3" = "Diariamente ou quase todos os dias"
)
data$t1_droga1a.factor = factor(data$t1_droga1a, levels = names(mapping_t1_droga1a), labels = mapping_t1_droga1a)

mapping_t1_droga2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga2.factor = factor(data$t1_droga2, levels = names(mapping_t1_droga2), labels = mapping_t1_droga2)

mapping_t1_droga2a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga2a.factor = factor(data$t1_droga2a, levels = names(mapping_t1_droga2a), labels = mapping_t1_droga2a)

mapping_t1_droga3 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga3.factor = factor(data$t1_droga3, levels = names(mapping_t1_droga3), labels = mapping_t1_droga3)

mapping_t1_droga3a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga3a.factor = factor(data$t1_droga3a, levels = names(mapping_t1_droga3a), labels = mapping_t1_droga3a)

mapping_t1_droga4 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga4.factor = factor(data$t1_droga4, levels = names(mapping_t1_droga4), labels = mapping_t1_droga4)

mapping_t1_droga4a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga4a.factor = factor(data$t1_droga4a, levels = names(mapping_t1_droga4a), labels = mapping_t1_droga4a)

mapping_t1_droga5 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga5.factor = factor(data$t1_droga5, levels = names(mapping_t1_droga5), labels = mapping_t1_droga5)

mapping_t1_droga5a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga5a.factor = factor(data$t1_droga5a, levels = names(mapping_t1_droga5a), labels = mapping_t1_droga5a)

mapping_t1_droga6 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga6.factor = factor(data$t1_droga6, levels = names(mapping_t1_droga6), labels = mapping_t1_droga6)

mapping_t1_droga6a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga6a.factor = factor(data$t1_droga6a, levels = names(mapping_t1_droga6a), labels = mapping_t1_droga6a)

mapping_t1_droga7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga7.factor = factor(data$t1_droga7, levels = names(mapping_t1_droga7), labels = mapping_t1_droga7)

mapping_t1_droga7a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga7a.factor = factor(data$t1_droga7a, levels = names(mapping_t1_droga7a), labels = mapping_t1_droga7a)

mapping_t1_droga8 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga8.factor = factor(data$t1_droga8, levels = names(mapping_t1_droga8), labels = mapping_t1_droga8)

mapping_t1_droga8a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga8a.factor = factor(data$t1_droga8a, levels = names(mapping_t1_droga8a), labels = mapping_t1_droga8a)

mapping_t1_droga9 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga9.factor = factor(data$t1_droga9, levels = names(mapping_t1_droga9), labels = mapping_t1_droga9)

mapping_t1_droga9a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga9a.factor = factor(data$t1_droga9a, levels = names(mapping_t1_droga9a), labels = mapping_t1_droga9a)

mapping_t1_droga10 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga10.factor = factor(data$t1_droga10, levels = names(mapping_t1_droga10), labels = mapping_t1_droga10)

mapping_t1_droga10a = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_droga10a.factor = factor(data$t1_droga10a, levels = names(mapping_t1_droga10a), labels = mapping_t1_droga10a)

mapping_alcool_e_drogas_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$alcool_e_drogas_t1_complete.factor = factor(data$alcool_e_drogas_t1_complete, levels = names(mapping_alcool_e_drogas_t1_complete), labels = mapping_alcool_e_drogas_t1_complete)

mapping_t1_mspss2 = c(
	"1" = "Discordo muito fortemente",
	"2" = "Discordo fortemente",
	"3" = "Discordo um pouco",
	"4" = "Neutro",
	"5" = "Concordo um pouco",
	"6" = "Concordo fortemente",
	"7" = "Concordo muito fortemente"
)
data$t1_mspss2.factor = factor(data$t1_mspss2, levels = names(mapping_t1_mspss2), labels = mapping_t1_mspss2)

mapping_t1_mspss4 = c(
	"1" = "Discordo muito fortemente",
	"2" = "Discordo fortemente",
	"3" = "Discordo um pouco",
	"4" = "Neutro",
	"5" = "Concordo um pouco",
	"6" = "Concordo fortemente",
	"7" = "Concordo muito fortemente"
)
data$t1_mspss4.factor = factor(data$t1_mspss4, levels = names(mapping_t1_mspss4), labels = mapping_t1_mspss4)

mapping_t1_mspss7 = c(
	"1" = "Discordo muito fortemente",
	"2" = "Discordo fortemente",
	"3" = "Discordo um pouco",
	"4" = "Neutro",
	"5" = "Concordo um pouco",
	"6" = "Concordo fortemente",
	"7" = "Concordo muito fortemente"
)
data$t1_mspss7.factor = factor(data$t1_mspss7, levels = names(mapping_t1_mspss7), labels = mapping_t1_mspss7)

mapping_avaliacao_suporte_social_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$avaliacao_suporte_social_complete.factor = factor(data$avaliacao_suporte_social_complete, levels = names(mapping_avaliacao_suporte_social_complete), labels = mapping_avaliacao_suporte_social_complete)

mapping_t1_badssf1 = c(
	"0" = "6 Concordo totalmente",
	"1" = "5",
	"2" = "4 Concordo",
	"3" = "3 Indiferente",
	"4" = "2 Discordo",
	"5" = "1",
	"6" = "0 Discordo totalmente"
)
data$t1_badssf1.factor = factor(data$t1_badssf1, levels = names(mapping_t1_badssf1), labels = mapping_t1_badssf1)

mapping_t1_badssf2 = c(
	"0" = "0 Discordo totalmente",
	"1" = "1",
	"2" = "2 Discordo",
	"3" = "3 Indiferente",
	"4" = "4 Concordo",
	"5" = "5",
	"6" = "6 Concordo totalmente"
)
data$t1_badssf2.factor = factor(data$t1_badssf2, levels = names(mapping_t1_badssf2), labels = mapping_t1_badssf2)

mapping_t1_badssf3 = c(
	"0" = "0 Discordo totalmente",
	"1" = "1",
	"2" = "2 Discordo",
	"3" = "3 Indiferente",
	"4" = "4 Concordo",
	"5" = "5",
	"6" = "6 Concordo totalmente"
)
data$t1_badssf3.factor = factor(data$t1_badssf3, levels = names(mapping_t1_badssf3), labels = mapping_t1_badssf3)

mapping_t1_badssf4 = c(
	"0" = "0 Discordo totalmente",
	"1" = "1",
	"2" = "2 Discordo",
	"3" = "3 Indiferente",
	"4" = "4 Concordo",
	"5" = "5",
	"6" = "6 Concordo totalmente"
)
data$t1_badssf4.factor = factor(data$t1_badssf4, levels = names(mapping_t1_badssf4), labels = mapping_t1_badssf4)

mapping_t1_badssf5 = c(
	"0" = "0 Discordo totalmente",
	"1" = "1",
	"2" = "2 Discordo",
	"3" = "3 Indiferente",
	"4" = "4 Concordo",
	"5" = "5",
	"6" = "6 Concordo totalmente"
)
data$t1_badssf5.factor = factor(data$t1_badssf5, levels = names(mapping_t1_badssf5), labels = mapping_t1_badssf5)

mapping_t1_badssf6 = c(
	"0" = "6 Concordo totalmente",
	"1" = "5",
	"2" = "4 Concordo",
	"3" = "3 Indiferente",
	"4" = "2 Discordo",
	"5" = "1",
	"6" = "0 Discordo totalmente"
)
data$t1_badssf6.factor = factor(data$t1_badssf6, levels = names(mapping_t1_badssf6), labels = mapping_t1_badssf6)

mapping_t1_badssf7 = c(
	"0" = "6 Concordo totalmente",
	"1" = "5",
	"2" = "4 Concordo",
	"3" = "3 Indiferente",
	"4" = "2 Discordo",
	"5" = "1",
	"6" = "0 Discordo totalmente"
)
data$t1_badssf7.factor = factor(data$t1_badssf7, levels = names(mapping_t1_badssf7), labels = mapping_t1_badssf7)

mapping_t1_badssf8 = c(
	"0" = "6 Concordo totalmente",
	"1" = "5",
	"2" = "4 Concordo",
	"3" = "3 Indiferente",
	"4" = "2 Discordo",
	"5" = "1",
	"6" = "0 Discordo totalmente"
)
data$t1_badssf8.factor = factor(data$t1_badssf8, levels = names(mapping_t1_badssf8), labels = mapping_t1_badssf8)

mapping_t1_badssf9 = c(
	"0" = "0 Discordo totalmente",
	"1" = "1",
	"2" = "2 Discordo",
	"3" = "3 Indiferente",
	"4" = "4 Concordo",
	"5" = "5",
	"6" = "6 Concordo totalmente"
)
data$t1_badssf9.factor = factor(data$t1_badssf9, levels = names(mapping_t1_badssf9), labels = mapping_t1_badssf9)

mapping_escala_de_depressao_para_ac_formulario_breve_bads_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$escala_de_depressao_para_ac_formulario_breve_bads_t1_complete.factor = factor(data$escala_de_depressao_para_ac_formulario_breve_bads_t1_complete, levels = names(mapping_escala_de_depressao_para_ac_formulario_breve_bads_t1_complete), labels = mapping_escala_de_depressao_para_ac_formulario_breve_bads_t1_complete)

mapping_t1_rpi1 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi1.factor = factor(data$t1_rpi1, levels = names(mapping_t1_rpi1), labels = mapping_t1_rpi1)

mapping_t1_rpi2 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi2.factor = factor(data$t1_rpi2, levels = names(mapping_t1_rpi2), labels = mapping_t1_rpi2)

mapping_t1_rpi3 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi3.factor = factor(data$t1_rpi3, levels = names(mapping_t1_rpi3), labels = mapping_t1_rpi3)

mapping_t1_rpi4 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi4.factor = factor(data$t1_rpi4, levels = names(mapping_t1_rpi4), labels = mapping_t1_rpi4)

mapping_t1_rpi5 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi5.factor = factor(data$t1_rpi5, levels = names(mapping_t1_rpi5), labels = mapping_t1_rpi5)

mapping_t1_rpi6 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi6.factor = factor(data$t1_rpi6, levels = names(mapping_t1_rpi6), labels = mapping_t1_rpi6)

mapping_t1_rpi7 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi7.factor = factor(data$t1_rpi7, levels = names(mapping_t1_rpi7), labels = mapping_t1_rpi7)

mapping_t1_rpi8 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi8.factor = factor(data$t1_rpi8, levels = names(mapping_t1_rpi8), labels = mapping_t1_rpi8)

mapping_t1_rpi9 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi9.factor = factor(data$t1_rpi9, levels = names(mapping_t1_rpi9), labels = mapping_t1_rpi9)

mapping_t1_rpi10 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi10.factor = factor(data$t1_rpi10, levels = names(mapping_t1_rpi10), labels = mapping_t1_rpi10)

mapping_t1_rpi11 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi11.factor = factor(data$t1_rpi11, levels = names(mapping_t1_rpi11), labels = mapping_t1_rpi11)

mapping_t1_rpi12 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi12.factor = factor(data$t1_rpi12, levels = names(mapping_t1_rpi12), labels = mapping_t1_rpi12)

mapping_t1_rpi13 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi13.factor = factor(data$t1_rpi13, levels = names(mapping_t1_rpi13), labels = mapping_t1_rpi13)

mapping_t1_rpi14 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi14.factor = factor(data$t1_rpi14, levels = names(mapping_t1_rpi14), labels = mapping_t1_rpi14)

mapping_t1_rpi15 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi15.factor = factor(data$t1_rpi15, levels = names(mapping_t1_rpi15), labels = mapping_t1_rpi15)

mapping_t1_rpi16 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi16.factor = factor(data$t1_rpi16, levels = names(mapping_t1_rpi16), labels = mapping_t1_rpi16)

mapping_t1_rpi17 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi17.factor = factor(data$t1_rpi17, levels = names(mapping_t1_rpi17), labels = mapping_t1_rpi17)

mapping_t1_rpi18 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi18.factor = factor(data$t1_rpi18, levels = names(mapping_t1_rpi18), labels = mapping_t1_rpi18)

mapping_t1_rpi19 = c(
	"1" = "Concordo totalmente",
	"2" = "Concordo",
	"3" = "Discordo",
	"4" = "Discordo totalmente"
)
data$t1_rpi19.factor = factor(data$t1_rpi19, levels = names(mapping_t1_rpi19), labels = mapping_t1_rpi19)

mapping_t1_rpi20 = c(
	"1" = "Discordo totalmente",
	"2" = "Discordo",
	"3" = "Concordo",
	"4" = "Concordo totalmente"
)
data$t1_rpi20.factor = factor(data$t1_rpi20, levels = names(mapping_t1_rpi20), labels = mapping_t1_rpi20)

mapping_indice_de_probabilidade_de_recompensa_rpi_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$indice_de_probabilidade_de_recompensa_rpi_t1_complete.factor = factor(data$indice_de_probabilidade_de_recompensa_rpi_t1_complete, levels = names(mapping_indice_de_probabilidade_de_recompensa_rpi_t1_complete), labels = mapping_indice_de_probabilidade_de_recompensa_rpi_t1_complete)

mapping_feedback_1 = c(
	"0" = "0",
	"1" = "1",
	"2" = "2",
	"3" = "3",
	"4" = "4",
	"5" = "5"
)
data$feedback_1.factor = factor(data$feedback_1, levels = names(mapping_feedback_1), labels = mapping_feedback_1)

mapping_feedback_de_entrevista_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$feedback_de_entrevista_complete.factor = factor(data$feedback_de_entrevista_complete, levels = names(mapping_feedback_de_entrevista_complete), labels = mapping_feedback_de_entrevista_complete)

mapping_t1_cgi_s = c(
	"1" = "Normal, não doente;",
	"2" = "Limítrofe para transtorno mental, tem sintomas mas não apresenta prejuízo;",
	"3" = "Levemente doente, prejuízo funcional leve;",
	"4" = "Moderadamente doente, desempenha com esforço;",
	"5" = "Marcadamente doente, desempenho limitado;",
	"6" = "Gravemente doente, consegue desempenhar praticamente somente com assistência;",
	"7" = "Transtorno mental extremamente grave, desempenho completamente comprometido;"
)
data$t1_cgi_s.factor = factor(data$t1_cgi_s, levels = names(mapping_t1_cgi_s), labels = mapping_t1_cgi_s)

mapping_clinical_global_impression_severity_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$clinical_global_impression_severity_t1_complete.factor = factor(data$clinical_global_impression_severity_t1_complete, levels = names(mapping_clinical_global_impression_severity_t1_complete), labels = mapping_clinical_global_impression_severity_t1_complete)

mapping_t1_quali1 = c(
	"0" = "Ligação telefônica",
	"1" = "Videochamada",
	"2" = "Ambos (precisou trocar)"
)
data$t1_quali1.factor = factor(data$t1_quali1, levels = names(mapping_t1_quali1), labels = mapping_t1_quali1)

mapping_t1_quali2 = c(
	"0" = "Muito pouco cooperativa",
	"1" = "Pouco cooperativa",
	"2" = "Neutra",
	"3" = "Cooperativa",
	"4" = "Muito cooperativa"
)
data$t1_quali2.factor = factor(data$t1_quali2, levels = names(mapping_t1_quali2), labels = mapping_t1_quali2)

mapping_t1_quali3 = c(
	"0" = "Sendo muito pouco sincera ou verdadeira",
	"1" = "Sendo pouco sincera ou verdadeira",
	"2" = "Neutra",
	"3" = "Sendo sincera ou verdadeira",
	"4" = "Sendo muito sincera ou verdadeira"
)
data$t1_quali3.factor = factor(data$t1_quali3, levels = names(mapping_t1_quali3), labels = mapping_t1_quali3)

mapping_t1_quali4 = c(
	"0" = "Muito nervosa ou receosa",
	"1" = "Nervosa ou receosa",
	"2" = "Neutra",
	"3" = "À vontade",
	"4" = "Muito à vontade"
)
data$t1_quali4.factor = factor(data$t1_quali4, levels = names(mapping_t1_quali4), labels = mapping_t1_quali4)

mapping_t1_quali5 = c(
	"0" = "Não entendeu quase nada das perguntas",
	"1" = "Não entendeu direito as perguntas",
	"2" = "Neutro",
	"3" = "Entendeu as perguntas",
	"4" = "Entendeu as perguntas muito bem"
)
data$t1_quali5.factor = factor(data$t1_quali5, levels = names(mapping_t1_quali5), labels = mapping_t1_quali5)

mapping_t1_quali6 = c(
	"0" = "Muito ruim, muitos problemas ocorreram, não consigo garantir a qualidade das informações",
	"1" = "Ruim, problemas ocorreram, a qualidade da entrevista foi comprometida",
	"2" = "Razoável, alguns problemas ocorreram, a qualidade da entrevista foi um pouco comprometida",
	"3" = "Boa, alguns problemas ocasionais ocorreram, mas não comprometeram",
	"4" = "Muito boa, sem problemas"
)
data$t1_quali6.factor = factor(data$t1_quali6, levels = names(mapping_t1_quali6), labels = mapping_t1_quali6)

mapping_t1_quali7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_quali7.factor = factor(data$t1_quali7, levels = names(mapping_t1_quali7), labels = mapping_t1_quali7)

mapping_t1_quali8 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_quali8.factor = factor(data$t1_quali8, levels = names(mapping_t1_quali8), labels = mapping_t1_quali8)

mapping_qualidade_da_entrevista_t1_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$qualidade_da_entrevista_t1_complete.factor = factor(data$qualidade_da_entrevista_t1_complete, levels = names(mapping_qualidade_da_entrevista_t1_complete), labels = mapping_qualidade_da_entrevista_t1_complete)

mapping_formulario_pre_sessao_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulario_pre_sessao_complete.factor = factor(data$formulario_pre_sessao_complete, levels = names(mapping_formulario_pre_sessao_complete), labels = mapping_formulario_pre_sessao_complete)

mapping_pron_terapeuta = c(
	"1" = "Ana Claudia Sillos",
	"2" = "Anna Beatriz Gualandi",
	"3" = "Camila Monti",
	"4" = "Elisa Teixeira",
	"5" = "Karina Lima",
	"6" = "Késya Martha",
	"7" = "Lais Machado",
	"8" = "Milena Santiago",
	"9" = "Monica Fonseca",
	"10" = "Rachel Costa",
	"11" = "Rebeca Costa",
	"12" = "Eduarda Souza"
)
data$pron_terapeuta.factor = factor(data$pron_terapeuta, levels = names(mapping_pron_terapeuta), labels = mapping_pron_terapeuta)

mapping_pron_etapas_intro___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_intro___1.factor = factor(data$pron_etapas_intro___1, levels = names(mapping_pron_etapas_intro___1), labels = mapping_pron_etapas_intro___1)

mapping_pron_etapas_intro___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_intro___2.factor = factor(data$pron_etapas_intro___2, levels = names(mapping_pron_etapas_intro___2), labels = mapping_pron_etapas_intro___2)

mapping_pron_etapas_intro___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_intro___3.factor = factor(data$pron_etapas_intro___3, levels = names(mapping_pron_etapas_intro___3), labels = mapping_pron_etapas_intro___3)

mapping_pron_etapas_intro___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_intro___4.factor = factor(data$pron_etapas_intro___4, levels = names(mapping_pron_etapas_intro___4), labels = mapping_pron_etapas_intro___4)

mapping_pron_etapas_aval___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_aval___1.factor = factor(data$pron_etapas_aval___1, levels = names(mapping_pron_etapas_aval___1), labels = mapping_pron_etapas_aval___1)

mapping_pron_etapas_aval___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_aval___2.factor = factor(data$pron_etapas_aval___2, levels = names(mapping_pron_etapas_aval___2), labels = mapping_pron_etapas_aval___2)

mapping_pron_etapas_aval___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_aval___3.factor = factor(data$pron_etapas_aval___3, levels = names(mapping_pron_etapas_aval___3), labels = mapping_pron_etapas_aval___3)

mapping_pron_etapas_aval___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_etapas_aval___4.factor = factor(data$pron_etapas_aval___4, levels = names(mapping_pron_etapas_aval___4), labels = mapping_pron_etapas_aval___4)

mapping_pron_ba___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_ba___1.factor = factor(data$pron_ba___1, levels = names(mapping_pron_ba___1), labels = mapping_pron_ba___1)

mapping_pron_ba___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_ba___2.factor = factor(data$pron_ba___2, levels = names(mapping_pron_ba___2), labels = mapping_pron_ba___2)

mapping_pron_ba___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_ba___3.factor = factor(data$pron_ba___3, levels = names(mapping_pron_ba___3), labels = mapping_pron_ba___3)

mapping_pron_ba___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_ba___4.factor = factor(data$pron_ba___4, levels = names(mapping_pron_ba___4), labels = mapping_pron_ba___4)

mapping_pron_ba___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_ba___5.factor = factor(data$pron_ba___5, levels = names(mapping_pron_ba___5), labels = mapping_pron_ba___5)

mapping_pron_tcc___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___1.factor = factor(data$pron_tcc___1, levels = names(mapping_pron_tcc___1), labels = mapping_pron_tcc___1)

mapping_pron_tcc___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___2.factor = factor(data$pron_tcc___2, levels = names(mapping_pron_tcc___2), labels = mapping_pron_tcc___2)

mapping_pron_tcc___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___3.factor = factor(data$pron_tcc___3, levels = names(mapping_pron_tcc___3), labels = mapping_pron_tcc___3)

mapping_pron_tcc___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___4.factor = factor(data$pron_tcc___4, levels = names(mapping_pron_tcc___4), labels = mapping_pron_tcc___4)

mapping_pron_tcc___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___5.factor = factor(data$pron_tcc___5, levels = names(mapping_pron_tcc___5), labels = mapping_pron_tcc___5)

mapping_pron_tcc___6 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___6.factor = factor(data$pron_tcc___6, levels = names(mapping_pron_tcc___6), labels = mapping_pron_tcc___6)

mapping_pron_tcc___7 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___7.factor = factor(data$pron_tcc___7, levels = names(mapping_pron_tcc___7), labels = mapping_pron_tcc___7)

mapping_pron_tcc___8 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_tcc___8.factor = factor(data$pron_tcc___8, levels = names(mapping_pron_tcc___8), labels = mapping_pron_tcc___8)

mapping_pron_app_modulos___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___1.factor = factor(data$pron_app_modulos___1, levels = names(mapping_pron_app_modulos___1), labels = mapping_pron_app_modulos___1)

mapping_pron_app_modulos___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___2.factor = factor(data$pron_app_modulos___2, levels = names(mapping_pron_app_modulos___2), labels = mapping_pron_app_modulos___2)

mapping_pron_app_modulos___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___3.factor = factor(data$pron_app_modulos___3, levels = names(mapping_pron_app_modulos___3), labels = mapping_pron_app_modulos___3)

mapping_pron_app_modulos___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___4.factor = factor(data$pron_app_modulos___4, levels = names(mapping_pron_app_modulos___4), labels = mapping_pron_app_modulos___4)

mapping_pron_app_modulos___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___5.factor = factor(data$pron_app_modulos___5, levels = names(mapping_pron_app_modulos___5), labels = mapping_pron_app_modulos___5)

mapping_pron_app_modulos___6 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___6.factor = factor(data$pron_app_modulos___6, levels = names(mapping_pron_app_modulos___6), labels = mapping_pron_app_modulos___6)

mapping_pron_app_modulos___7 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$pron_app_modulos___7.factor = factor(data$pron_app_modulos___7, levels = names(mapping_pron_app_modulos___7), labels = mapping_pron_app_modulos___7)

mapping_pron_grav_sessao = c(
	"0" = "Sim",
	"1" = "Não, a participante não deu consentimento",
	"2" = "Não, tive problemas técnicos"
)
data$pron_grav_sessao.factor = factor(data$pron_grav_sessao, levels = names(mapping_pron_grav_sessao), labels = mapping_pron_grav_sessao)

mapping_pron_ideacao = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_ideacao.factor = factor(data$pron_ideacao, levels = names(mapping_pron_ideacao), labels = mapping_pron_ideacao)

mapping_pron_ideacao_plano = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_ideacao_plano.factor = factor(data$pron_ideacao_plano, levels = names(mapping_pron_ideacao_plano), labels = mapping_pron_ideacao_plano)

mapping_pron_ideacao_supervisao = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_ideacao_supervisao.factor = factor(data$pron_ideacao_supervisao, levels = names(mapping_pron_ideacao_supervisao), labels = mapping_pron_ideacao_supervisao)

mapping_pron_vd = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_vd.factor = factor(data$pron_vd, levels = names(mapping_pron_vd), labels = mapping_pron_vd)

mapping_pron_vd_rede = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_vd_rede.factor = factor(data$pron_vd_rede, levels = names(mapping_pron_vd_rede), labels = mapping_pron_vd_rede)

mapping_pron_app_instalado = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_app_instalado.factor = factor(data$pron_app_instalado, levels = names(mapping_pron_app_instalado), labels = mapping_pron_app_instalado)

mapping_pron_app_tecnico = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_app_tecnico.factor = factor(data$pron_app_tecnico, levels = names(mapping_pron_app_tecnico), labels = mapping_pron_app_tecnico)

mapping_pron_app_resistencia = c(
	"0" = "Não",
	"1" = "Sim"
)
data$pron_app_resistencia.factor = factor(data$pron_app_resistencia, levels = names(mapping_pron_app_resistencia), labels = mapping_pron_app_resistencia)

mapping_formulrio_para_pronturio_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_para_pronturio_complete.factor = factor(data$formulrio_para_pronturio_complete, levels = names(mapping_formulrio_para_pronturio_complete), labels = mapping_formulrio_para_pronturio_complete)

mapping_t1_quali_terapeuta = c(
	"1" = "Ana Claudia Sillos",
	"2" = "Anna Beatriz Gualandi",
	"3" = "Camila Monti",
	"4" = "Elisa Teixeira",
	"5" = "Karina Lima",
	"6" = "Késya Martha",
	"7" = "Lais Machado",
	"8" = "Milena Santiago",
	"9" = "Monica Fonseca",
	"10" = "Rachel Costa",
	"11" = "Rebeca Costa",
	"12" = "Eduarda Souza"
)
data$t1_quali_terapeuta.factor = factor(data$t1_quali_terapeuta, levels = names(mapping_t1_quali_terapeuta), labels = mapping_t1_quali_terapeuta)

mapping_t1_quali_sessao_meio = c(
	"0" = "Ligação telefônica",
	"1" = "Videochamada",
	"2" = "Ambos (precisou trocar)"
)
data$t1_quali_sessao_meio.factor = factor(data$t1_quali_sessao_meio, levels = names(mapping_t1_quali_sessao_meio), labels = mapping_t1_quali_sessao_meio)

mapping_t1_quali_sessao1 = c(
	"0" = "Muito pouco cooperativa",
	"1" = "Pouco cooperativa",
	"2" = "Neutra",
	"3" = "Cooperativa",
	"4" = "Muito cooperativa"
)
data$t1_quali_sessao1.factor = factor(data$t1_quali_sessao1, levels = names(mapping_t1_quali_sessao1), labels = mapping_t1_quali_sessao1)

mapping_t1_quali_sessao2 = c(
	"0" = "Sendo muito pouco sincera ou verdadeira",
	"1" = "Sendo pouco sincera ou verdadeira",
	"2" = "Neutra",
	"3" = "Sendo sincera ou verdadeira",
	"4" = "Sendo muito sincera ou verdadeira"
)
data$t1_quali_sessao2.factor = factor(data$t1_quali_sessao2, levels = names(mapping_t1_quali_sessao2), labels = mapping_t1_quali_sessao2)

mapping_t1_quali_sessao3 = c(
	"0" = "Muito nervosa ou receosa",
	"1" = "Nervosa ou receosa",
	"2" = "Neutra",
	"3" = "À vontade",
	"4" = "Muito à vontade"
)
data$t1_quali_sessao3.factor = factor(data$t1_quali_sessao3, levels = names(mapping_t1_quali_sessao3), labels = mapping_t1_quali_sessao3)

mapping_t1_quali_sessao4 = c(
	"0" = "Não entendeu quase nada das perguntas",
	"1" = "Não entendeu direito as perguntas",
	"2" = "Neutro",
	"3" = "Entendeu as perguntas",
	"4" = "Entendeu as perguntas muito bem"
)
data$t1_quali_sessao4.factor = factor(data$t1_quali_sessao4, levels = names(mapping_t1_quali_sessao4), labels = mapping_t1_quali_sessao4)

mapping_t1_quali_sessao5 = c(
	"0" = "Muito ruim, muitos problemas ocorreram, não consigo garantir a qualidade das informações",
	"1" = "Ruim, problemas ocorreram, a qualidade da sessão foi comprometida",
	"2" = "Razoável, alguns problemas ocorreram, a qualidade da sessão foi um pouco comprometida",
	"3" = "Boa, alguns problemas ocasionais ocorreram, mas não comprometeram",
	"4" = "Muito boa, sem problemas"
)
data$t1_quali_sessao5.factor = factor(data$t1_quali_sessao5, levels = names(mapping_t1_quali_sessao5), labels = mapping_t1_quali_sessao5)

mapping_t2_quali_sessao6 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t2_quali_sessao6.factor = factor(data$t2_quali_sessao6, levels = names(mapping_t2_quali_sessao6), labels = mapping_t2_quali_sessao6)

mapping_t1_quali_sessao7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t1_quali_sessao7.factor = factor(data$t1_quali_sessao7, levels = names(mapping_t1_quali_sessao7), labels = mapping_t1_quali_sessao7)

mapping_t1_quali_sessao8 = c(
	"0" = "O tempo de sessão foi suficiente para cumprir todas as etapas.",
	"1" = "Houve intercorrência na sessão. É necessário agendar outro dia para finalizar as etapas."
)
data$t1_quali_sessao8.factor = factor(data$t1_quali_sessao8, levels = names(mapping_t1_quali_sessao8), labels = mapping_t1_quali_sessao8)

mapping_qualidade_da_sessao_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$qualidade_da_sessao_complete.factor = factor(data$qualidade_da_sessao_complete, levels = names(mapping_qualidade_da_sessao_complete), labels = mapping_qualidade_da_sessao_complete)

mapping_t2_waisrc_1 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_1.factor = factor(data$t2_waisrc_1, levels = names(mapping_t2_waisrc_1), labels = mapping_t2_waisrc_1)

mapping_t2_waisrc_2 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_2.factor = factor(data$t2_waisrc_2, levels = names(mapping_t2_waisrc_2), labels = mapping_t2_waisrc_2)

mapping_t2_waisrc_3 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_3.factor = factor(data$t2_waisrc_3, levels = names(mapping_t2_waisrc_3), labels = mapping_t2_waisrc_3)

mapping_t2_waisrc_4 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_4.factor = factor(data$t2_waisrc_4, levels = names(mapping_t2_waisrc_4), labels = mapping_t2_waisrc_4)

mapping_t2_waisrc_5 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_5.factor = factor(data$t2_waisrc_5, levels = names(mapping_t2_waisrc_5), labels = mapping_t2_waisrc_5)

mapping_t2_waisrc_6 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_6.factor = factor(data$t2_waisrc_6, levels = names(mapping_t2_waisrc_6), labels = mapping_t2_waisrc_6)

mapping_t2_waisrc_7 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_7.factor = factor(data$t2_waisrc_7, levels = names(mapping_t2_waisrc_7), labels = mapping_t2_waisrc_7)

mapping_t2_waisrc_8 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_8.factor = factor(data$t2_waisrc_8, levels = names(mapping_t2_waisrc_8), labels = mapping_t2_waisrc_8)

mapping_t2_waisrc_9 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_9.factor = factor(data$t2_waisrc_9, levels = names(mapping_t2_waisrc_9), labels = mapping_t2_waisrc_9)

mapping_t2_waisrc_10 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_10.factor = factor(data$t2_waisrc_10, levels = names(mapping_t2_waisrc_10), labels = mapping_t2_waisrc_10)

mapping_t2_waisrc_11 = c(
	"5" = "Sempre",
	"4" = "Muito frequentemente",
	"3" = "Frequentemente",
	"2" = "Às vezes",
	"1" = "Raramente"
)
data$t2_waisrc_11.factor = factor(data$t2_waisrc_11, levels = names(mapping_t2_waisrc_11), labels = mapping_t2_waisrc_11)

mapping_t2_waisrc_12 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrc_12.factor = factor(data$t2_waisrc_12, levels = names(mapping_t2_waisrc_12), labels = mapping_t2_waisrc_12)

mapping_waisr_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$waisr_complete.factor = factor(data$waisr_complete, levels = names(mapping_waisr_complete), labels = mapping_waisr_complete)

mapping_t3_sus1 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus1.factor = factor(data$t3_sus1, levels = names(mapping_t3_sus1), labels = mapping_t3_sus1)

mapping_t3_sus2 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus2.factor = factor(data$t3_sus2, levels = names(mapping_t3_sus2), labels = mapping_t3_sus2)

mapping_t3_sus3 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus3.factor = factor(data$t3_sus3, levels = names(mapping_t3_sus3), labels = mapping_t3_sus3)

mapping_t3_sus4 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus4.factor = factor(data$t3_sus4, levels = names(mapping_t3_sus4), labels = mapping_t3_sus4)

mapping_t3_sus5 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus5.factor = factor(data$t3_sus5, levels = names(mapping_t3_sus5), labels = mapping_t3_sus5)

mapping_t3_sus6 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus6.factor = factor(data$t3_sus6, levels = names(mapping_t3_sus6), labels = mapping_t3_sus6)

mapping_t3_sus7 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus7.factor = factor(data$t3_sus7, levels = names(mapping_t3_sus7), labels = mapping_t3_sus7)

mapping_t3_sus8 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus8.factor = factor(data$t3_sus8, levels = names(mapping_t3_sus8), labels = mapping_t3_sus8)

mapping_t3_sus9 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus9.factor = factor(data$t3_sus9, levels = names(mapping_t3_sus9), labels = mapping_t3_sus9)

mapping_t3_sus10 = c(
	"1" = "Discordo fortemente",
	"2" = "Discordo",
	"3" = "Não concordo nem discordo",
	"4" = "Concordo",
	"5" = "Concordo fortemente"
)
data$t3_sus10.factor = factor(data$t3_sus10, levels = names(mapping_t3_sus10), labels = mapping_t3_sus10)

mapping_system_usability_of_scale_sus_t3_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$system_usability_of_scale_sus_t3_complete.factor = factor(data$system_usability_of_scale_sus_t3_complete, levels = names(mapping_system_usability_of_scale_sus_t3_complete), labels = mapping_system_usability_of_scale_sus_t3_complete)

mapping_t3_umars17 = c(
	"1" = "De forma alguma: Não recomendaria este aplicativo para ninguém",
	"2" = "Recomendaria este aplicativo para poucas pessoas",
	"3" = "Talvez: Recomendaria este aplicativo para várias pessoas",
	"4" = "Recomendaria este aplicativo para muitas pessoas",
	"5" = "Definitivamente: Recomendaria este aplicativo para todo mundo"
)
data$t3_umars17.factor = factor(data$t3_umars17, levels = names(mapping_t3_umars17), labels = mapping_t3_umars17)

mapping_t3_umars18 = c(
	"1" = "Nenhuma",
	"2" = "1-2",
	"3" = "3-10",
	"4" = "10-50",
	"5" = ">50"
)
data$t3_umars18.factor = factor(data$t3_umars18, levels = names(mapping_t3_umars18), labels = mapping_t3_umars18)

mapping_t3_umars19 = c(
	"1" = "(1) Definitivamente não pagaria",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Definitivamente pagaria"
)
data$t3_umars19.factor = factor(data$t3_umars19, levels = names(mapping_t3_umars19), labels = mapping_t3_umars19)

mapping_t3_umars20 = c(
	"1" = "1 Estrela: Um dos piores que já usei",
	"2" = "2 Estrelas",
	"3" = "3 Estrelas: Mediano",
	"4" = "4 Estrelas",
	"5" = "5 Estrelas: Um dos melhores que já usei"
)
data$t3_umars20.factor = factor(data$t3_umars20, levels = names(mapping_t3_umars20), labels = mapping_t3_umars20)

mapping_t3_umars21 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars21.factor = factor(data$t3_umars21, levels = names(mapping_t3_umars21), labels = mapping_t3_umars21)

mapping_t3_umars22 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars22.factor = factor(data$t3_umars22, levels = names(mapping_t3_umars22), labels = mapping_t3_umars22)

mapping_t3_umars23 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars23.factor = factor(data$t3_umars23, levels = names(mapping_t3_umars23), labels = mapping_t3_umars23)

mapping_t3_umars24 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars24.factor = factor(data$t3_umars24, levels = names(mapping_t3_umars24), labels = mapping_t3_umars24)

mapping_t3_umars25 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars25.factor = factor(data$t3_umars25, levels = names(mapping_t3_umars25), labels = mapping_t3_umars25)

mapping_t3_umars26 = c(
	"1" = "(1) Discordo totalmente",
	"2" = "(2)",
	"3" = "(3)",
	"4" = "(4)",
	"5" = "(5) Concordo Totalmente"
)
data$t3_umars26.factor = factor(data$t3_umars26, levels = names(mapping_t3_umars26), labels = mapping_t3_umars26)

mapping_mobile_application_rating_scale_user_version_umars_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$mobile_application_rating_scale_user_version_umars_complete.factor = factor(data$mobile_application_rating_scale_user_version_umars_complete, levels = names(mapping_mobile_application_rating_scale_user_version_umars_complete), labels = mapping_mobile_application_rating_scale_user_version_umars_complete)

mapping_t3_cgi_i = c(
	"1" = "Muito melhor",
	"2" = "Melhor",
	"3" = "Ligeiramente melhor",
	"4" = "Sem alteração",
	"5" = "Ligeiramente pior",
	"6" = "Pior",
	"7" = "Muito pior"
)
data$t3_cgi_i.factor = factor(data$t3_cgi_i, levels = names(mapping_t3_cgi_i), labels = mapping_t3_cgi_i)

mapping_clinical_global_impression_improvement_t3_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$clinical_global_impression_improvement_t3_complete.factor = factor(data$clinical_global_impression_improvement_t3_complete, levels = names(mapping_clinical_global_impression_improvement_t3_complete), labels = mapping_clinical_global_impression_improvement_t3_complete)

mapping_t3_quali1 = c(
	"0" = "Ligação telefônica",
	"1" = "Videochamada",
	"2" = "Ambos (precisou trocar)"
)
data$t3_quali1.factor = factor(data$t3_quali1, levels = names(mapping_t3_quali1), labels = mapping_t3_quali1)

mapping_t3_quali2 = c(
	"0" = "Muito pouco cooperativa",
	"1" = "Pouco cooperativa",
	"2" = "Neutra",
	"3" = "Cooperativa",
	"4" = "Muito cooperativa"
)
data$t3_quali2.factor = factor(data$t3_quali2, levels = names(mapping_t3_quali2), labels = mapping_t3_quali2)

mapping_t3_quali3 = c(
	"0" = "Sendo muito pouco sincera ou verdadeira",
	"1" = "Sendo pouco sincera ou verdadeira",
	"2" = "Neutra",
	"3" = "Sendo sincera ou verdadeira",
	"4" = "Sendo muito sincera ou verdadeira"
)
data$t3_quali3.factor = factor(data$t3_quali3, levels = names(mapping_t3_quali3), labels = mapping_t3_quali3)

mapping_t3_quali4 = c(
	"0" = "Muito nervosa e assustada",
	"1" = "Nervosa ou assustada",
	"2" = "Neutra",
	"3" = "A vontade",
	"4" = "Muito a vontade"
)
data$t3_quali4.factor = factor(data$t3_quali4, levels = names(mapping_t3_quali4), labels = mapping_t3_quali4)

mapping_t3_quali5 = c(
	"0" = "Não entendeu quase nada das perguntas",
	"1" = "Não entendeu direito as perguntas",
	"2" = "Neutro",
	"3" = "Entendeu as perguntas",
	"4" = "Entendeu as perguntas muito bem"
)
data$t3_quali5.factor = factor(data$t3_quali5, levels = names(mapping_t3_quali5), labels = mapping_t3_quali5)

mapping_t3_quali6 = c(
	"0" = "Muito ruim, muitos problemas ocorreram, não consigo garantir a qualidade das informações",
	"1" = "Ruim, problemas ocorreram, a qualidade da entrevista foi comprometida",
	"2" = "Razoável, alguns problemas ocorreram, a qualidade da entrevista foi um pouco comprometida",
	"3" = "Boa, alguns problemas ocasionais ocorreram, mas não comprometeram",
	"4" = "Muito boa, sem problemas"
)
data$t3_quali6.factor = factor(data$t3_quali6, levels = names(mapping_t3_quali6), labels = mapping_t3_quali6)

mapping_t3_quali8 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$t3_quali8.factor = factor(data$t3_quali8, levels = names(mapping_t3_quali8), labels = mapping_t3_quali8)

mapping_t3_cegamento_1 = c(
	"1" = "Intervenção",
	"2" = "Lista de espera"
)
data$t3_cegamento_1.factor = factor(data$t3_cegamento_1, levels = names(mapping_t3_cegamento_1), labels = mapping_t3_cegamento_1)

mapping_t3_cegamento_2 = c(
	"0" = "0",
	"1" = "1",
	"2" = "2",
	"3" = "3",
	"4" = "4",
	"5" = "5",
	"6" = "6",
	"7" = "7",
	"8" = "8",
	"9" = "9",
	"10" = "10"
)
data$t3_cegamento_2.factor = factor(data$t3_cegamento_2, levels = names(mapping_t3_cegamento_2), labels = mapping_t3_cegamento_2)

mapping_t3_cegamento_3 = c(
	"1" = "Sim",
	"0" = "Não"
)
data$t3_cegamento_3.factor = factor(data$t3_cegamento_3, levels = names(mapping_t3_cegamento_3), labels = mapping_t3_cegamento_3)

mapping_qualidade_da_entrevista_t3_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$qualidade_da_entrevista_t3_complete.factor = factor(data$qualidade_da_entrevista_t3_complete, levels = names(mapping_qualidade_da_entrevista_t3_complete), labels = mapping_qualidade_da_entrevista_t3_complete)

mapping_t2_waisrt_1 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_1.factor = factor(data$t2_waisrt_1, levels = names(mapping_t2_waisrt_1), labels = mapping_t2_waisrt_1)

mapping_t2_waisrt_2 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_2.factor = factor(data$t2_waisrt_2, levels = names(mapping_t2_waisrt_2), labels = mapping_t2_waisrt_2)

mapping_t2_waisrt_3 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_3.factor = factor(data$t2_waisrt_3, levels = names(mapping_t2_waisrt_3), labels = mapping_t2_waisrt_3)

mapping_t2_waisrt_4 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_4.factor = factor(data$t2_waisrt_4, levels = names(mapping_t2_waisrt_4), labels = mapping_t2_waisrt_4)

mapping_t2_waisrt_5 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_5.factor = factor(data$t2_waisrt_5, levels = names(mapping_t2_waisrt_5), labels = mapping_t2_waisrt_5)

mapping_t2_waisrt_6 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_6.factor = factor(data$t2_waisrt_6, levels = names(mapping_t2_waisrt_6), labels = mapping_t2_waisrt_6)

mapping_t2_waisrt_7 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_7.factor = factor(data$t2_waisrt_7, levels = names(mapping_t2_waisrt_7), labels = mapping_t2_waisrt_7)

mapping_t2_waisrt_8 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_8.factor = factor(data$t2_waisrt_8, levels = names(mapping_t2_waisrt_8), labels = mapping_t2_waisrt_8)

mapping_t2_waisrt_9 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_9.factor = factor(data$t2_waisrt_9, levels = names(mapping_t2_waisrt_9), labels = mapping_t2_waisrt_9)

mapping_t2_waisrt_10 = c(
	"1" = "Raramente",
	"2" = "Às vezes",
	"3" = "Frequentemente",
	"4" = "Muito frequentemente",
	"5" = "Sempre"
)
data$t2_waisrt_10.factor = factor(data$t2_waisrt_10, levels = names(mapping_t2_waisrt_10), labels = mapping_t2_waisrt_10)

mapping_wai_terapeuta_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$wai_terapeuta_complete.factor = factor(data$wai_terapeuta_complete, levels = names(mapping_wai_terapeuta_complete), labels = mapping_wai_terapeuta_complete)

mapping_enc_1___1 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$enc_1___1.factor = factor(data$enc_1___1, levels = names(mapping_enc_1___1), labels = mapping_enc_1___1)

mapping_enc_1___2 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$enc_1___2.factor = factor(data$enc_1___2, levels = names(mapping_enc_1___2), labels = mapping_enc_1___2)

mapping_enc_1___3 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$enc_1___3.factor = factor(data$enc_1___3, levels = names(mapping_enc_1___3), labels = mapping_enc_1___3)

mapping_enc_1___4 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$enc_1___4.factor = factor(data$enc_1___4, levels = names(mapping_enc_1___4), labels = mapping_enc_1___4)

mapping_enc_1___5 = c(
	"0" = "Unchecked",
	"1" = "Checked"
)
data$enc_1___5.factor = factor(data$enc_1___5, levels = names(mapping_enc_1___5), labels = mapping_enc_1___5)

mapping_enc_3 = c(
	"1" = "Sim",
	"0" = "Não"
)
data$enc_3.factor = factor(data$enc_3, levels = names(mapping_enc_3), labels = mapping_enc_3)

mapping_enc_4 = c(
	"1" = "Sim",
	"0" = "Não"
)
data$enc_4.factor = factor(data$enc_4, levels = names(mapping_enc_4), labels = mapping_enc_4)

mapping_formulrio_de_encaminhamento_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_de_encaminhamento_complete.factor = factor(data$formulrio_de_encaminhamento_complete, levels = names(mapping_formulrio_de_encaminhamento_complete), labels = mapping_formulrio_de_encaminhamento_complete)

mapping_dropout1 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$dropout1.factor = factor(data$dropout1, levels = names(mapping_dropout1), labels = mapping_dropout1)

mapping_dropout2 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$dropout2.factor = factor(data$dropout2, levels = names(mapping_dropout2), labels = mapping_dropout2)

mapping_dropout3 = c(
	"0" = "Não",
	"1" = "Sim, do meio de tratamento (T2) em diante",
	"2" = "Sim, do pós-tratamento (T3) em diante",
	"3" = "Sim, do seguimento (T4) em diante"
)
data$dropout3.factor = factor(data$dropout3, levels = names(mapping_dropout3), labels = mapping_dropout3)

mapping_dropout5 = c(
	"1" = "Email",
	"2" = "Mensagem de texto",
	"3" = "Mensagem de voz, áudio",
	"4" = "Vídeo chamada",
	"5" = "Ligação telefônica"
)
data$dropout5.factor = factor(data$dropout5, levels = names(mapping_dropout5), labels = mapping_dropout5)

mapping_dropout7 = c(
	"0" = "Não",
	"1" = "Sim"
)
data$dropout7.factor = factor(data$dropout7, levels = names(mapping_dropout7), labels = mapping_dropout7)

mapping_formulario_dropout_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulario_dropout_complete.factor = factor(data$formulario_dropout_complete, levels = names(mapping_formulario_dropout_complete), labels = mapping_formulario_dropout_complete)

mapping_formulrio_de_falta_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_de_falta_complete.factor = factor(data$formulrio_de_falta_complete, levels = names(mapping_formulrio_de_falta_complete), labels = mapping_formulrio_de_falta_complete)

mapping_formulrio_de_eventos_adversos_t3_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_de_eventos_adversos_t3_complete.factor = factor(data$formulrio_de_eventos_adversos_t3_complete, levels = names(mapping_formulrio_de_eventos_adversos_t3_complete), labels = mapping_formulrio_de_eventos_adversos_t3_complete)

mapping_formulrio_de_eventos_adversos_t4_complete = c(
	"0" = "Incomplete",
	"1" = "Unverified",
	"2" = "Complete"
)
data$formulrio_de_eventos_adversos_t4_complete.factor = factor(data$formulrio_de_eventos_adversos_t4_complete, levels = names(mapping_formulrio_de_eventos_adversos_t4_complete), labels = mapping_formulrio_de_eventos_adversos_t4_complete)

