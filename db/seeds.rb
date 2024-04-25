def create_questionnaire(instrument, questions_and_options)
  questions_and_options.each do |item|
    question = instrument.questions.create!(description: item[:question])
    item[:options].each do |option|
      question.options.create!(description: option[:description], weight: option[:weight])
    end
  end
end

begin
  depression = { instrument: Instrument.create!(name: 'Teste de Depressão',
                                                description: 'Avalia probalidade de depressão') }
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
  depression[:questions_and_options] = depression_questions_and_options

  anxiety = { instrument: Instrument.create!(name: 'Teste de Ansiedade Geral',
                                             description: 'Avalia possibilidade de quadro ansioso') }
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
  anxiety[:questions_and_options] = anxiety_questions_and_options

  emotional_intelligence = { instrument: Instrument.create!(name: 'Inteligência Emocional',
                                                            description: 'Avalia capacidade de reconhecer, interpretar e lidar com emoções') }
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
      question: 'Você reconhece como seu comportamento afeta os outros?',
      options: [
        { description: 'Sempre', weight: 3 },
        { description: 'Frequentemente', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Nunca', weight: 0 }
      ]
    }
  ]
  emotional_intelligence[:questions_and_options] = emotional_intelligence_questions_and_options

  empathy = { instrument: Instrument.create!(name: 'Teste de Empatia',
                                             description: 'Avalia níveis de empatia do avaliado') }
  empathy_questions_and_options = [
    {
      question: 'Você tem dificuldade para entender as emoções dos outros?',
      options: [
        { description: 'Sim, muita', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você acha divertido intimidar as pessoas de vez em quando?',
      options: [
        { description: 'Sim, demais', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você percebe quando alguém está com medo?',
      options: [
        { description: 'Sim, sempre', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'É óbvio para você quando as pessoas fingem que estão felizes?',
      options: [
        { description: 'Sim, sempre', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você gosta de ver as pessoas ficarem com raiva?',
      options: [
        { description: 'Sim, demais', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    }
  ]
  empathy[:questions_and_options] = empathy_questions_and_options

  stress_level = { instrument: Instrument.create!(name: 'Grau de Estresse',
                                                  description: 'Avalia grau de estresse do avaliado') }
  stress_level_questions_and_options = [
    {
      question: 'Com qual frequência você tem olhado para o relógio sem necessidade?',
      options: [
        { description: 'Muitas vezes', weight: 3 },
        { description: 'Algumas vezes', weight: 2 },
        { description: 'Poucas vezes', weight: 1 },
        { description: 'Nunca', weight: 0 }
      ]
    },
    {
      question: 'Você tem se sentido mais tenso nas suas atividades cotidianas?',
      options: [
        { description: 'Sim, demais', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você tem perdido o controle emocional quando se sente frustrado?',
      options: [
        { description: 'Sim, demais', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você sente angústia ou inquietação quanto fica sem fazer nada?',
      options: [
        { description: 'Sim, sempre', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    },
    {
      question: 'Você se sente sobrecarregado pelas responsabilidades do cotidiano?',
      options: [
        { description: 'Sim, demais', weight: 3 },
        { description: 'Um pouco', weight: 2 },
        { description: 'Raramente', weight: 1 },
        { description: 'Não', weight: 0 }
      ]
    }
  ]
  stress_level[:questions_and_options] = stress_level_questions_and_options

  instrument_hashes = [depression, anxiety, emotional_intelligence, empathy, stress_level]

  instrument_hashes.each { |i| create_questionnaire(i[:instrument], i[:questions_and_options]) }
rescue StandardError => e
  Instrument.destroy_all if Instrument.any?
  puts "Aborted: #{e}"
end
