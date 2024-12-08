document.addEventListener('DOMContentLoaded', function () {
    var classSelect = document.getElementById("class");
    var raceSelect = document.getElementById("race");
    var descriptionTextClass = document.getElementById("description-text-class");
    var descriptionRowClass = document.getElementById("class-description");

    var descriptionTextRace = document.getElementById("description-text-race");
    var descriptionQuestionRace = document.getElementById("description-question-race");
    var descriptionRowRace = document.getElementById("race-description");

    function showDescription() {
        var selectedOption = classSelect.options[classSelect.selectedIndex];

        var description = selectedOption.getAttribute('data-description');

        if (description) {
            descriptionTextClass.textContent = description;
            descriptionRowClass.style.display = "block";
        } else {
            descriptionRowClass.style.display = "none";
        }
    }

    function showDescriptionAndQuestion() {
        var selectedOption = raceSelect.options[raceSelect.selectedIndex];

        var description = selectedOption.getAttribute('data-description');
        var question = selectedOption.getAttribute('data-question');

        if (description) {
            descriptionTextRace.textContent = description;
            descriptionQuestionRace.textContent = question;
            descriptionRowRace.style.display = "block";
        } else {
            descriptionRowRace.style.display = "none";
        }
    }


    classSelect.addEventListener('change', showDescription);
    raceSelect.addEventListener('change', showDescriptionAndQuestion);
});
