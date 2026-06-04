export class PuzzleUtil {

  static generateBoard(size: number): number[] {
    const board: number[] = []
    for (let i = 1; i < size * size; i++) {
      board.push(i)
    }
    board.push(0)
    return board
  }

  static shuffle(board: number[], size: number): number[] {
    let arr: number[] = [...board]
    do {
      for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1))
        // ✅ 不用解构赋值，改用临时变量交换
        const temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
      }
    } while (!PuzzleUtil.isSolvable(arr, size) || PuzzleUtil.isSolved(arr))
    // ✅ 静态方法用类名调用，不用 this
    return arr
  }

  static isSolvable(board: number[], size: number): boolean {
    let inversions = 0
    const flat: number[] = board.filter(x => x !== 0)
    for (let i = 0; i < flat.length - 1; i++) {
      for (let j = i + 1; j < flat.length; j++) {
        if (flat[i] > flat[j]) inversions++
      }
    }
    if (size % 2 === 1) {
      return inversions % 2 === 0
    } else {
      const zeroRow = Math.floor(board.indexOf(0) / size)
      const rowFromBottom = size - zeroRow
      return rowFromBottom % 2 === 1 ? inversions % 2 === 0 : inversions % 2 === 1
    }
  }

  static isSolved(board: number[]): boolean {
    for (let i = 0; i < board.length - 1; i++) {
      if (board[i] !== i + 1) return false
    }
    return board[board.length - 1] === 0
  }

  static getZeroIndex(board: number[]): number {
    return board.indexOf(0)
  }

  static canMove(index: number, zeroIndex: number, size: number): boolean {
    const row = Math.floor(index / size)
    const col = index % size
    const zeroRow = Math.floor(zeroIndex / size)
    const zeroCol = zeroIndex % size
    return Math.abs(row - zeroRow) + Math.abs(col - zeroCol) === 1
  }

  static move(board: number[], index: number, zeroIndex: number): number[] {
    const newBoard: number[] = [...board]
    // ✅ 同样改用临时变量交换
    const temp = newBoard[index]
    newBoard[index] = newBoard[zeroIndex]
    newBoard[zeroIndex] = temp
    return newBoard
  }

  static formatTime(seconds: number): string {
    const m = Math.floor(seconds / 60).toString().padStart(2, '0')
    const s = (seconds % 60).toString().padStart(2, '0')
    return `${m}:${s}`
  }

  static getTileColor(num: number, colors: string[]): string {
    return colors[(num - 1) % colors.length]
  }
}