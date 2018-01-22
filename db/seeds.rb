unless Rails.env.test?
  competitor_survey_questions = [{
      question: "Kontakt ze społecznością przed wydarzeniem",
      description: ""
    }, {
      question: "Dostosowanie wielkości obiektu do liczby uczestników",
      description: ""
    }, {
      question: "Komfort przebywania na sali",
      description: ""
    }, {
      question: "Komfort układania oraz przebywania w strefie startowej",
      description: ""
    }, {
      question: "Oświetlenie stanowisk startowych",
      description: ""
    }, {
      question: "Prowadzenie zawodów",
      description: ""
    }, {
      question: "Budowa harmonogramu",
      description: ""
    }, {
      question: "Realizacja harmonogramu",
      description: ""
    }, {
      question: "Rozwiązania żywieniowe",
      description: ""
    }, {
      question: "Obsługa sędziowska",
      description: ""
    }, {
      question: "Prezentacja wyników",
      description: ""
    }, {
      question: "Ogólna atmosfera",
      description: ""
    }
  ].map! { |attributes| attributes.merge! delegate: false }

  SurveyQuestion.create! competitor_survey_questions

  delegate_survey_questions = [{
      question: "Współpraca z organizatorem przed oraz po zawodach",
      description: ""
    }, {
      question: "Otwarcie imprezy",
      description: ""
    }, {
      question: "Przygotowanie scen startowych",
      description: ""
    }, {
      question: "Przygotowanie strefy mieszaczy",
      description: ""
    }, {
      question: "Przygotowanie poczekalni",
      description: ""
    }, {
      question: "Przygotowanie strefy rejestratora wyników i zaplecza technicznego",
      description: ""
    }, {
      question: "Przygotowanie dokumentacji turniejowej",
      description: ""
    }, {
      question: "Praca sędziów i mieszaczy",
      description: ""
    }
  ].map! { |attributes| attributes.merge! delegate: true }

  SurveyQuestion.create! delegate_survey_questions
end
