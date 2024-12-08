document.addEventListener('DOMContentLoaded', function () {
    const npcContainer = document.getElementById('npcContainer');
    const dialogues = JSON.parse(npcContainer.dataset.dialogues);
    const firstSentence = npcContainer.dataset.firstSentence;
    let currentDialogueIndex = 0;
    let previousDialogues = [];
    const npcDialogueContainer = document.querySelector('.npc-dialogue');
    const npcChoicesContainer = document.querySelector('.npc-choices');

    npcDialogueContainer.innerHTML = firstSentence;

    function showNextDialogue() {
        let nextDialogues = [];
    
        for (let i = currentDialogueIndex; i < dialogues.length; i++) {
            const dialogue = dialogues[i];
    
            if (dialogue.condition === 0 || previousDialogues.includes(dialogue.condition)) {
                nextDialogues.push(dialogue);
                console.log(previousDialogues);
            }
        }

    
        if (nextDialogues.length > 0) {
            npcChoicesContainer.innerHTML = ''; 
    
            nextDialogues.forEach(dialogue => {
                const choiceButton = document.createElement('button');
                choiceButton.classList.add("ChoiceButton");
                choiceButton.innerText = dialogue.choix;
                npcChoicesContainer.appendChild(choiceButton);
    
                choiceButton.addEventListener('click', function () {
                    npcDialogueContainer.innerHTML = dialogue.reponse;
                    previousDialogues.push(dialogue.id_dialogue);
    
                    if (dialogue.is_end === 1) {
                        npcChoicesContainer.innerHTML = '';

                        const continueButton = document.createElement('button');
                        continueButton.textContent = "Continuer l'aventure";
                        continueButton.id = "continueButton";
                        continueButton.addEventListener('click', function () {
                            window.location.href = `/DungeonXplorer/chapter/view/${npcContainer.dataset.nextChapterId}`;
                        });
                        npcChoicesContainer.appendChild(continueButton);
                    } else {
                        currentDialogueIndex = dialogues.findIndex(d => d.id_dialogue === dialogue.id_dialogue) + 1;
                        showNextDialogue();
                    }
                });
            });
        } else {
            console.log('Aucun dialogue disponible à afficher.');
        }
    }
    
    showNextDialogue();
});
