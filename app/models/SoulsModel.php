<?php
class SoulsModel extends Model {
    public function getSoulByItemId($id) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("SELECT * FROM Souls WHERE item_id = :id");
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function getAllCapacityBySoulsId($soulId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("SELECT sc.CapacityId as id, sc.name, sc.description FROM SoulCapacity sc
                              WHERE sc.SoulId = :soulId");
        $stmt->bindParam(':soulId', $soulId, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function ApplyHeroEffect($heroId, $capacityId) {
        $db = $this->getDatabaseConnection();

        $stmt = $db->prepare("INSERT INTO HeroCapacity (Hero_id, Capacity_id) VALUES (:heroId, :capacityId)");
        $stmt->bindParam(':heroId', $heroId, PDO::PARAM_INT);
        $stmt->bindParam(':capacityId', $capacityId, PDO::PARAM_INT);

        return $stmt->execute();
    }
}
