import { CheckResult } from "./CheckResult";

export class GuessingState{
  guessing: boolean = false;
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
      this.input =''
    }
    if (diff > 0) {
      this.result = CheckResult.bigger
    }
    if (diff < 0) {
      this.result = CheckResult.smaller
    }
  }

  start(): void {
    this.guessing = true;
    this.secret = Math.floor(Math.random() * 100);
    this.result = CheckResult.none;
    this.input =''
  }

}