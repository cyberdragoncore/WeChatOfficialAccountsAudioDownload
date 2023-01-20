#!/bin/zsh

function ScanWebPage {
  WebPage=$(http ${URL} --body)
  VoiceList=$(echo ${WebPage} | rg voice_id)
  VoiceCounter=$(echo ${VoiceList} | rg -o "voice_id" | wc -l)
  VoiceName=$(echo ${WebPage} | rg msg_title)
  # VoiceID=$(http $1 --body | rg voice_id)
  # VoiceName=$(http $1 --body | rg msg_title)
  # VoiceID=${VoiceID%%\"\,\"sn\"*}
  #这里是从右向左过滤字符串
  # VoiceID=${VoiceID#*voice_id\"\:\"}
  #这里是从左向右过滤字符
  VoiceName=${VoiceName%%\'.html*}
  VoiceName=${VoiceName#*msg_title = \'}
}

function GetVoiceID {
  VoiceList=${VoiceList#*voice_id\"\:\"}
  VoiceID=${VoiceList:0:28}
}

function DownloadVoice {
  echo "VoiceID: " ${VoiceID}
  RenameFiles
  echo "VoiceName: " ${VoiceName}${i}.mp3
  http --download ${VoiceURL}${VoiceID} --output ${SavePath}${VoiceName}${i}.mp3
}

function RenameFiles {
  result=$(rg "|" ${VoiceName})
  if [[ -n result ]]; then
    VoiceName=${VoiceName#*\|}
  fi
}

echo "Please enter URL"
read URL
VoiceURL="http://res.wx.qq.com/voice/getvoice?mediaid="
#微信的音频内容都有一段网址是相同的
SavePath=~/storage/shared/Download/英语/
#保存的地址
ScanWebPage

if [[ ${VoiceCounter} == "0" ]]; then
  echo "No audio files found on this page!"
  read noinfo
  exit 0
else
  echo "There are ${VoiceCounter} audio files in the web page."
fi

for i in {1..${VoiceCounter}}
do
  echo "Download " ${i}
  GetVoiceID
  DownloadVoice
done
#输出音频的 ID 和名字
# http --download ${VoiceURL}${VoiceID} --output ${SavePath}${VoiceName}.mp3
#下载音频
