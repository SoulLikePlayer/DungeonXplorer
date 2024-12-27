/**
 * AudioManager: Un gestionnaire de musique pour l'application.
 *
 * Cette classe est implémentée comme un singleton afin d'assurer qu'une seule instance
 * du gestionnaire de musique est active à tout moment. Cela garantit la centralisation
 * du contrôle sur la lecture audio, notamment pour gérer les transitions de musique
 * entre différents types de chapitres dans l'application.
 *
 * Pourquoi Singleton :
 * - Une seule instance permet de partager l'état de l'audio (ex. : lecture, time code) partout.
 * - Réduit les erreurs potentielles dues à plusieurs gestionnaires audio actifs simultanément.
 * - Simplifie le stockage de l'état dans `sessionStorage` et son utilisation.
 */
 class AudioManager {
    constructor() {
        if (AudioManager.instance) {
            return AudioManager.instance;
        }

        this.audioKey = 'adventureMusicPlaying';
        this.currentTimeKey = 'adventureMusicCurrentTime';
        this.chapterTypeKey = 'lastChapterType';
        this.lastOSTKey = 'lastOSTPath'; // Ajout pour suivre l'OST en cours
        this.baseMusicPath = '../../public/assets/SongTheme/BeginOfTheAdventure.mp3';
        this.combatMusicPath = '../../public/assets/SongTheme/FightOrDie.mp3';
        this.audio = new Audio();
        this.audio.loop = true;

        // Sauvegarde du time code de la musique avant le déchargement de la page
        window.addEventListener('beforeunload', () => {
            sessionStorage.setItem(this.currentTimeKey, this.audio.currentTime);
        });

        AudioManager.instance = this;
    }

    /**
     * Met à jour les chemins des musiques selon les attributs du DOM.
     *
     * Cette méthode extrait les chemins personnalisés pour les musiques normales
     * et de combat depuis les attributs `data-ost-normal` et `data-ost-combat`.
     */
    updateMusicPaths() {
        const mainElement = document.querySelector('main');
        const ostNormal = mainElement.getAttribute('data-ost-normal');
        const ostCombat = mainElement.getAttribute('data-ost-combat');

        if (ostNormal && ostNormal !== 'Aucun') {
            this.baseMusicPath = `../../public/assets/SongTheme/${ostNormal}`;
        }
        if (ostCombat && ostCombat !== 'Aucun') {
            this.combatMusicPath = `../../public/assets/SongTheme/${ostCombat}`;
        }
    }

    /**
     * Change la musique actuelle vers une nouvelle piste.
     *
     * @param {string} newMusicPath - Le chemin de la nouvelle musique.
     * @param {boolean} resumeTime - Indique si le time code précédent doit être repris.
     *
     * Cette méthode charge une nouvelle piste audio et commence à la jouer.
     * Si `resumeTime` est `true`, la musique reprendra à partir du dernier time code enregistré.
     */
    async changeMusic(newMusicPath, resumeTime = true) {
        try {
            const savedTime = sessionStorage.getItem(this.currentTimeKey);

            // Si la musique est déjà en cours avec les mêmes paramètres, ne pas changer.
            if (this.audio.src === newMusicPath && !this.audio.paused) {
                console.log("Musique déjà en cours de lecture. Aucun changement nécessaire.");
                return;
            }

            if (!this.audio.paused) {
                await this.audio.pause();
            }

            this.audio.src = newMusicPath;
            this.audio.loop = true;

            this.audio.addEventListener('canplaythrough', async () => {
                if (resumeTime && savedTime) {
                    this.audio.currentTime = parseFloat(savedTime);
                }
                try {
                    await this.audio.play();
                    sessionStorage.setItem(this.audioKey, 'true');
                } catch (error) {
                    console.error('Erreur de lecture audio:', error);
                }
            }, { once: true });

            this.audio.load();
        } catch (error) {
            console.error('Erreur lors du changement de musique:', error);
        }
    }

    /**
     * Initialise la musique selon le type de chapitre actuel.
     *
     * @param {string} newMusicPath - Le chemin de la nouvelle musique.
     *
     * Cette méthode vérifie si le type de chapitre est identique au précédent
     * et si l'OST est la même, pour éviter de redémarrer la musique inutilement.
     */
    async initializeMusic(newMusicPath) {
        const lastChapterType = sessionStorage.getItem(this.chapterTypeKey);
        const lastOSTPath = sessionStorage.getItem(this.lastOSTKey);
        const currentChapterType = document.querySelector('main').getAttribute('data-chapter-type');

        const resumeTime = lastChapterType === currentChapterType && lastOSTPath === newMusicPath;
        sessionStorage.setItem(this.chapterTypeKey, currentChapterType);
        sessionStorage.setItem(this.lastOSTKey, newMusicPath);

        if (resumeTime && this.audio.src === newMusicPath && !this.audio.paused) {
            try {
                console.log("Reprise de la musique existante.");
                await this.audio.play();
            } catch (error) {
                console.error('Erreur lors de la reprise audio:', error);
            }
        } else {
            this.changeMusic(newMusicPath, resumeTime);
        }
    }

    /**
     * Gère la musique à jouer selon le type de chapitre.
     *
     * Cette méthode détermine le type de chapitre actuel (combat, mort, interaction, etc.)
     * et ajuste la musique en conséquence. Elle vérifie également les OST personnalisées.
     */
    handleChapterMusic() {
        this.updateMusicPaths();

        const chapterType = document.querySelector('main').getAttribute('data-chapter-type');

        if (chapterType === 'death') {
            this.initializeMusic('../../public/assets/SongTheme/JustAnotherDeath.mp3');
            console.log("mort");
        } else if (chapterType === 'npc_interaction' || chapterType === 'merchent') {
            const npcContainer = document.getElementById('npcContainer');
            const npcOST = npcContainer?.getAttribute('data-ost');
            if (npcOST) {
                console.log("ost personnalisé");
                this.initializeMusic(`../../public/assets/SongTheme/${npcOST}.mp3`);
            } else {
                this.initializeMusic(this.baseMusicPath);
            }
        } else if (chapterType === 'combat') {
            console.log("combat");
            this.initializeMusic(this.combatMusicPath);
        } else {
            console.log("normal");
            this.initializeMusic(this.baseMusicPath);
        }
    }
}

const audioManager = new AudioManager();

document.addEventListener('DOMContentLoaded', () => {
    audioManager.handleChapterMusic();
});
