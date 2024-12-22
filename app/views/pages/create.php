<h2 id="title-creation">Créer un personnage</h2>

<?php if (isset($error)): ?>
    <div class="error"><?= htmlspecialchars($error) ?></div>
<?php endif; ?>

<?php if (isset($success)): ?>
    <div class="success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<main>
    <div class="form-creation">
        <form action="/DungeonXplorer/hero/store" method="POST">
            <div class="form-container">
                <!-- Colonne de gauche avec les champs de sélection -->
                <div class="left-column">
                    <div class="row">
                        <div class="col-25">
                            <label for="lastname">Nom du personnage</label>
                        </div>
                        <div class="col-75">
                            <input type="text" name="lastname" id="lastname" required>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-25">
                            <label for="firstname">Prénom du personnage</label>
                        </div>
                        <div class="col-75">
                            <input type="text" name="firstname" id="firstname" required>
                        </div>
                    </div>
                    <input type="hidden" name="talent_id" id="talent_id" value="">

                    <div class="row">
                        <div class="col-25">
                            <label for="class">Classe du personnage</label>
                        </div>
                        <div class="col-75">
                            <select name="class" id="class" required>
                                <option value="" disabled selected>Sélectionner une classe</option>
                                <?php foreach ($classes as $class): ?>
                                    <option value="<?= htmlspecialchars($class['name']) ?>" 
                                            data-description="<?= htmlspecialchars($class['description']) ?>"
                                            data-image="<?= htmlspecialchars($class['imageName']) ?>">
                                        <?= htmlspecialchars($class['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-25">
                            <label for="race">Race du personnage</label>
                        </div>
                        <div class="col-75">
                            <select name="race" id="race" required>
                                <option value="" disabled selected>Sélectionner une race</option>
                                <?php foreach ($races as $race): ?>
                                    <option value="<?= htmlspecialchars($race['name']) ?>" 
                                            data-description="<?= htmlspecialchars($race['description']) ?>"
                                            data-question="<?= htmlspecialchars($race['question']) ?>"
                                            data-talent-name="<?= htmlspecialchars($raceTalents[$race['name']]['name']) ?>"
                                            data-talent-desc="<?= htmlspecialchars($raceTalents[$race['name']]['description']) ?>"
                                            data-talent-id="<?= htmlspecialchars($raceTalents[$race['name']]['id']) ?? null ?>">
                                        <?= htmlspecialchars($race['name']) ?>
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-25">
                            <label for="bio">Biographie/Histoire du personnage</label>
                        </div>
                        <div class="col-75">
                            <textarea id="bio" name="bio" placeholder="Écrivez quelque chose.."></textarea>
                        </div>
                    </div>
                </div>

                <!-- Colonne de droite pour afficher les descriptions -->
                <div class="right-column">
                    <div class="row" id="class-description" style="display:none;">
                        <h3>Description de la classe :</h3>
                        <p id="description-text-class"></p>
                    </div>
                    <div class="row" id="class-image" style="display:none;">
                        <img id="image-class" src="" alt="Image de la classe" style="width: 50%; height: auto;">
                    </div>
                    <div class="row" id="race-description" style="display:none;">
                        <h3>Description de la race :</h3>
                        <p id="description-text-race"></p>
                        <p id="description-question-race"></p>
                    </div>
                    <div class="row" id="race-talent" style="display:none;">
                        <h3>Talent de la race :</h3>
                        <p id="talent-name"></p>
                        <p id="talent-desc"></p>
                    </div>
                </div>

            </div>

            <div>
                <button type="submit">Créer le personnage</button>
            </div>
        </form>
    </div>
</main>

<script src="../public/assets/js/DescriptionHeroSystem.js"></script>
