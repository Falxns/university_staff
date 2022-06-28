data = {
  title: 'Cеверная и Центральная Америка. Население',
  difficulty: 3,
  endDate: '20.06.2022',
  questionsToAdd: [
    {
      type: questionTypes.chooseAnswer,
      question: 'Уровень урбанизации США и Канады составляет более 80%.',
      answers: [
        {
          text: 'Неверное утверждение',
          isCorrect: false,
        },{
          text: 'Верное утверждение',
          isCorrect: true,
        }
      ],
    },{
      type: questionTypes.openQuestion,
      question: 'Как называется форма расселения, образующаяся при объединении городских агломераций?',
      correctAnswer: 'Мегалополис',
    },{
      type: questionTypes.insertWords,
      question: 'Страна обладает ... промышленностью, базирующейся на ... сырьевой базе и ... резервах дешёвой рабочей силы.',
      correctAnswers: ['многоотраслевой', 'богатой', 'больших'],
    },
  ],
};

response = {
  mark: '90%',
  answers: [...],
  wrongAnswers: [
    {
      question: 'Уровень урбанизации США и Канады составляет более 80%.',
      chosenAnswer: 'Неверное утверждение',
      correctAnswer: 'Верное утверждение',
    }
  ],
};