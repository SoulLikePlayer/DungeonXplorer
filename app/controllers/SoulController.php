<?php
class SoulController extends Controller {
    public function getSoulCapacity($itemId) {
        ob_clean();
        header('Content-Type: application/json');

        if (!isset($_SESSION['user']['hero']['hero_id'])) {
            echo json_encode(['success' => false, 'message' => 'Héros non trouvé']);
            exit;
        }

        $soulModel = new SoulsModel();
        $soul = $soulModel->getSoulByItemId($itemId);

        if (!$soul) {
            echo json_encode(['success' => false, 'message' => 'Âme non trouvée']);
            exit;
        }

        $soulId = $soul['soul_id'];
        $capacities = $soulModel->getAllCapacityBySoulsId($soulId);

        ob_clean();
        if ($capacities) {
            echo json_encode(['success' => true, 'capacities' => $capacities]);
        } else {
            echo json_encode(['success' => false, 'message' => 'Aucune capacité trouvée']);
        }
        exit;
    }

    public function applyEffect() {
        ob_clean();
        header('Content-Type: application/json');

        if (!isset($_SESSION['user']['hero']['hero_id'])) {
            echo json_encode(['success' => false, 'message' => 'Héros non trouvé']);
            exit;
        }

        $heroId = $_SESSION['user']['hero']['hero_id'];
        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['capacityId'])) {
            echo json_encode(['success' => false, 'message' => 'ID de la capacité manquant']);
            exit;
        }

        $capacityId = $data['capacityId'];
        $soulModel = new SoulsModel();
        $result = $soulModel->ApplyHeroEffect($heroId, $capacityId);

        $inventoryModel = new Inventory();
        $inventoryModel->removeItemFromInventory($heroId, $data["item"], 1);

        $heroModel = new Hero();
        
        $_SESSION['user']['hero'] = $heroModel->getHeroById($heroId);
        $_SESSION['user']['hero']['passif'] = $heroModel->getCompetenceByHeroId($heroId, "passif");
        $_SESSION['user']['hero']['compétence'] = $heroModel->getCompetenceByHeroId($heroId, "compétence");

        ob_clean();
        if ($result) {
            echo json_encode(['success' => true, 'message' => 'Effet appliqué avec succès']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Erreur lors de l\'application de l\'effet']);
        }
        exit;
    }
}
