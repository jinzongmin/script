### Replace repo to aliyun

# 检查系统信息 [http://zhjwpku.com/2016/11/30/os-identification.html,https://unix.stackexchange.com/questions/111508/bash-test-if-word-is-in-set]
source /etc/os-release

if [[ "$ID" =~ ^(centos)$ ]]; then
    #支持的操作系统
else
	#不支持的操作系统
    echo "不支持的操作系统:$ID"
fi

case $ID in
    centos) echo yes;;
    *)             echo no;;
esac

case $ID in
	centos ) 
		case $VERSION_ID in
			6 )
				
				;;
			* )
				echo "不支持的操作系统版本:$ID $VERSION_ID"
		esac
	* )	
		echo "不支持的操作系统:$ID"
		exit
esac

exit

# 备份
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup_`date '+%Y%m%d_%H%M%S'`

#