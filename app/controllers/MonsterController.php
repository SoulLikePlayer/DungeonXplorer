<?php

class MonsterController extends Controller {

    // Récupère les informations complètes d'un monstre par son ID
    public function getMonster($monsterId) {
        header('Content-Type: application/json');

        $monsterModel = new Monster();

        $monster = $monsterModel->getMonsterById($monsterId);

        if ($monster) {
            $loots = $monsterModel->getLootById($monsterId);
            $attacks = $monsterModel->getAttacksByMonsterId($monsterId);

            $data = [
                'success' => true,
                'monster' => [
                    'id' => (int)$monster['id'],
                    'name' => html_entity_decode($monster['name']),
                    'stats' => [
                        'pv' => (int)$monster['pv'],
                        'mana' => (int)$monster['mana'],
                        'initiative' => (int)$monster['initiative'],
                        'strength' => (int)$monster['strength'],
                        'xp' => $monster['xp'],
                        'ost' => htmlspecialchars($monster['ost'])
                    ],
                    'loot' => $loots,
                    'attacks' => $attacks
                ]
            ];
        } else {
            $data = ['success' => false, 'message' => 'Monstre non trouvé.'];
        }
        ob_clean();
        echo json_encode($data);
        exit;
    }

    public function updateMonster() {
        header('Content-Type: application/json');
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['monsterId'])) {
            echo json_encode(['success' => false, 'message' => 'ID du monstre manquant.']);
            exit;
        }

        $monsterId = (int)$data['monsterId'];
        $newName = isset($data['name']) ? htmlspecialchars($data['name']) : null;
        $newStats = isset($data['stats']) ? $data['stats'] : [];
        $newXp = isset($data['xp']) ? (int)$data['xp'] : null;

        $updatedData = [
            'name' => $newName,
            'pv' => isset($newStats['pv']) ? (int)$newStats['pv'] : null,
            'mana' => isset($newStats['mana']) ? (int)$newStats['mana'] : null,
            'initiative' => isset($newStats['initiative']) ? (int)$newStats['initiative'] : null,
            'strength' => isset($newStats['strength']) ? (int)$newStats['strength'] : null,
            'xp' => $newXp
        ];

        $monsterModel = new Monster();
        $updateSuccess = $monsterModel->updateMonster($monsterId, $updatedData);

        ob_clean();
        if ($updateSuccess) {
            echo json_encode(['success' => true, 'message' => 'Monstre mis à jour avec succès.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Erreur lors de la mise à jour du monstre.']);
        }

        exit;
    }

    // Récupère la liste de tous les monstres
    public function getAllMonsters() {
        header('Content-Type: application/json');

        $monsterModel = new Monster();
        $monsters = $monsterModel->getAllMonsters();

        if ($monsters) {
            echo json_encode(['success' => true, 'monsters' => $monsters]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Aucun monstre trouvé.']);
        }

        exit;
    }
}
