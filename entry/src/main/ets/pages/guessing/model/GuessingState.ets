import { CheckResult } from "./CheckResult";
import inputMethod from '@ohos.inputMethod';

export class GuessingState {
  guessing: boolean = false;
  guessCount: number = 0;
  secret: number = 0;
  input: string = '';
  result: CheckResult = CheckResult.none;

  checkResult(): void {
    if (this.input === '' || !this.guessing) {
      return;
    }
    const guess: number = Number(this.input);
    if (Number.isNaN(guess)) {
      return;
    }
    const diff = guess - this.secret;

    if (diff == 0) {
      this.result = CheckResult.equal
      this.guessing = false;
      this.input = ''
    }
    if (diff > 0) {
      this.result = CheckResult.bigger
    }
    if (diff < 0) {
      this.result = CheckResult.smaller
    }
    this.guessCount++;
    inputMethod.getController().stopInputSession();
  }

  start(): void {
    this.guessing = true;
    this.secret = Math.floor(Math.random() * 100);
    this.result = CheckResult.none;
    this.input = '';
    this.guessCount = 0;
  }
}