### 替换阿里云Repo

# 配置
BEGIN_TS=`date +%s`
REPO_FILE_PATH="/etc/yum.repos.d/CentOS-Base.repo"
REPO_FILE_BACKUP="/etc/yum.repos.d/CentOS-Base.repo.backup_`date -d @$BEGIN_TS '+%Y%m%d_%H%M%S'`"

# 检查系统信息 [http://zhjwpku.com/2016/11/30/os-identification.html,https://unix.stackexchange.com/questions/111508/bash-test-if-word-is-in-set]
source /etc/os-release

SUCCESS=false
case $ID in
	centos)
		case $VERSION_ID in
			5|6|7)
				# 备份本地Repo
				echo -n "备份Repo ... "
				mv $REPO_FILE_PATH $REPO_FILE_BACKUP \
					&& echo "成功" \
					|| (echo "失败" && exit)
				# 下载阿里云Repo
				REPO_URL="http://mirrors.aliyun.com/repo/Centos-$VERSION_ID.repo"
				echo -n "下载Repo ... "
				wget -q -O $REPO_FILE_PATH $REPO_URL \
					&& echo "成功" && SUCCESS=true \
					|| (echo "失败，URL=$REPO_URL" && mv $REPO_FILE_BACKUP $REPO_FILE_PATH && exit)
				;;
			*)
				echo "不支持的操作系统版本:$ID $VERSION_ID"
				;;
		esac
		;;
	*)
		echo "不支持的操作系统:$ID"
		;;
esac

if $SUCCESS ; then
    echo "刷新缓存 ..."
    yum clean all
	yum makecache
	echo "\n"
	echo "**** Repo更新完毕 ***\n"
else
	echo "所有变更已回滚"
fi
