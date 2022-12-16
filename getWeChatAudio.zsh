#!/bin/zsh

function ScanWebPage {
  WebPage=$(http $1 --body)
  # 下载网页代码
  VoiceID=$(echo ${WebPage} | rg voice_id)
  VoiceName=$(echo ${WebPage} | rg msg_title)
  # VoiceID=$(http $1 --body | rg voice_id)
  # VoiceName=$(http $1 --body | rg msg_title)
  VoiceID=${VoiceID%%\"\,\"sn\"*}
  # 这里是从右向左过滤字符串
  VoiceID=${VoiceID#*voice_id\"\:\"}
  # 这里是从左向右过滤字符
  VoiceName=${VoiceName%%\'.html*}
  VoiceName=${VoiceName#*msg_title = \'}
}

echo "Please enter URL"
read URL
VoiceURL="http://res.wx.qq.com/voice/getvoice?mediaid="
# 微信的音频内容都有一段网址是相同的
SavePath=~/storage/shared/Download/英语视频/
# 保存文件的地址
ScanWebPage ${URL}
echo "VoiceID" ${VoiceID}
echo "VoiceName" ${VoiceName}.mp3
# 输出音频的 ID 和名字
http --download ${VoiceURL}${VoiceID} --output ${SavePath}${VoiceName}.mp3
# 下载音频文件到指定目录
