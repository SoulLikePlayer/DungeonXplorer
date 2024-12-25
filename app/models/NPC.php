<?php

class NPC extends Model {
    public function getNPCById($NPCId, $chapterId) {
        $db = $this->getDatabaseConnection();

        $NPCQuery = 'SELECT * FROM NPC WHERE id = :NPCid';
        $NPCStmt = $db->prepare($NPCQuery);
        $NPCStmt->bindParam(':NPCid', $NPCId);
        $NPCStmt->execute();

        $resultNPC = $NPCStmt->fetch(PDO::FETCH_ASSOC);

        if ($resultNPC) {
            $dialogueQuery = 'SELECT * FROM NPC_Dialogue WHERE id_npc = :NPCid AND chapter = :chapterId';
            $dialogueStmt = $db->prepare($dialogueQuery);
            $dialogueStmt->bindParam(':NPCid', $NPCId);
            $dialogueStmt->bindParam(':chapterId', $chapterId);
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

            $heroRaceId = $_SESSION['user']['hero']['race_id'];
            $racismeQuery = 'SELECT * FROM Racisme WHERE npc_id = :NPCid AND race_id = :race_id';
            $racismeStmt = $db->prepare($racismeQuery);
            $racismeStmt->bindParam(':NPCid', $NPCId);
            $racismeStmt->bindParam(':race_id', $heroRaceId);
            $racismeStmt->execute();

            $racisme = $racismeStmt->fetch(PDO::FETCH_ASSOC);

            if ($racisme) {
                $resultNPC['INTRO_SENTENCE'] = $racisme['colère'];

                $merchantQuery = 'SELECT * FROM Merchant_Racisme WHERE npc_id = :NPCid AND race_id = :race_id';
                $merchantStmt = $db->prepare($merchantQuery);
                $merchantStmt->bindParam(':NPCid', $NPCId);
                $merchantStmt->bindParam(':race_id', $heroRaceId);
                $merchantStmt->execute();

                $merchantRacisme = $merchantStmt->fetch(PDO::FETCH_ASSOC);

                if ($merchantRacisme) {
                    if ($merchantRacisme['refus_vente_achat'] === 1) {
                        $resultNPC['merchent']['refus_vente_achat'] = true;
                    }else{
                        $resultNPC['merchent']['refus_vente_achat'] = false;
                    }
                    $resultNPC['merchent']['multiplicateur'] = $merchantRacisme['multiplicateur'];
                }
            }
            $_SESSION['npc'] = $resultNPC;
        }
    }
}
