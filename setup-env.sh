SETUP_PATH=$1

if [ -z $1 ]; then
	SETUP_PATH=.
fi

if ! git --version 2>&1 > /dev/null; then
	echo "Git not found"
	exit -1
fi

if ! python3 --version 2>&1 > /dev/null; then
	echo "Python3 not found"
	exit -1
fi

if ! pip -v 2>&1 > /dev/null; then
	echo "Python PIP not found"
	exit -1
fi

mkdir -p $SETUP_PATH
cd $SETUP_PATH

git clone https://github.com/TimeForBots/Init.git
git clone https://github.com/TimeForBots/Methods.git
git clone https://github.com/TimeForBots/Bots.git
git clone https://github.com/TimeForBots/Media.git

if [[ -r Init && -r Methods && -r Bots && -r Media ]]; then

	sudo pip install python-telegram-bot --upgrade
	
	if [[ ! -z $(pip show python-telegram-bot) ]]; then
		echo "Environment has been successfully set-up"
		exit 1
	else
		echo "Failed to install python telegram bot api"
		exit -1
	fi
else
	echo "Download failed. Discarding any progress on set-up enviroment"
	rm -R Init Methods Bots Media
fi
