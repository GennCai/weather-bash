#! /bin/bash

set -e

# Source the `json.sh` library.
. "lib/json.sh"

url="http://apis.baidu.com/heweather/weather/free"
apikey="0ae09eed4f3c0267cb6e6ed7e1cdda8f"
city="xian"

usage(){
	echo "使用方法：./weather.sh [城市汉字名称或拼音]"
	echo "默认城市：西安"
}

if [[ $# == 1 ]]; then
	if [[ $1 = "-h" || $1 = "--help" || $1 = "-help" ]]; then
		usage
		exit
	else
		city=$1
	fi
elif [[ $# > 1 ]]; then
		usage
		exit
fi

weather=`curl --silent --header "apikey:$apikey" -G -d "city=$city" $url`

if [[ `echo $weather | grep "unknown city"` ]]; then
	echo "无效的城市名称"
	exit
fi

wTxt=`echo $weather | json | grep "now/cond/txt"`

wTxt=`echo ${wTxt##/H*g}`

echo "现在天气：$wTxt"

