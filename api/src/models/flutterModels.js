// Simulando um banco de dados de ervas
const herbs = [
  { 
    id: 1, 
    name: 'Aroeira', 
    description: 'É uma planta medicinal da espécie Schinus terebinthifolius.', 
    avoid: 'As cascas e folhas secas da aroeira são utilizadas contra febres, problemas do trato urinário, chá, no entanto, também pode ser usada para fazer banhos de assento, compressas ou pomadas, gripes e inflamações em geral.',
    details: 'Pode ser encontrada em ervanários, lojas de produtos naturais, farmácias de manipulação, mercados e algumas feiras livres, e deve ser usada com orientação de um médico ou outro profissional de saúde que tenha experiência com o uso de plantas medicinais.',
    problems: ['febre', 'inflamação', 'gripes', 'problemas urinários', 'inflamacao', 'urinarios', 'urinario', 'xixi', 'urina', 'gripe', 'resfriados', 'resfriado', 'urinários'],
  },
  { 
    id: 2, 
    name: 'Alecrim', 
    description: 'É uma erva aromática que pode melhorar o funcionamento do sistema nervoso.', 
    avoid: 'Atua como antioxidante, aliviar a dor, melhorar a circulação sanguínea, favorecer a digestão dos alimentos e proteger o fígado. Esse efeitos na saúde acontecem porque essa planta possui propriedades tônicas, antioxidantes, estimulantes, antissépticas, diuréticas, cicatrizantes e antimicrobianas.',
    details: 'O alecrim pode ser usado no preparo de chás, banhos de assento ou tintura, além de também poder ser utilizado para temperar alimentos. O nome científico do alecrim é Rosmarinus officinalis e pode ser encontrado em supermercados, lojas de produtos naturais, farmácias de manipulação e em algumas feiras livres.',
    problems: ['dor', 'digestão', 'circulação', 'fígado', 'dores', 'digestao', 'figado', 'circulacao', 'circulação do sangue', 'circulação de sangue', 'circulacao do sangue', 'circulacao de sangue'],  
  },
  { 
    id: 3, 
    name: 'Boldo',
    description: 'É uma planta muito utilizada para ajudar a tratar problemas do fígado.', 
    avoid: 'Embora tenha diversos benefícios para a saúde, o boldo também pode causar efeitos colaterais, principalmente quando é consumido em excesso ou por mais de 30 dias, além de ser contra-indicado para algumas pessoas. Possui propriedades diuréticas, anti-inflamatórias e antioxidantes, que podem ajudar no tratamento e prevenção de gastrite, aterosclerose e câncer.', 
    details: 'As duas espécies de boldo mais utilizadas são o boldo do Chile, conhecido como boldo verdadeiro (Peumus boldus Molina), que pode ser encontrado em lojas de produtos naturais na forma de folhas secas, em sachês para chás ou em cápsulas; e o boldo brasileiro, boldo africano ou falso boldo (Plectranthus barbatus) que é amplamente cultivado e encontrado em jardins no Brasil.',
    problems: ['fígado', 'digestão', 'inflamação', 'gastrite', 'aterosclerose', 'figado', 'digestao', 'inflamacao', 'inflamações', 'inflamacoes'],
  },
  { 
    id: 4, 
    name: 'Limoeiro',
    description: 'As folhas são ricas em compostos com poder antibiótico, como o linalol.', 
    avoid: 'Ajuda no tratamento de infecções de garganta e respiratórias, como no caso de gripes e resfriados. Além disso, o seu efeito expectorante e anti-inflamatório contribui para o alívio do desconforto causado por esses problemas e para prevenção e o tratamento de problemas como: Inflamações, devido a sua ação reguladora do sistema imunológico; Envelhecimento precoce da pele, uma vez que a pele é o principal órgão afetado pelo estresse oxidativo.', 
    details: 'Apesar de seus benefícios, o chá de folha deve ser usado com cautela, principalmente em casos de gravidez, amamentação ou uso de algum medicamento. Por isso, converse com seu médico antes de iniciar o uso regular do chá. Além disso, se depois de usar o ingrediente você sofrer com algum tipo de reação adversa, procure imediatamente o médico para saber como deve proceder a partir de então, não use como substituto de tratamentos convencionais para problemas de saúde. O chá deve ser usado apenas como um tratamento auxiliar.',
    problems: ['gripes', 'resfriados', 'inflamação', 'envelhecimento da pele', 'gripe', 'resfriado', 'inflamacao', 'pele', 'peles'],
  }, 
  { 
    id: 5, 
    name: 'Goiabeira', 
    description: 'É uma planta medicinal muito indicada para auxiliar no tratamento da diarreia,', 
    avoid: 'Essa planta é muito conhecida pelos seu fruto, a goiaba, no entanto, suas folhas possuem propriedades medicinais, no tratamento de diabetes, colesterol alto ou aliviar a dor, pois possui propriedades antiespasmódicas, anti-inflamatórias e antioxidantes. Estudos feitos em laboratório com células de câncer de mama, colo de útero, nasofaringe, próstata e colorretal mostraram que as substâncias da goiabeira podem ajudar a diminuir a proliferação ou aumentar a morte de células desses tipos de câncer.', 
    details: 'A goiabeira não deve ser usada por crianças, mulheres grávidas ou em amamentação, seja na forma de chá, tintura, óleo essencial ou compressas. Além disso, a goiabeira não é indicada para pessoas com problema de prisão de ventre, eczema, ou que tenham alergia a essa planta medicinal.As folhas de goiabeira podem ser usadas para compressas, banhos de assento ou tintura, por exemplo e pode ser encontrados em lojas de produtos naturais ou ervanárias, e devem ser usadas com orientação do médico ou de um profissional especializado em plantas medicinais.', 
    problems: ['diarreia', 'diabetes', 'colesterol alto', 'dor', 'diarréia', 'diabétes', 'dores', 'diabete', 'diarreia'],
  },
  { 
    id: 6, 
    name: 'Chá de Limão', 
    description: 'É uma fruta cítrica rica em vitamina C, antioxidantes e fibras solúveis.', 
    preparation: 'Este chá contém os óleos essenciais do limão que tem efeito purificante, além de ser delicioso para tomar depois de uma refeição, por exemplo.\nIngredientes:\nMeio copo de água;\nModo de preparo:\nFerver a água e depois adicionar a casca do limão. Tampar durante alguns minutos e tomar a seguir, ainda morno, sem adoçar.', 
    dosage: 'Adultos: Consumir de 1 a 3 xícaras de chá de limão por dia. Indicação: Pode ser consumido ao longo do dia para ajudar na digestão, aliviar sintomas de gripes e resfriados, ou para hidratar e fornecer vitamina C. É sempre bom consultar um médico ou fitoterapeuta para ajustar a posologia conforme suas necessidades específicas. O limão também pode ser consumido juntamente com água, podendo ser tomado em jejum, o que pode favorecer o processo de emagrecimento. É importante mencionar que para obter todos os benefícios mencionados anteriormente, o limão deve ser incluído em uma dieta equilibrada e saudável. ', 
    avoid: 'Ajuda a diminuir o apetite e regular o intestino, além disso previne a prisão de ventre, protege contra infecções devido ao limoneno, diminui a pressão arterial, ajuda a prevenir anemia porque contém vitamina C. O limão contém diversos compostos bioativos como os limonoides e flavonoides que possuem propriedades antitumorais, anti-inflamatórios e antioxidantes que evitam a formação de radicais livres, induzem a apoptose e inibem a proliferação celular.',
    problems: ['gripes', 'resfriados', 'digestão', 'infecções', 'gripe', 'resfriado', 'digestao', 'infecoes', 'infecoes', 'infecçoes'],
  },
  { 
    id: 7, 
    name: 'Chá de Hortelã', 
    description: 'O chá é refrescante e ajuda na digestão e é antioxidantes, analgésicas.', 
    preparation: 'Para preparar o chá de hortelã, deve-se ferver 150 ml de água, e quando começar a ferver, apagar o fogo. Depois, basta acrescentar 1 colher de sopa de folhas de hortelã, tampar, deixando descansar por 5 a 10 minutos, coar e beber. Os chás podem ser preparados com a hortelã comum ou com a hortelã-pimenta.', 
    dosage: 'A posologia do chá de hortelã geralmente depende do propósito de uso, seja para aliviar problemas digestivos, dores de cabeça ou como bebida refrescante. Aqui está uma recomendação geral: Adultos: Consumir de 1 a 3 xícaras de chá de hortelã por dia. Adultos: Consumir de 1 a 3 xícaras de chá de hortelã por dia. É aconselhável consultar um médico ou fitoterapeuta para ajustar a posologia de acordo com suas necessidades pessoais ou condições de saúde específicas.', 
    avoid: 'o chá de hortelã também tem ação antiparasitária, podendo ajudar a combater a infecção por parasitas, como amebíase e giardíase, digestivas, descongestionantes, anti-inflamatórias e antiespasmódicas, sendo uma ótima opção para melhorar a digestão e o cansaço, e aliviar as cólicas e a dor de cabeça, por exemplo. Por possuir propriedades anti-inflamatórias, antivirais, descongestionantes e expectorantes, o chá de hortelã diminui a tosse e a congestão nasal, ajudando a tratar resfriados, gripes e dores de garganta. Ajuda a aliviar os sintomas da menstruação, reduzindo a duração e a gravidade das cólicas menstruais, porque possui propriedades relaxantes, analgésicas e anti-inflamatórias.',
    problems: ['digestão', 'cólicas', 'dores de cabeça', 'infecções respiratórias', 'digestao', 'colica', 'colicas', 'dor de cabeça', 'dores de cabeca', 'infecçoes respiratorias', 'infecoes respiratorias', 'infecçao respiratória', 'infecao respiratoria', 'respiração', 'respirar', 'respiracao', 'infecoes', 'infecoes', 'infecçoes'],  
  },
  { 
    id: 8, 
    name: 'Chá de Camomila', 
    description: 'O chá de camomila possui propriedades anti-inflamatória e antiespasmódica.', 
    preparation: 'O chá de camomila pode ser preparado usando as flores secas da planta ou sachês, sendo vendidos em feiras, supermercados e lojas de produtos naturais, podendo ser preparado apenas com essa planta ou combinando outras ervas, como erva-doce e hortelã, por exemplo. Para fazer o chá de camomila, basta adicionar, em uma xícara (de chá) de água fervente,  1 colher de sopa (4 g) de flores de camomila desidratadas. Tampar, deixar repousar de 5 a 10 minutos, coar e beber de 2 a 4 xícaras do chá por dia.',
    dosage: 'A posologia do chá de camomila pode variar de acordo com o uso, como por exemplo para aliviar o estresse, melhorar o sono, ou tratar problemas digestivos. Aqui está uma recomendação geral: Adultos: Beber 1 a 2 xícaras de chá de camomila por dia, de preferência à noite para ajudar no relaxamento e no sono. Indicação: Usado principalmente para aliviar o estresse, melhorar a qualidade do sono, aliviar cólicas e distúrbios digestivos. Consulte um profissional de saúde para ajustar a posologia conforme necessário. Os possíveis efeitos colaterais que podem surgir com o uso da camomila são sono excessivo, náuseas, vômitos e irritação na pele, principalmente quando usada em quantidades maiores do que as recomendadas.', 
    avoid: 'O chá controla a produção de ácidos no estômago e ajudando a combater náuseas, má digestão e gases, e prevenir situações, como gastrite e úlceras gástricas. Além disso, o chá de camomila também contém apigenina, um composto bioativo que possui propriedades relaxantes, sendo indicado para ajudar a diminuir o estresse e a ansiedade, e melhorar a qualidade do sono. O chá de camomila é rico em luteolina, quercetina e esculetina, antioxidantes que evitam a oxidação das células de gordura, ajudando a equilibrar os níveis de colesterol total e colesterol “ruim”, o LDL, no sangue, prevenindo, assim, o surgimento que doenças, como infarto e derrame. Ajuda também no tratamento da ansiedade, estresse e hiperatividade, porque contém apigenina,',
    problems: ['ansiedade', 'insônia', 'digestão', 'náuseas', 'insonia', 'digestao', 'nauseas', 'tontura', 'insônias', 'insonias'],  
  },
  { 
    id: 9, 
    name: 'Chá de Gengibre', 
    description: 'O chá é rico em substâncias capazes de combater a dor de garganta.', 
    preparation: 'O chá pode ser preparado com o gengibre fresco ou em pó, e consumido sozinho ou com limão, canela, cúrcuma ou noz moscada, deixando a bebida mais nutritiva e saborosa.\nIngredientes:\n2 a 3 cm de gengibre fresco ralado; 180 mL de água.\nOutra forma de preparar o chá é colocando 1 colher de sopa de gengibre em pó em 1 litro de água.\nModo de preparo:\nColocar os ingredientes numa panela e deixar ferver por cerca de 8 a 10 minutos. Desligar o fogo, tampar a panela e quando estiver morno, coar e beber em seguida.', 
    dosage: 'A posologia do chá de gengibre pode variar de acordo com o objetivo, como alívio de dores de garganta, enjoo, ou como um anti-inflamatório natural. Aqui está uma recomendação geral: Adultos: Beber de 1 a 3 xícaras de chá de gengibre por dia. Indicação: Pode ser tomado para ajudar com dores de garganta, melhorar a digestão, aliviar náuseas ou ajudar em processos inflamatórios. Observações: O consumo excessivo de gengibre pode causar irritação no estômago. O chá de gengibre é contraindicado para pessoas com cálculos da vesícula, com irritação no estômago e pressão alta. É recomendável evitar mais de 3 xícaras ao dia. Consulte um médico se estiver grávida, tomando medicamentos anticoagulantes, ou se houver alguma condição médica específica. ', 
    avoid: 'O chá ajuda com resfriados e sintomas de má digestão, como náusea, cólica e vômitos. Além disso, por ser um potente antioxidante e anti-inflamatório, o chá de gengibre também ajuda na prevenção de algumas doenças como câncer, diabetes e obesidade. Por ter ação diurética e termogênica, o chá de gengibre também auxilia na eliminação do excesso de líquido do organismo e favorece a queima de gordura corporal, contribuindo para o emagrecimento.',
    problems: ['dor de garganta', 'resfriados', 'digestão', 'náuseas', 'dores de garganta', 'digestao', 'resfriado', 'garganta', 'dor', 'dores', 'garganta'],  
  },
  { 
    id: 10, 
    name: 'Chá de Canela', 
    description: 'O chá de canela possui propriedades antioxidantes e termogênicas.', 
    preparation: 'Para fazer o chá de canela, deve-se colocar 1g de pau de canela e 200 ml de água em uma panela, levando para ferver por 10 minutos. Depois, retirar o pau de canela e beber. Pode-se beber até 4 xícaras desse chá por dia e, de preferência, junto das refeições. O chá de canela também pode ser feito com a especiaria em pó, no entanto, o pau de canela é a forma preferencial, por conter mais óleos essenciais e propriedades benéficas.', 
    dosage: 'A posologia do chá de canela pode variar dependendo do propósito de uso, como melhorar a digestão, aliviar cólicas ou estimular a circulação sanguínea. Aqui está uma recomendação geral: \nAdultos:\nConsumir de 1 a 2 xícaras de chá de canela por dia.\nIndicações:\nConsumir após as refeições para ajudar na digestão ou em casos de resfriados leves, já que a canela tem propriedades aquecedoras e anti-inflamatórias.\nAtenção:\nO chá de canela deve ser consumido com moderação, especialmente por gestantes, pois em grandes quantidades pode causar contrações uterinas. ', 
    avoid: 'O chá é uma boa opção para fortalecer o sistema imunológico, ajudar na prevenção do envelhecimento precoce e promover o emagrecimento. Além disso, o chá de canela também tem ação analgésica, bactericida e anti-inflamatória, ajudando no alívio das cólicas menstruais, na prevenção da cárie e no tratamento da gengivite. No entanto, a ingestão de altas quantidades de chá de canela pode causar irritação na boca e lábios, suor, coriza, hipoglicemia, intoxicação no fígado, aumento dos batimentos do coração e da frequência respiratória. O chá de canela não deve ser consumido por mulheres grávidas ou que estejam amamentando. Esse chá também é contraindicado para crianças, pessoas com úlceras, gastrite ou que possuem doenças graves do fígado.',
    problems: ['digestão', 'resfriados', 'cólicas menstruais', 'digestao', 'resfriado', 'colicas menstruais', 'cólicas', 'cólica', 'colicas', 'colica', 'menstruação', 'menstruacao'],  
  },
  { 
    id: 11, 
    name: 'Chá de Erva-Cidreira', 
    description: 'Conhecida como cidreira ou melissa, alivia sintomas de estresse e ansiedade.', 
    preparation: 'O chá de erva-cidreira pode ser feito com as folhas frescas ou secas dessa planta, ou ainda com o uso de sachês individuais.\nIngredientes:\n1 colher (de sopa) de folhas frescas de erva-cidreira rasgadas;\n1 xícara (de chá) de água.\nModo de preparo:\nFerver a água em uma panela ou chaleira.\nApagar o fogo, acrescentar as folhas de erva-cidreira, tapar a panela e deixar repousar por 5 minutos. Em seguida, coar e beber ainda morno. Pode-se tomar até 3 xícaras (de chá) desse chá por dia.', 
    dosage: 'A posologia do chá de erva-cidreira (Melissa officinalis) é amplamente utilizada para fins de relaxamento, alívio da ansiedade e melhora da digestão. Adultos: Consumir 2 a 3 xícaras de chá de erva-cidreira por dia. Indicação: Consumido antes de dormir para ajudar no sono ou após as refeições para aliviar a digestão. Para uso prolongado ou tratamento de condições específicas, consulte um profissional de saúde. No entanto, o consumo do chá de erva-cidreira por mais de 2 semanas e/ou em altas quantidades, pode diminuir a frequência cardíaca e a pressão arterial, e causar dor de cabeça, náusea, vômitos, tontura e dor no estômago.', 
    avoid: 'além de combater o excesso de gases e as dores, como cólica menstrual e dor de cabeça. Esses benefícios são possíveis porque o chá de erva-cidreira contém compostos fenólicos, como ácido rosmarínico, citral e geraniol, que têm propriedades digestivas, analgésicas, sedativas e anti-inflamatórias. Por conter linalol, ácido rosmarínico e citral, que são compostos bioativos com ação analgésica, relaxante e anti-inflamatória, o chá de erva-cidreira ajuda a relaxar os músculos, liberar a tensão e relaxar os vasos sanguíneos, aliviando a dor de cabeça, a dor de dente, a dor muscular e a dor na barriga. Além disso, pessoas que estejam usando medicamentos sedativos devem sempre conversar com um médico antes de tomar o chá de erva-cidreira.',
    problems: ['ansiedade', 'estresse', 'cólicas', 'gases', 'dores de cabeça', 'estresses', 'cólicas menstruais', 'colicas menstruais', 'cólicas', 'cólica', 'colicas', 'colica', 'gazes', 'dor de cabeça', 'mentruação', 'mesntruacao', 'cabeça', 'cabeca', 'dor', 'dores'], 
  },
];
// Retornar todas as ervas
const getAllHerbs = () => herbs;

// Retornar uma erva pelo ID
const getHerbById = (id) => herbs.find(herb => herb.id === id);

const getHerbsByProblem = (problem) => {
  return herbs.filter(herb => Array.isArray(herb.problems) && herb.problems.includes(problem.toLowerCase()));
};

module.exports = {
  getAllHerbs,
  getHerbById,
  getHerbsByProblem,
};
