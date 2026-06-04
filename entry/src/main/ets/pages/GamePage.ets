import router from '@ohos.router'
import { GameViewModel } from '../viewmodel/GameViewModel'
import { Difficulty } from '../model/PuzzleModel'

@Entry
@Component
struct GamePage {
  @State vm: GameViewModel = new GameViewModel()

  aboutToAppear() {
    const params = router.getParams() as Record<string, number>
    const diff = (params?.['difficulty'] ?? Difficulty.NORMAL) as Difficulty
    this.vm.init(diff)
  }

  aboutToDisappear() {
    this.vm.stopTimer()
  }

  build(){
    Stack(){
      Column({space:0}){
        // 顶部导航栏
        Row(){
          Image($r('app.media.back')).width(24).height(24).onClick(()=>{this.vm.stopTimer();router.back()})
          Blank()
          Text('数字华容道').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
          Blank()
          Image($r('app.media.refresh')).width(24).height(24).onClick(()=>this.vm.restart())
        }.width('100%').padding({left:20,right:20,top:16,bottom:16})
        // 状态栏（步数 + 时间）
        Row(){
          Column({space:4}){
            Text('步数').fontSize(12).fontColor('#999')
            Text(`${this.vm.steps}`).fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)
          Divider().vertical(true).height(40).color('#E0E0E0')
          Column({space:4}){
            Text('时间').fontSize(12).fontColor('#999')
            Text(this.vm.timeDisplay).fontSize(28).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
          }.layoutWeight(1).alignItems(HorizontalAlign.Center)
        }.width('100%').padding({top:8,bottom:24})
        // 棋盘
        Grid(){
          ForEach(this.vm.board,(num:number,index:number)=>{
            GridItem(){
              if (num===0){
                Row().width('100%').height('100%').backgroundColor('#EFEFEF').borderRadius(10)
              } else {
                Text(`${num}`).width('100%').height('100%').textAlign(TextAlign.Center).fontSize(this.vm.tileFontSize).fontWeight(FontWeight.Bold).fontColor(Color.White).backgroundColor(this.vm.getTileColor(num)).borderRadius(10).animation({duration:120,curve:Curve.EaseOut})
              }
            }.onClick(()=>this.vm.tap(index))
          })
        }.columnsTemplate(this.vm.getGridTemplate()).rowsTemplate(this.vm.getGridTemplate()).columnsGap(8).rowsGap(8).width(348).height(348).padding(12).backgroundColor(Color.White).borderRadius(20).shadow({radius:16,color:'#1A6C63FF',offsetY:8})
      }.width('100%').height('100%').backgroundColor('#F8F7FF').alignItems(HorizontalAlign.Center)
      // 完成弹窗（Stack 叠加层）
      if (this.vm.isCompleted){
        // 半透明遮罩
        Row().width('100%').height('100%').backgroundColor('rgba(0,0,0,0.4)')
        // 弹窗卡片
        Column({space:16}){
          Text('🎉').fontSize(48)
          Text('恭喜完成！').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
          Row({space:32}){
            Column({space:4}){
              Text(this.vm.timeDisplay).fontSize(22).fontWeight(FontWeight.Bold).fontColor('#6C63FF')
              Text('用时').fontSize(12).fontColor('#999')
            }
            Column({space:4}){
              Text(`${this.vm.steps}`).fontSize(22).fontWeight(FontWeight.Bold).fontColor('#FF6584')
              Text('步数').fontSize(12).fontColor('#999')
            }
          }.padding({top:8,bottom:8})
          Row({space:12}){
            Button('再来一局').width(130).height(48).fontSize(16).backgroundColor('#6C63FF').fontColor(Color.White).borderRadius(24).onClick(()=>this.vm.restart())
            Button('返回首页').width(130).height(48).fontSize(16).backgroundColor('#F0F0F0').fontColor('#555').borderRadius(24).onClick(()=>{router.pushUrl({url:'pages/ResultPage',params:{steps:this.vm.steps,seconds:this.vm.seconds,difficulty:this.vm.size}})})
          }
        }.width(320).padding(32).backgroundColor(Color.White).borderRadius(24).shadow({radius:24,color:'#33000000',offsetY:12})
      }
    }.width('100%').height('100%')
  }
}