unless Rails.env.test?
  competitor_survey_questions = [{
      id: 1,
      question: "Kontakt ze społecznością przed wydarzeniem",
      description: "Czy na stronie www znalazły się ważne dla Ciebie informacje? Czy organizator prowadził wydarzenie na Facebooku lub inną formę komunikacji z uczestnikami? Jak oceniasz kontakt z organizatorem przed wydarzeniem, jeżeli taki miał miejsce?"
    }, {
      id: 2,
      question: "Dostosowanie wielkości obiektu do liczby uczestników",
      description: "Czy na sali było wystarczająco dużo miejsca dla wszystkich uczestników? Czy było wystarczająco dużo stołów i miejsc siedzących? Czy można było się swobodnie przemieszczać?"
    }, {
      id: 3,
      question: "Komfort przebywania na sali",
      description: "Jak oceniasz rozplanowanie przestrzeni, umeblowanie, temperaturę, oświetlenie obiektu itp.?"
    }, {
      id: 4,
      question: "Komfort układania oraz przebywania w strefie startowej",
      description: "Czy przy stanowiskach startowych było wygodnie? Czy było wystarczająco dużo miejsca? Czy publiczność znajdowała się w odpowiedniej odległości? Czy pozostali zawodnicy i obsługa poruszająca się po scenie nie przeszkadzali w układaniu?"
    }, {
      id: 5,
      question: "Oświetlenie stanowisk startowych",
      description: "Czy oświetlenie odpowiadało Twoim preferencjom? Czy nie było za ciemno lub czy oświetlenie boczne nie było za mocne?"
    }, {
      id: 6,
      question: "Prowadzenie zawodów",
      description: "Jak oceniasz pracę konferansjera prowadzącego turniej? Czy konferansjer aktywnie budował dobrą atmosferę? Czy podawane były najważniejsze informacje? Czy praca konferansjera ubogacała wydarzenie?"
    }, {
      id: 7,
      question: "Budowa harmonogramu",
      description: "Jak podobają Ci się zastosowane rozwiązania takie jak: czas trwania, godziny rozpoczęcia i zakończenia, zestaw konkurencji, liczba rund, kolejność rund, cut-offy, limity, liczby awansujących zawodników itp.?"
    }, {
      id: 8,
      question: "Realizacja harmonogramu",
      description: "Czy miały miejsce opóźnienia lub długie przerwy? Czy w trakcie turnieju zmieniły się planowane założenia (liczba rund, awansujących zawodników itp.)?"
    }, {
      id: 9,
      question: "Rozwiązania żywieniowe",
      description: "Czy odpowiadały Ci rozwiązania żywieniowe zaproponowane przez organizatorów? Czy zorganizował zamówienie czy też poprzestał na poleceniu lokali gastronomicznych? Jak oceniasz stosunek ceny do jakości? Czy mogłeś wygodnie spożyć posiłek?"
    }, {
      id: 10,
      question: "Obsługa sędziowska",
      description: "Jak oceniasz rozwiązania  w tym zakresie? Czy organizator zadbał o sędziów zewnętrznych czy zaangażował uczestników turnieju? Jak oceniasz profesjonalizm zespołu sędziowskiego? (kwalifikacje, ubiór, nastawienie)"
    }, {
      id: 11,
      question: "Prezentacja wyników",
      description: "Czy organizator zapewnił rzutnik lub telewizor do wyświetlania bieżących wyników? Jak oceniasz jakość tych sprzętów? Czy prezentowane materiały były czytelne? Czy wywieszane były wyniki rund zamkniętych?"
    }, {
      id: 12,
      question: "Ogólna atmosfera",
      description: "Jakie jest Twoje ogólne wrażenie jako uczestnika wydarzenia? Czy poczułeś się częścią społeczności? Czy poleciłbyś innym podobne wydarzenie?"
    }
  ].map! { |attributes| attributes.merge! delegate: false }

  SurveyQuestion.create! competitor_survey_questions

  delegate_survey_questions = [{
      id: 13,
      question: "Współpraca z organizatorem przed oraz po zawodach",
      description: ""
    }, {
      id: 14,
      question: "Otwarcie imprezy",
      description: ""
    }, {
      id: 15,
      question: "Przygotowanie scen startowych",
      description: ""
    }, {
      id: 16,
      question: "Przygotowanie strefy mieszaczy",
      description: ""
    }, {
      id: 17,
      question: "Przygotowanie poczekalni",
      description: ""
    }, {
      id: 18,
      question: "Przygotowanie strefy rejestratora wyników i zaplecza technicznego",
      description: ""
    }, {
      id: 19,
      question: "Przygotowanie dokumentacji turniejowej",
      description: ""
    }, {
      id: 20,
      question: "Praca sędziów i mieszaczy",
      description: ""
    }
  ].map! { |attributes| attributes.merge! delegate: true }

  SurveyQuestion.create! delegate_survey_questions
end
