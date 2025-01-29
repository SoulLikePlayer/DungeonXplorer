<?php

class SoulsModel extends Model{
    public function getSoulById($id){
        //TODO : Getter de soul
    }

    public function getAllCapacityBySoulsId($soulId){
        //TODO : Getter des capacité souls
    }

    public function ApplyHeroEffect($capacityId, $heroId){
        //TODO : Modifier la table HeroCapacity pour le $HeroId a ajouter le $capacityId
    }
}