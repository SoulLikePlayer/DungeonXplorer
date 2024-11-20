<?php

class Combat {
    public static function determineInitiative($hero, $monster) {
        // Calcul de l'initiative pour le héros et le monstre
        $hero_initiative = rand(1, 6) + $hero['initiative'];
        $monster_initiative = rand(1, 6) + $monster['initiative'];

        // Gestion de l'égalité : le monstre passe en premier sauf si le héros est un Voleur
        if ($hero_initiative === $monster_initiative) {
            if ($hero['class_id'] == 2) { // Voleur gagne en cas d'égalité
                return 'hero';
            } else {
                return 'monster';
            }
        }

        return ($hero_initiative > $monster_initiative) ? 'hero' : 'monster';
    }

    public static function attack($attacker, $defender) {
        // Calcul des dégâts de l'attaque
        $attack = rand(1, 6) + $attacker['strength']; // On pourrait ajouter un bonus d'arme ici
        $defense = rand(1, 6) + (int)($defender['strength'] / 2); // On pourrait ajouter un bonus d'armure ici

        // Calcul des dégâts infligés
        $damage = max(0, $attack - $defense);
        
        // Réduction des PV du défenseur
        $defender['pv'] -= $damage;

        return $damage;
    }
}
?>
