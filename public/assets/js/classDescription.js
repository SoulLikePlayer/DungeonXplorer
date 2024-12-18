document.addEventListener('DOMContentLoaded', function () {
    var classSelect = document.getElementById("class");
    var raceSelect = document.getElementById("race");
    var descriptionTextClass = document.getElementById("description-text-class");
    var descriptionRowClass = document.getElementById("class-description");

    var descriptionTextRace = document.getElementById("description-text-race");
    var descriptionQuestionRace = document.getElementById("description-question-race");
    var descriptionRowRace = document.getElementById("race-description");

    var talentRow = document.getElementById("race-talent");
    var talentName = document.getElementById("talent-name");
    var talentDesc = document.getElementById("talent-desc");

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
        const talentId = selectedOption.dataset.talentId; 
        document.getElementById('talent_id').value = talentId || '';
       
        var description = selectedOption.getAttribute('data-description');
        var question = selectedOption.getAttribute('data-question');
    
        var talentNameText = selectedOption.getAttribute('data-talent-name');
        var talentDescText = selectedOption.getAttribute('data-talent-desc');
    
        if (description) {
            descriptionTextRace.textContent = description;
            descriptionQuestionRace.textContent = question;
            descriptionRowRace.style.display = "block";
        } else {
            descriptionRowRace.style.display = "none";
        }
    
        if (talentNameText && talentDescText) {
            talentName.textContent = talentNameText;
            talentDesc.textContent = talentDescText;
            talentRow.style.display = "block";
        } else {
            talentRow.style.display = "none";
        }
    }    


    classSelect.addEventListener('change', showDescription);
    raceSelect.addEventListener('change', showDescriptionAndQuestion);
});
