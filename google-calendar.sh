#!/bin/bash
WGET=wget
ICS2ORG=ical2orgpy

DEV_ICSFILE=~/org/gcal-developer.ics
DEV_URL=https://calendar.google.com/calendar/ical/selva.developer%40gmail.com/private-55c78769215b5f36a3f14d6d6fd9d04f/basic.ics
DEV_ORGFILE=~/org/gcal-developer.org

PRO_ICSFILE=~/org/gcal-profession.ics
PRO_URL=https://calendar.google.com/calendar/ical/selva.on.profession%40gmail.com/private-f9bcae9409c369949ba78b81789919fd/basic.ics
PRO_ORGFILE=~/org/gcal-profession.org

$WGET -O $DEV_ICSFILE $DEV_URL
$WGET -O $PRO_ICSFILE $PRO_URL

lxc exec scratch -- sh -c "/home/ubuntu/go/bin/ical2org --scheduled $DEV_URL" >$DEV_ORGFILE
lxc exec scratch -- sh -c "/home/ubuntu/go/bin/ical2org --scheduled $PRO_URL" >$PRO_ORGFILE
