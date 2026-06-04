import router from '@ohos.router'
import { Difficulty } from '../model/PuzzleModel'
import { PuzzleUtil } from '../utils/PuzzleUtil'

interface ResultParams {
  steps: number
  seconds: number
  difficulty: Difficulty
}

@Entry
@Component
struct ResultPage {
  @State steps: number = 0
  @State seconds: number = 0
  @State difficulty: Difficulty = Difficulty.NORMAL

  aboutToAppear() {
    const params = router.getParams() as ResultParams
    this.steps = params?.steps ?? 0
    this.seconds = params?.seconds ?? 0
    this.difficulty = params?.difficulty ?? Difficulty.NORMAL
  }

  private getDifficultyLabel(): string {
    if (this.difficulty === Difficulty.EASY) return '简单 3×3'
    if (this.difficulty === Difficulty.HARD) return '困难 5×5'
    return '普通 4×4'
  }

  private getRating(): string {
    if (this.seconds < 30) return '⚡ 神速！'
    if (this.seconds < 60) return '🔥 优秀！'
    if (this.seconds < 120) return '👍 不错！'
    return '💪 继续加油！'
  }

  build() {
    Column({space:0}) {
      // 顶部装饰区
      Column({space:12}) {
        Text('🏆').fontSize(64)
        Text(this.getRating()).fontSize(26).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
        Text('游戏结算').fontSize(14).fontColor('#999')
      }.width('100%').padding({top:60,bottom:40}).alignItems(HorizontalAlign.Center)
      // 成绩卡片
      Column({space:0}) {
        // 难度
        Row() {
          Text('难度').fontSize(15).fontColor('#666')
          Blank()
          Text(this.getDifficultyLabel()).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#2D2D2D')
        }.width('100%').padding({top:18,bottom:18})
        Divider().color('#F0F0F0')
        // 用时
        Row() {
          Text('用时').fontSize(15).fontColor('#666')
          Blank()
          Text(PuzzleUtil.formatTime(this.seconds)).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#6C63FF')
        }.width('100%').padding({top:18,bottom:18})
        Divider().color('#F0F0F0')
        // 步数
        Row() {
          Text('步数').fontSize(15).fontColor('#666')
          Blank()
          Text(`${this.steps} 步`).fontSize(15).fontWeight(FontWeight.Medium).fontColor('#FF6584')
        }.width('100%').padding({top:18,bottom:18})
        Divider().color('#F0F0F0')
        // 效率（步/分钟）
        Row() {
          Text('效率').fontSize(15).fontColor('#666')
          Blank()
          Text(this.seconds>0?`${Math.round(this.steps/(this.seconds/60))} 步/分钟`:'--').fontSize(15).fontWeight(FontWeight.Medium).fontColor('#43BF8E')
        }.width('100%').padding({top:18,bottom:18})
      }.width('88%').padding({left:20,right:20}).backgroundColor(Color.White).borderRadius(20).shadow({radius:16,color:'#0F000000',offsetY:4})
      // 按钮区
      Column({ space: 12 }) {
        Button('再玩一局').width('88%').height(52).fontSize(17).fontColor(Color.White).backgroundColor('#6C63FF').borderRadius(26).onClick(()=>router.back())
        Button('返回首页').width('88%').height(52).fontSize(17).fontColor('#555').backgroundColor('#F0F0F0').borderRadius(26).onClick(()=>{router.clear();router.pushUrl({url:'pages/Index'})})
      }.margin({top:36})
    }.width('100%').height('100%').backgroundColor('#F8F7FF').alignItems(HorizontalAlign.Center)
  }
}