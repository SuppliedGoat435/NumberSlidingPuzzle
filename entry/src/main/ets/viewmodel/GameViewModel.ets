import { PuzzleUtil } from '../utils/PuzzleUtil'
import { Difficulty, TILE_COLORS } from '../model/PuzzleModel'

@Observed
export class GameViewModel {
  board: number[] = []
  size: number = 4
  steps: number = 0
  seconds: number = 0
  isRunning: boolean = false
  isCompleted: boolean = false
  private timerId: number = -1

  // ── 初始化游戏 ──────────────────────────────
  init(difficulty: Difficulty) {
    this.size = difficulty as number
    this.steps = 0
    this.seconds = 0
    this.isCompleted = false
    this.isRunning = false
    this.stopTimer()
    const base = PuzzleUtil.generateBoard(this.size)
    this.board = PuzzleUtil.shuffle(base, this.size)
    this.startTimer()
    this.isRunning = true
  }

  // ── 点击某个格子 ────────────────────────────
  tap(index: number) {
    if (this.isCompleted || !this.isRunning) return
    const zeroIndex = PuzzleUtil.getZeroIndex(this.board)
    if (!PuzzleUtil.canMove(index, zeroIndex, this.size)) return
    this.board = PuzzleUtil.move(this.board, index, zeroIndex)
    this.steps++
    if (PuzzleUtil.isSolved(this.board)) {
      this.isCompleted = true
      this.stopTimer()
    }
  }

  // ── 重新开始 ────────────────────────────────
  restart() {
    this.init(this.size as Difficulty)
  }

  // ── 计时器 ──────────────────────────────────
  startTimer() {
    this.timerId = setInterval(() => {
      this.seconds++
    }, 1000)
  }

  stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  // ── 计算属性 ────────────────────────────────
  get timeDisplay(): string {
    return PuzzleUtil.formatTime(this.seconds)
  }

  getTileColor(num: number): string {
    return PuzzleUtil.getTileColor(num, TILE_COLORS)
  }

  getGridTemplate(): string {
    return Array(this.size).fill('1fr').join(' ')
  }

  // 根据尺寸自动调整字体
  get tileFontSize(): number {
    if (this.size === 3) return 28
    if (this.size === 4) return 22
    return 16
  }
}