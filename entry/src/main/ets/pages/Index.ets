import router from '@ohos.router'
import { DIFFICULTY_CONFIGS, DifficultyConfig } from '../model/PuzzleModel'

@Entry
@Component
struct Index {
  build() {
    Column({space:0}) {
      // 标题区
      Column({space:8}) {
        Text('数字华容道').fontSize(36).fontWeight(FontWeight.Bold).fontColor('#2D2D2D')
        Text('滑动数字，还原顺序').fontSize(15).fontColor('#999')
      }.margin({bottom:56})
      // 难度卡片
      ForEach(DIFFICULTY_CONFIGS, (item: DifficultyConfig) => {
        Column({space:4}) {
          Text(item.label).fontSize(20).fontWeight(FontWeight.Bold).fontColor(Color.White)
          Text(item.subLabel).fontSize(14).fontColor('rgba(255,255,255,0.8)')
        }.width(280).height(80).justifyContent(FlexAlign.Center).backgroundColor(item.color).borderRadius(20).margin({ bottom: 16 }).shadow({ radius: 12, color: item.color + '55', offsetY: 6 })
        .onClick(() => {router.pushUrl({ url: 'pages/GamePage', params: { difficulty: item.difficulty } })})
      })
      Text('点击与空格相邻的数字即可移动').fontSize(13).fontColor('#BBBBBB').margin({top:48})
    }.width('100%').height('100%').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).backgroundColor('#F8F7FF')
  }
}