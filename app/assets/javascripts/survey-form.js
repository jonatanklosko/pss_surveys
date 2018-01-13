{
  const surveyAnswers = document.querySelectorAll('.survey-form .survey-answer');
  const ratingRadios = document.querySelectorAll('.survey-form .survey-answer input[type="radio"]');
  const ratingMeanBox = document.querySelector('.survey-form .rating-mean');
  const submitButton = document.querySelector('.survey-form input[type="submit"]');

  const onRatingChange = () => {
    const checkedratingRadios = Array.from(ratingRadios).filter(radio => radio.checked);
    const ratings = checkedratingRadios.map(radio => parseInt(radio.value));
    if (ratings.length > 0) {
      const mean = ratings.reduce((a, b) => a + b) / ratings.length;
      ratingMeanBox.innerText = mean.toFixed(2);
    }
    const allRatingsSet = (surveyAnswers.length === checkedratingRadios.length);
    submitButton.disabled = !allRatingsSet;
  }

  ratingRadios.forEach(radio => radio.addEventListener('change', onRatingChange));
  onRatingChange();
}
