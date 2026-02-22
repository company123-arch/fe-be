#!/bin/bash

LOGFILE="/home/ubuntu/deploy.log"

echo "=========================" >> $LOGFILE
echo "Deployment started at $(date)" >> $LOGFILE

cd /home/ubuntu/fe-be || exit

echo "Pulling latest code..." >> $LOGFILE
git pull origin main >> $LOGFILE 2>&1

echo "Installing backend dependencies..." >> $LOGFILE
cd backend
npm install >> $LOGFILE 2>&1

echo "Restarting backend with PM2..." >> $LOGFILE
pm2 restart all >> $LOGFILE 2>&1

echo "Building frontend..." >> $LOGFILE
cd ../frontend
npm install >> $LOGFILE 2>&1
npm run build >> $LOGFILE 2>&1

echo "Deploying frontend to Nginx..." >> $LOGFILE
sudo rm -rf /var/www/html/*
sudo cp -r build/* /var/www/html/

echo "Deployment completed at $(date)" >> $LOGFILE
echo "=========================" >> $LOGFILE
