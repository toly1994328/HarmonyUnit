interface MeritRecordParams {
  timestamp: number; // 记录的时间戳
  value: number; // 功德数
  image: ResourceStr; // 图片资源
  audio: string; // 音效名称
}

export class MeritRecord {
  readonly timestamp: number;
  readonly value: number;
  readonly image: ResourceStr;
  readonly audio: string;

  constructor(data: MeritRecordParams) {
    this.timestamp = data.timestamp;
    this.value = data.value;
    this.image = data.image;
    this.audio = data.audio;
  }
}