def create_questionnaire(instrument, questions_and_options)
  questions_and_options.each do |item|
    question = instrument.questions.create!(description: item[:question])
    item[:options].each do |option|
      question.options.create!(description: option[:description], weight: option[:weight])
    end
  end
end

depression = Instrument.create!(name: 'Teste de Depressão',
                                description: 'Avalia probalidade de depressão')
anxiety = Instrument.create!(name: 'Teste de Ansiedade Geral',
                             description: 'Avalia possibilidade de quadro ansioso')
emotional_intelligence = Instrument.create!(name: 'Inteligência Emocional',
                                            description: 'Avalia capacidade de reconhecer, interpretar e lidar com emoções')

depression_questions_and_options = [
  {
    question: 'Como você tem se sentido?',
    options: [
      { description: 'Muito triste', weight: 3 },
      { description: 'Triste', weight: 2 },
      { description: 'Neutro', weight: 1 },
      { description: 'Feliz', weight: 0 }
    ]
  },
  {
    question: 'Você sente que perdeu interesse nas coisas em geral',
    options: [
      { description: 'Muito', weight: 3 },
      { description: 'Moderadamente', weight: 2 },
      { description: 'Não muito', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem tido dificuldade para dormir?',
    options: [
      { description: 'Sim, muita', weight: 3 },
      { description: 'Um pouco', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem tido pensamentos negativos',
    options: [
      { description: 'Sim, muitos', weight: 3 },
      { description: 'Um pouco', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem se sentido sem energia?',
    options: [
      { description: 'Sim, demais', weight: 3 },
      { description: 'Um pouco', weight: 2 },
      { description: 'Levemente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  }
]

anxiety_questions_and_options = [
  {
    question: 'Você tem tido dificuldades para relaxar?',
    options: [
      { description: 'Sim, muita', weight: 3 },
      { description: 'Não muita', weight: 2 },
      { description: 'Levemente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem sentido medo de que algo ruim aconteça?',
    options: [
      { description: 'Sim, demais', weight: 3 },
      { description: 'Moderadamente', weight: 2 },
      { description: 'Não muito', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem sentido tontura?',
    options: [
      { description: 'Sim, muita', weight: 3 },
      { description: 'Um pouco', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Na última semana você ficou nervoso(a)?',
    options: [
      { description: 'Sim, frequentemente', weight: 3 },
      { description: 'Algumas vezes', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  },
  {
    question: 'Você tem tido dificuldades para respirar?',
    options: [
      { description: 'Sim, demais', weight: 3 },
      { description: 'Um pouco', weight: 2 },
      { description: 'Levemente', weight: 1 },
      { description: 'Não', weight: 0 }
    ]
  }
]

emotional_intelligence_questions_and_options = [
  {
    question: 'Você sabe identificar as emoções que sente?',
    options: [
      { description: 'Sempre', weight: 3 },
      { description: 'Frequentemente', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Nunca', weight: 0 }
    ]
  },
  {
    question: 'Você sabe se acalmar quando se sente inquieto ou chateado?',
    options: [
      { description: 'Sempre', weight: 3 },
      { description: 'Frequentemente', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Nunca', weight: 0 }
    ]
  },
  {
    question: 'Você define metas a longo prazo?',
    options: [
      { description: 'Sempre', weight: 3 },
      { description: 'Frequentemente', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Nunca', weight: 0 }
    ]
  },
  {
    question: 'Você é um bom ouvinte?',
    options: [
      { description: 'Sempre', weight: 3 },
      { description: 'Frequentemente', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Nunca', weight: 0 }
    ]
  },
  {
    question: 'Você sabe suas qualidades e defeitos?',
    options: [
      { description: 'Sempre', weight: 3 },
      { description: 'Frequentemente', weight: 2 },
      { description: 'Raramente', weight: 1 },
      { description: 'Nunca', weight: 0 }
    ]
  }
]

create_questionnaire(depression, depression_questions_and_options)
create_questionnaire(anxiety, anxiety_questions_and_options)
create_questionnaire(emotional_intelligence, emotional_intelligence_questions_and_options)
