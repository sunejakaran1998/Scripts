#/bin/bash


echo -e "\n $(tput setaf 1) $(tput bold)Updating Linux packages $(tput sgr0) $(tput sgr 0)\n"

echo -ne 'Progress ====>                     (33%)\r'
sleep 0.3
echo -ne 'Progress =============>            (66%)\r'
sleep 0.3
sudo apt-get update -y &> /dev/null
echo -ne "Progress ========================> (100%)\r"
echo -ne '\n'


echo -e " $(tput setaf 1) $(tput bold)Installing Required Ubuntu Packages$(tput sgr0) $(tput sgr 0) \n"


echo -ne 'Progress ====>                     (33%)\r'
sleep 0.3
sudo apt-get install unzip -y &> /dev/null
echo -ne 'Progress =============>            (66%)\r'
sleep 0.3
sudo apt-get install libwww-perl libdatetime-perl -y &> /dev/null
echo -ne "Progress ========================> (100%)\r"
echo -ne '\n'
sleep 0.3

echo -e " $(tput setaf 1) $(tput bold)Installing Monitoring Scripts$(tput sgr0) $(tput sgr 0) \n"

echo -ne 'Progress ====>                     (33%)\r'
sleep 0.3
curl https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip -O
echo -ne 'Progress =============>            (66%)\r'
sleep 0.3
unzip CloudWatchMonitoringScripts-1.2.2.zip
rm CloudWatchMonitoringScripts-1.2.2.zip
echo -ne "Progress ========================> (100%)\r"
echo -ne '\n'
sleep 0.3

my_working_directory=`pwd`

echo -e " $(tput setaf 1) $(tput bold)Running Simple Test$(tput sgr0) $(tput sgr 0) \n"

${my_working_directory}/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --verify --verbose

echo -e " $(tput setaf 1) $(tput bold)Do you want to coninue for enabling cron for very 5 minustes? Y(yes)/N(No)$(tput sgr0) $(tput sgr 0) \n"
read answer

if [ $answer == "y" ];
then
        echo "inside if"
	sudo echo "*/5 * * * * ~/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron" >> /etc/crontab
else
	echo "BYE..."	
fi

