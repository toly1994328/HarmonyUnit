export enum CheckResult {
  none,
  bigger,
  smaller,
  equal,
}

export function resultLabel(result: CheckResult): string | Resource {
  switch (result) {
    case CheckResult.bigger:
      return '大了';
    case CheckResult.smaller:
      return '小了';
  }
  return '';
}

export function resultColor(result: CheckResult): ResourceColor {
  switch (result) {
    case CheckResult.bigger:
      return '#ff5454';
    case CheckResult.smaller:
      return '#448afc';
  }
  return '';
}

