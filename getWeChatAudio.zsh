#!/bin/zsh
Time=$(date +%s)
http --download $1 --output tmp${Time}.html
#下载网页并保存，以供解析 ID
# $1 是文章的网址
VoiceURL="http://res.wx.qq.com/voice/getvoice?mediaid="
#微信的音频内容都有一段网址是相同的
SavePath=~/Download/
#保存的地址
VoiceID=$(rg voice_id tmp${Time}.html)
VoiceName=$(rg msg_title tmp${Time}.html)
#用 rigrep 解析出 ID 和音频名称
VoiceID=${VoiceID%%\"\,\"sn\"*}
#这里是从右向左过滤字符串
VoiceID=${VoiceID#*voice_id\"\:\"}
#这里是从左向右过滤字符串
VoiceName=${VoiceName%%\'.html*}
VoiceName=${VoiceName#*msg_title = \'}
echo "VoiceID" ${VoiceID}
echo "VoiceName" ${VoiceName}.mp3
#输出音频的 ID 和名字
http --download ${VoiceURL}${VoiceID} --output ${SavePath}${VoiceName}.mp3
#下载音频
#mv ${VoiceName}.mp3 ~/storage/shared/Download/英语视频/${VoiceName}.mp3
#这样方便复制到音箱里面。
rm tmp${Time}.html
#删除保存的临时网页
