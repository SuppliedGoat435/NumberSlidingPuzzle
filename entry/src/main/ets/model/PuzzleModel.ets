// 难度枚举（数值即棋盘尺寸）
export enum Difficulty {
  EASY = 3,
  NORMAL = 4,
  HARD = 5
}

// 难度显示配置
export interface DifficultyConfig {
  label: string
  subLabel: string
  difficulty: Difficulty
  color: string
}

export const DIFFICULTY_CONFIGS: DifficultyConfig[] = [
  { label: '简单', subLabel: '3 × 3', difficulty: Difficulty.EASY,   color: '#43BF8E' },
  { label: '普通', subLabel: '4 × 4', difficulty: Difficulty.NORMAL, color: '#6C63FF' },
  { label: '困难', subLabel: '5 × 5', difficulty: Difficulty.HARD,   color: '#FF6584' },
]

// 游戏结果（传给 ResultPage 用）
export interface GameResult {
  steps: number
  seconds: number
  difficulty: Difficulty
}

// 瓦片颜色池
export const TILE_COLORS: string[] = [
  '#6C63FF', '#FF6584', '#43BF8E',
  '#FF9F43', '#54A0FF', '#5F27CD',
  '#EE5A24', '#009432', '#1289A7'
]