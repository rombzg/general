#!/bin/bash
db=7.4
ch="$HOME/Dropbox"
dr=`du -c $ch | grep total | tail -1`
sz=`echo $dr | sed 's/total//g'`
if [ -d $ch/.dropbox.cache ]; then
dc=`du -c $ch/.dropbox.cache | grep total | tail -1`
sc=`echo $dc | sed 's/total//g'`
sz=$sz-$sc
sz=`awk "BEGIN{ print $sz }"`
fi
op="100-((100*($db-$sz/1048576))/$db)"
po=`awk "BEGIN{ print $op }"`
po=${po%.*}
echo $po
