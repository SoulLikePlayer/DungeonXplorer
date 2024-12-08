<?php

class NPC extends Model {
    public function getNPCById($NPCId) {
        // Connexion à la base de données
        $db = $this->getDatabaseConnection();

        $NPCQuery = 'SELECT * FROM NPC WHERE id = :NPCid';
        $NPCStmt = $db->prepare($NPCQuery);
        $NPCStmt->bindParam(':NPCid', $NPCId);
        $NPCStmt->execute();

        $resultNPC = $NPCStmt->fetch(PDO::FETCH_ASSOC);

        if ($resultNPC) {
            $dialogueQuery = 'SELECT * FROM NPC_Dialogue WHERE id_npc = :NPCid';
            $dialogueStmt = $db->prepare($dialogueQuery);
            $dialogueStmt->bindParam(':NPCid', $NPCId);
            $dialogueStmt->execute();

            $dialogues = $dialogueStmt->fetchAll(PDO::FETCH_ASSOC);
            if($dialogues){
                $resultNPC['dialogues'] = $dialogues;
            }

            $merchantQuerry = 'SELECT * FROM Merchant WHERE npc_id = :NPCid';
            $merchantStmt = $db->prepare($merchantQuerry);
            $merchantStmt->bindParam(':NPCid', $NPCId);
            $merchantStmt->execute();
            
            $merchant = $merchantStmt->fetch(PDO::FETCH_ASSOC);

            if ($merchant){
                $resultNPC['merchent'] = $merchant;

                $merchantStockQuerry = 'SELECT i.name, ms.stock, ms.price, i.id
                                        FROM MerchantStock ms JOIN Items i ON i.id = ms.item_id 
                                        WHERE merchant_id  = :NPCid';
                $merchantStockStmt = $db->prepare($merchantStockQuerry);
                $merchantStockStmt->bindParam(':NPCid', $NPCId);
                $merchantStockStmt->execute();
                
                $merchantStock = $merchantStockStmt->fetchAll(PDO::FETCH_ASSOC);
                if ($merchantStock){
                    $resultNPC['merchent']['stock'] = $merchantStock;
                }
            }
            $_SESSION['npc'] = $resultNPC;
        }
    }
}
