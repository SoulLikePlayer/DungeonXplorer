class AudioManager {
    constructor() {
        if (AudioManager.instance) {
            return AudioManager.instance;
        }

        this.audioKey = 'adventureMusicPlaying';
        this.currentTimeKey = 'adventureMusicCurrentTime';
        this.chapterTypeKey = 'lastChapterType';
        this.baseMusicPath = '../../public/assets/SongTheme/BeginOfTheAdventure.mp3';
        this.audio = new Audio();
        this.audio.loop = true;

        window.addEventListener('beforeunload', () => {
            sessionStorage.setItem(this.currentTimeKey, this.audio.currentTime);
        });

        AudioManager.instance = this;
    }

    async changeMusic(newMusicPath, resumeTime = true) {
        try {
            if (!this.audio.paused) {
                await this.audio.pause();
            }

            const savedTime = sessionStorage.getItem(this.currentTimeKey);
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

    initializeMusic(newMusicPath) {
        const lastChapterType = sessionStorage.getItem(this.chapterTypeKey);
        const currentChapterType = document.querySelector('main').getAttribute('data-chapter-type');

        const resumeTime = lastChapterType === currentChapterType;
        sessionStorage.setItem(this.chapterTypeKey, currentChapterType);

        this.changeMusic(newMusicPath, resumeTime);
    }

    handleChapterMusic() {
        const chapterType = document.querySelector('main').getAttribute('data-chapter-type');

        if (chapterType === 'death') {
            this.initializeMusic('../../public/assets/SongTheme/JustAnotherDeath.mp3');
        } else if (chapterType === 'npc_interaction' || chapterType === 'merchent') {
            const npcContainer = document.getElementById('npcContainer');
            const npcOST = npcContainer?.getAttribute('data-ost');
            if (npcOST) {
                this.initializeMusic(`../../public/assets/SongTheme/${npcOST}.mp3`);
            }else{
                this.initializeMusic(this.baseMusicPath);
            }
        } else if (chapterType === 'combat'){
            this.changeMusic('../../public/assets/SongTheme/FightOrDie.mp3');
        } else {
            this.initializeMusic(this.baseMusicPath);
        }
    }
}

const audioManager = new AudioManager();

document.addEventListener('DOMContentLoaded', () => {
    audioManager.handleChapterMusic();
});
