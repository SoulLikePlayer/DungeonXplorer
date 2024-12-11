<div id="levelUpModal" class="modal">
  <div class="modal-content">
    <h3>Félicitations, vous avez atteint un nouveau niveau !</h3>
    <p>Vous êtes maintenant au niveau <strong><?= $newLevel ?></strong>.</p>
    <p>Voici vos nouveaux bonus :</p>
    <ul>
      <li>PV maximum : <strong>+<?= $pvBonus ?></strong></li>
      <li>Mana maximum : <strong>+<?= $manaBonus ?></strong></li>
      <li>Force : <strong>+<?= $strengthBonus ?></strong></li>
      <li>Initiative : <strong>+<?= $initiativeBonus ?></strong></li>
    </ul>
    <button id="continueButton">Continuer l'aventure</button>
  </div>
</div>
