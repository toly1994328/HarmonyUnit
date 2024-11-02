import { BusinessError } from '@kit.BasicServicesKit';
import { audio } from '@kit.AudioKit';
import { media } from '@kit.MediaKit';

export class MuyuBloc {
  @Track counter: number = 0;
  private player?: media.SoundPool;
  private ready = false;
  private soundId?: number;

  constructor() {
    this.initAndLoad();
  }

  async initAndLoad() {
    await this.initSoundPool();
    await this.loadSounds();
    this.ready = true;
  }

  async release() {
    await this.player?.release();
    this.ready = false;
  }

  async initSoundPool() {
    this.player = await media.createSoundPool(1, {
      usage: audio.StreamUsage.STREAM_USAGE_GAME,
      rendererFlags: 1
    },)
  }

  async loadSounds() {
    this.soundId = await this.loadSoundId("muyu_3.mp3");
  }

  async loadSoundId(rawFile: string): Promise<number> {
    let res = await getContext().resourceManager.getRawFd(rawFile);
    return new Promise<number>((resolve, reject) => {
      this.player!.load(res.fd, res.offset, res.length, (error, id: number) => {
        if (!error) {
          resolve(id);
        } else {
          reject(error);
        }
      })
    });
  }

  tick(): void {
    if (!this.ready) {
      return;
    }
    this.player?.play(this.soundId);
    this.counter++;
  }
}